package com.example.approval24.interceptor;

import java.util.List;
import java.util.Objects;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.example.approval24.domain.MenuVO;

public class AuthMenuInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
        HttpSession session = req.getSession(false);
        if (session == null) return true;

        @SuppressWarnings("unchecked")
        List<MenuVO> authMenus = (List<MenuVO>) session.getAttribute("authMenus");
        System.out.println("***()()()()()()()()()****");
        if(authMenus == null) return true;
        System.out.println(authMenus.toString());
        
        
        if (authMenus == null || authMenus.isEmpty()) return true;

        final String ctx = req.getContextPath();
        final String uri = ctx != null && !ctx.isEmpty() && req.getRequestURI().startsWith(ctx)
                ? req.getRequestURI().substring(ctx.length())
                : req.getRequestURI();
                System.out.println("uri확인 : " + uri);

        // 현재 페이지 메뉴권한 찾기
        MenuVO pageAuth = authMenus.stream()
                .filter(m -> m.getMenuUrl() != null)
                .filter(m -> Objects.equals(m.getMenuUrl(), uri) || Objects.equals(m.getMenuUrl(), ctx + uri))
                .findFirst()
                .orElse(null);
 
        req.setAttribute("pageAuth", pageAuth);
        
        
        return true;
    }
}
