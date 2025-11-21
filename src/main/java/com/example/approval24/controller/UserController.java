package com.example.approval24.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.domain.UserDTO;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.TotalCodeService;
import com.example.approval24.service.UserService;
import com.example.approval24.util.AesEncryptionService;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;
    
    @Autowired
    AccountService accountService;
    
    @Autowired
    TotalCodeService codeService;
    
    @Autowired 
    public AesEncryptionService encryptionService;

    @GetMapping("")
    public String Defalt() {
    	return "redirect:/user/list";
    }
    
    // 사용자 목록 조회 
    @GetMapping("/list")
    public String listUsers(
    		@RequestParam(value = "createDt", required = false) String createDtStr,
            @RequestParam(value = "updateDt", required = false) String updateDtStr,
            /*@RequestParam Map<String, Object> params, 
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,*/
            UserDTO filter,
            HttpSession session,
            Model model) {
    	
    	Long accountId = (Long) session.getAttribute("user");
    	if(accountId == null) {
            return "redirect:/login";
        }
    	
    	Long instId = accountService.findInstIdByAccountId(accountId);
    	
    	filter.setInstId(instId);
    	/*if(instId == null) {
            model.addAttribute("error", "소속 기관을 찾을 수 없습니다.");
            return "common/errorPage"; 
        }
    	if(instId != 1) { //시스템 기관에 속해 있으면. 모든 기관을 보여줌
    		params.put("instId", instId);
    	}*/
    	
    	filter.applyDateStrings(createDtStr, updateDtStr);
    	
    	// 최초 진입 (빈 리스트)
		if (filter.isEmptyFilter()) {
			model.addAttribute("userList", Collections.emptyList());
			model.addAttribute("filter", filter);
			model.addAttribute("totalCount", 0);
			model.addAttribute("totalPages", 0);
			return "B/userList";
		}
		
		// 조건 검색
		int totalCount = userService.countInsts(filter);
		List<UserDTO> userList = userService.searchInsts(filter);
		
		model.addAttribute("userList", userList);
		model.addAttribute("filter", filter);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));
        return "B/userList";
    }

    //사용자 상세 조회 
    @GetMapping("/detail/{userNo}")
    public String detailUser(@PathVariable Long userNo, Model model, RedirectAttributes rttr) {
        UserDTO user = userService.getUserDetailByUserNo(userNo);
        if (user == null) {
            rttr.addFlashAttribute("errorMessage", "존재하지 않거나 삭제된 사용자입니다.");
            return "redirect:/user/list"; 
        }
 
        Map<String, Object> filterMap = new HashMap<> ();
        filterMap.put("userNo", userNo);
		List<AccountDTO> accountList = accountService.getAccountsByFilter(filterMap);
		
		// 복호화
		String userResidentNo = null;
		try {
			userResidentNo = encryptionService.decrypt(user.getUserResidentNo());
			String ResidentNo = encryptionService.maskResidentNo(userResidentNo);
			user.setUserResidentNo(ResidentNo);
		} catch (Exception e) {
			rttr.addFlashAttribute("errorMessage", "정보를 가져오는 도중 에러가 발생했습니다. " + e.getMessage());
		}
		
		
		model.addAttribute("user", user);
	    model.addAttribute("accountList", accountList);
        return "B/userDetail"; 
    }
    
    //사용자 등록
    @GetMapping("/create")
    public String createUserForm(Model model) {
        model.addAttribute("user", new UserDTO());
        List<TotalCodeDTO> codes = codeService.getTotalCodeByGroupId("A0");
        model.addAttribute("codes",codes);
        return "B/userForm";
    }

    //사용자 등록/재활성화
    @PostMapping("/create")
    public String registerUser(@ModelAttribute("user") UserDTO user, RedirectAttributes rttr, HttpSession session) {
        try {
            Long currentUserId = (Long)session.getAttribute("user");
            if(currentUserId == null) return "redirect:/login";
            user.setCreateId(currentUserId); 
            
            int result = userService.registerUser(user);

            if (result > 0) {
                rttr.addFlashAttribute("successMessage", "사용자가 성공적으로 등록되었습니다.");
            } else {
                rttr.addFlashAttribute("errorMessage", "사용자 등록에 실패했습니다.");
            }
        } catch (IllegalArgumentException e) {
            rttr.addFlashAttribute("errorMessage", e.getMessage()); 
            return "redirect:/user/create";
        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", "처리 중 예상치 못한 오류가 발생했습니다.");
        }

        return "redirect:/user/list";
    }
    

    // 수정
    @PostMapping("/edit")
    public String editUserAndAccounts(
        @ModelAttribute UserDTO user,
        @RequestParam MultiValueMap<String, String> params,
        HttpSession session,
        RedirectAttributes rttr) {
    	
    	Long updateId = (Long) session.getAttribute("user");
    	List<AccountDTO> accountList = new ArrayList<>();

        int index = 0;
        while (true) {
            String accountIdKey = String.format("accountList[%d].accountId", index);
            String statusCdKey = String.format("accountList[%d].accountStatusCd", index);
            
            if (!params.containsKey(accountIdKey)) {
                break;
            }

            String accountIdStr = params.getFirst(accountIdKey);
            String statusCd = params.getFirst(statusCdKey);
            
            if (accountIdStr != null && statusCd != null) {
                 try {
                    AccountDTO account = new AccountDTO();
                    
                    Long accountId = Long.valueOf(accountIdStr); 
                    
                    account.setAccountId(accountId);
                    account.setAccountStatusCd(statusCd);
                    account.setUpdateId(updateId);
                    accountList.add(account);
                    
                 } catch (NumberFormatException e) {
                	 
                 }
            }
            
            index++;
        }
        
        try {
   
            if (!accountList.isEmpty()) {
                accountService.updateAccountList(accountList);
                user.setInstId(user.getInstId());
                userService.updateUserInfo(user);
            }

            rttr.addFlashAttribute("successMessage", "사용자 정보 및 계정 상태 수정 성공");
            return "redirect:/user/detail/" + user.getUserNo();

        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", "수정 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/user/detail/" + user.getUserNo();
        }
    }
    
    // 사용자 논리 삭제
    @PostMapping("/delete/{userNo}")
    public String deleteUser(@PathVariable Long userNo, RedirectAttributes rttr,HttpSession session) {
        try {
        	Long currentUserId = (Long)session.getAttribute("user");
            if(currentUserId == null) return "redirect:/login";
            
            int result = userService.deactivateUser(userNo,currentUserId);

            if (result > 0) {
                rttr.addFlashAttribute("successMessage", "사용자가 논리 삭제되었습니다.");
            } else {
                rttr.addFlashAttribute("errorMessage", "사용자 삭제에 실패했습니다. 대상이 존재하지 않습니다.");
            }
        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", "삭제 처리 중 오류가 발생했습니다.");
        }
        
        return "redirect:/user/list";
    }
}