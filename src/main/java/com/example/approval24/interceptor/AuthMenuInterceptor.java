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
        System.out.println("authMenus 확인");
        System.out.println(authMenus.toString());
        
        if(authMenus == null || authMenus.isEmpty()) return true;
        
   
        // 컨텍스트 포함한 채로 그대로 사용 (예: "/approval24/complain/category/mt1/81")
        String uri = req.getRequestURI();
        System.out.println("URI 확인 : " + uri);

        // menuUrl(null 제외) 중에서 가장 긴 prefix 매칭 선택
        MenuVO pageAuth = authMenus.stream()
            .filter(m -> m != null && m.getMenuUrl() != null && !m.getMenuUrl().isEmpty())
            .filter(m -> {
                String base = m.getMenuUrl(); // 예: "/approval24/complain/category/mt1"
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
