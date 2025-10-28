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

    // 로그인 처리
    @PostMapping("/login")
    public String login(
            @RequestParam String loginId,
            @RequestParam String password,
            HttpServletRequest request,
            Model model) {

        
        if (!accountService.login(loginId, password)) {
            model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "login";
        }

        return "index"; // 로그인 후 이동할 페이지
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
