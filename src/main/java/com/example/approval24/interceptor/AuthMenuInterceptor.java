package com.example.approval24.interceptor;

import java.util.Comparator;
import java.util.List;

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
        
        if(authMenus == null || authMenus.isEmpty()) return true;
        
   
        // 현재 URI

        final String uri = req.getRequestURI(); 
        System.out.println("uri확인 : " + uri);

        //현재 페이지 메뉴권한 찾기
        MenuVO pageAuth = authMenus.stream()

            .filter(m -> m.getMenuUrl() != null && !m.getMenuUrl().isEmpty() && uri.startsWith(m.getMenuUrl()))
            
            .max(Comparator.comparingInt(m -> m.getMenuUrl().length()))
            .orElse(null);
        

        if (pageAuth != null) {
            System.out.println("**** 인터셉터: 현재 페이지 권한 찾음 = " + pageAuth.getMenuName());
        } else {
            System.out.println("**** 인터셉터: 현재 페이지 권한을 찾을 수 없음 (URI: " + uri + ")");
        }
            
        // 찾은 권한 정보를 저장
        req.setAttribute("pageAuth", pageAuth);
        
        return true;
    }
}
