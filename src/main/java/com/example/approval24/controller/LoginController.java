package com.example.approval24.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

        Long accountID = accountService.login(loginId, password);
        if (accountID == null) {
            model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "login";
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", accountID);
        session.setAttribute("authMenus", accountService.getAuthMenus(accountID));

        return "/index";
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
