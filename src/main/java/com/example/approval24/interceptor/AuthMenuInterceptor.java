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
        
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath(); 
        
        if (uri.startsWith(contextPath + "/ws")) { //웹소켓 이건 제외
            System.out.println("⭐ Auth Interceptor PASS: WebSocket 경로 (" + uri + ")");
            return true;
        }
        
        // 기존 권한 체크 로직 시작
        HttpSession session = req.getSession(false);
        if (session == null) {
            // 세션이 없으면 일단 통과시키거나, 혹은 로그인 페이지로 리다이렉트하는 기존 로직 유지
            // 여기서는 기존 코드의 흐름을 따라 세션이 없으면 통과(true) 시킵니다.
            return true;
        }

        @SuppressWarnings("unchecked")
        List<MenuVO> authMenus = (List<MenuVO>) session.getAttribute("authMenus");

        if(authMenus == null || authMenus.isEmpty()) {
            // 권한 메뉴가 없으면 로그인 페이지로 리다이렉트 (기존 로직)
            res.sendRedirect(req.getContextPath() + "/login");
            return false; 
        }

        System.out.println("URI 확인 : " + uri);

        // menuUrl(null 제외) 중에서 가장 긴 prefix 매칭 선택
        MenuVO pageAuth = authMenus.stream()
            .filter(m -> m != null && m.getMenuUrl() != null && !m.getMenuUrl().isEmpty())
            .filter(m -> {
                String base = m.getMenuUrl();
                // 세그먼트 경계 고려: 완전일치 또는 "/..."로 이어질 때만 인정
                return uri.equals(base) || uri.startsWith(base + "/");
            })
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