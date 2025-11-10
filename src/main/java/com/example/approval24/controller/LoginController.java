package com.example.approval24.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.approval24.domain.AccountDTO;
import com.example.approval24.service.AccountService;

@Controller
public class LoginController {

    @Autowired
    private AccountService accountService;

    // 로그인 페이지
    @GetMapping("/login")
    public String loginPage() {
        return "login"; 
    }

    @PostMapping("/login")
    public String login(
            @RequestParam String loginId,
            @RequestParam String password,
            HttpServletRequest request,
            Model model) {
    	if (loginId == null || loginId.isEmpty() || password == null || password.isEmpty()) {
            model.addAttribute("error", "아이디와 비밀번호를 입력해주세요.");
            return "login";
        }
    
        AccountDTO accountDTO = accountService.login(loginId,password);
        
        if (accountDTO == null) {
            model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "login";
        }
        String status = accountDTO.getAccountStatusCd();
         if("mispassword".equals(status)) {
        	int failCnt = accountDTO.getPwdFailCnt();
        	 model.addAttribute("error", " 비밀번호를 "+ failCnt +" 회 잘못 입력 하였습니다.(최대 5회)");
        	 return "login";
        }else if ("B005".equals(status)) {
            model.addAttribute("error", "계정이 비밀번호 5회 오류로 인해 잠금되었습니다.");
            return "login";
        }
        	
        model.asMap().clear();
        HttpSession session = request.getSession();
        session.setAttribute("user", accountDTO.getAccountId());
        session.setAttribute("authMenus", accountService.getAuthMenus(accountDTO.getAccountId()));
    	
        return "redirect:/";
    }


    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "login";
    }
}
