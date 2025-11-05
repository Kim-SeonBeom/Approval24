package com.example.approval24.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.approval24.interceptor.AuthInterceptor;
import com.example.approval24.interceptor.AuthMenuInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AuthInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/login", "/logout", "/css/**", "/js/**", "/images/**", "/resources/**");
        
        registry.addInterceptor(new AuthMenuInterceptor())
        .addPathPatterns("/**")
        .excludePathPatterns("/login","/logout","/css/**","/js/**","/images/**", "/resources/**");
    }
    
    
}
