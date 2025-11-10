package com.example.approval24.controller;

import java.util.ArrayList;
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
import com.example.approval24.domain.PageInfoVO;
import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.domain.UserDTO;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.TotalCodeService;
import com.example.approval24.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;
    
    @Autowired
    AccountService accountService;
    
    @Autowired
    TotalCodeService codeService;

    // 사용자 목록 조회 
    @GetMapping("/list")
    public String listUsers(
            @RequestParam Map<String, Object> params, 
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            HttpSession session,
            Model model
    ) {
    	Long accountId = (Long) session.getAttribute("user");
    	if(accountId == null) {
            return "redirect:/login";
        }
    	
    	Long instId = accountService.findInstIdByAccountId(accountId);
    	if(instId == null) {
            model.addAttribute("error", "소속 기관을 찾을 수 없습니다.");
            return "common/errorPage"; 
        }
    	if(instId != 1) { //시스템 기관에 속해 있으면. 모든 기관을 보여줌
    		params.put("instId", instId);
    	}
        // 페이징 파라미터를 Map에 추가
        params.put("page", page);
        params.put("pageSize", pageSize);
        
        // 총 항목 수 조회
        int totalCount = userService.countUsersByFilter(params); 
        
        // PageInfoVO 생성 
        PageInfoVO pageInfo = new PageInfoVO(page, pageSize, totalCount);

        // 오라클 RNUM을 위한 시작/종료 로우를 Map에 추가
        params.put("startRow", pageInfo.getStartRow());
        params.put("endRow", pageInfo.getEndRow());
        
        // 페이징된 목록 조회 (Map을 받아 필터 및 페이징 적용)
        List<UserDTO> users = userService.getUsers(params);
        
        // Model에 데이터 담기
        List<TotalCodeDTO> codes = codeService.getTotalCodeByGroupId("A0");
        
        model.addAttribute("users", users);
        model.addAttribute("codes", codes);
        model.addAttribute("pageInfo", pageInfo); 
        model.addAttribute("params", params); 
        model.addAttribute("loggedInInstId", instId);

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