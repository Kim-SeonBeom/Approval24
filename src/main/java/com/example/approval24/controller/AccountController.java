package com.example.approval24.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.PageInfoVO;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.DeptService;
import com.example.approval24.service.TotalCodeService;

@Controller
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private AccountService accountService;
    @Autowired
    private DeptService deptService;
    @Autowired
    private TotalCodeService codeService;

    @GetMapping("/list")
    public String getAccountList(
    		HttpSession session,
    		@RequestParam Map<String, Object> params,
    		@RequestParam(value = "page", defaultValue = "1") int page,
    	    @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
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
        
    	// 총 항목 수 조회 
        int totalCount = accountService.countAccountsByFilter(params); 
        
        // PageInfoVO 생성
        PageInfoVO pageInfo = new PageInfoVO(page, pageSize, totalCount);
        
        //  페이징 계산 결과를 맵에 담아 DAO로 전달
        params.put("startRow", pageInfo.getStartRow());
        params.put("endRow", pageInfo.getEndRow());
        
        // 목록 조회 (필터 및 페이징 적용)
        List<AccountDTO> accounts = accountService.getAccountsByFilter(params);
        
        // Model에 데이터 전달
        model.addAttribute("pageInfo", pageInfo); 
        model.addAttribute("accounts", accounts); 
        model.addAttribute("instId", instId);
        
        return "B/accountList";
    }
}