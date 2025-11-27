package com.example.approval24.interceptor;

import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.example.approval24.domain.MenuVO;

public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
        
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        HttpSession session = req.getSession(false);
        
        // 세션이 없거나, 세션에 "user" 정보가 없으면 미로그인으로 판단
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(contextPath + "/login");
            return false;
        }
        
        // 제외 경로 처리 (웹소켓, API)
        if (uri.startsWith(contextPath + "/ws") || 
        		uri.startsWith(contextPath + "/api") ||
        		uri.startsWith(contextPath + "/topic") || 
        		uri.startsWith(contextPath + "/app")) {
            return true;
        }

        
        @SuppressWarnings("unchecked")
        List<MenuVO> authMenus = (List<MenuVO>) session.getAttribute("authMenus");

        if (authMenus == null || authMenus.isEmpty()) {
            res.sendRedirect(contextPath + "/login");
            return false;
        }
 

        // URI와 가장 잘 매칭되는 메뉴 권한 찾기
        MenuVO pageAuth = authMenus.stream()
            .filter(m -> m != null && m.getMenuUrl() != null && !m.getMenuUrl().isEmpty())
            .filter(m -> {
                String base = m.getMenuUrl();
                return uri.equals(base) || uri.startsWith(base + "/");
            })
            .max(Comparator.comparingInt(m -> m.getMenuUrl().length()))
            .orElse(null);

        // 결과 저장 및 통과
        if (pageAuth == null) {
            res.sendRedirect(req.getContextPath() + "/accessDenied");     
            return false;

        } else {
            if ("Y".equals(pageAuth.getReadYn())) {
                req.setAttribute("pageAuth", pageAuth);
                return true; 
            } 
            else {
                res.sendRedirect(req.getContextPath() + "/accessDenied");     
                return false;
            }
        } 
    }
}