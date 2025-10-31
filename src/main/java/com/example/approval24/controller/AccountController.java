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
import com.example.approval24.service.AccountService;

@Controller
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private AccountService accountService;

    /**
     * 계정 목록 조회
     * GET /account/list
     * 필터: loginId, userName, deptId, accountStatus, startDate, endDate
     */
    @GetMapping("/list")
    public String getAccountList(
    		HttpSession session,
            @RequestParam(required = false) String loginId,
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) String deptId,
            @RequestParam(required = false) String accountStatus,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            Model model
    ) {
    	
    	//임시
    	String instId = "5";
    	
        Map<String, Object> params = new HashMap<>();
        params.put("instId", instId);
        params.put("loginId", loginId);
        params.put("userName", userName);
        params.put("deptId", deptId);
        params.put("accountStatus", accountStatus);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        
        List<AccountDTO> accounts = accountService.getAccountsByFilter(params);
        model.addAttribute("accounts", accounts); 

        return "B/accountList";
    }

    /**
     * 계정 상태 변경
     
    @PostMapping("/update")
    public String updateAccountStatus(
            @RequestParam String accountId,
            @RequestParam String newStatus
    ) {
        // 간단한 예시: 서비스 호출로 상태 변경
        boolean updated = accountService.updateAccountStatus(accountId, newStatus);
        return updated ? "SUCCESS" : "FAIL";
    */
}
