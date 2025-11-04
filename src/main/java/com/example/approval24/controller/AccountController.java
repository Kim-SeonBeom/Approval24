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
            @RequestParam(required = false) String loginId,
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) String deptId,
            @RequestParam(required = false) String accountStatus,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
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
        
        model.addAttribute("deptList", deptService.deptByInst(instId));
        model.addAttribute("statusList", codeService.getTotalCodeByGroupId("B0"));

        return "B/accountList";
    }
}
