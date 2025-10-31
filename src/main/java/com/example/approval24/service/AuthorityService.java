package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.AuthorityDAO;
import com.example.approval24.dao.AuthorityMenuDAO;
import com.example.approval24.dao.MenuDAO;
import com.example.approval24.domain.AuthorityDTO;
import com.example.approval24.domain.AuthorityMenuDTO;
import com.example.approval24.domain.MenuDTO;

@Service
public class AuthorityService {

    @Autowired
    private AuthorityDAO authorityDAO;
    
    @Autowired
    private AuthorityMenuDAO authorityMenuDAO;
    
    @Autowired 
    private MenuDAO menuDAO;

    // 전체 권한 목록 조회
    public List<AuthorityDTO> getAllAuthorities() {
        return authorityDAO.findAll();
    }

    // 권한 ID로 상세 조회
    public AuthorityDTO getAuthorityById(Long authorityId) {
        return authorityDAO.findById(authorityId);
    }

    // 권한 등록
    @Transactional
    public void createAuthority(AuthorityDTO authority) {
        authorityDAO.insertAuthority(authority);
    }

    // 권한 수정
    @Transactional
    public void updateAuthority(AuthorityDTO authority) {
        authorityDAO.updateAuthority(authority);
    }

    // 권한 삭제
    @Transactional
    public void deleteAuthority(Long authorityId) {
        authorityDAO.deleteAuthority(authorityId);
    }
    
    //권한 ID로 메뉴 매핑 조회
    public List<AuthorityMenuDTO> getMenusByAuthorityId(Long authorityId) {
        return authorityMenuDAO.findByAuthorityId(authorityId);
    }

    //메뉴 ID로 메뉴 정보 조회 (단일 메뉴 정보)
    public MenuDTO getMenuById(Long menuId) {
        return menuDAO.findById(menuId);
    }

    //권한-메뉴 등록 (한꺼번에 여러 개 가능)
    @Transactional
    public void createAuthorityMenus(List<AuthorityMenuDTO> authorityMenus) {
        for (AuthorityMenuDTO am : authorityMenus) {
            authorityMenuDAO.insertAuthorityMenu(am);
        }
    }
    
    //업데이트
    @Transactional
    public void updateAuthorityMenu(AuthorityMenuDTO authorityMenu) {
        authorityMenuDAO.updateAuthorityMenu(authorityMenu);
    }
    
    //권한-메뉴 삭제 (특정 메뉴 하나씩)
    @Transactional
    public void deleteAuthorityMenu(Long authorityId, Long menuId) {
        authorityMenuDAO.deleteAuthorityMenu(authorityId, menuId);
    }

    // 전체 메뉴 조회
    public List<MenuDTO> getAllMenus() {
        return menuDAO.findAll();
    }
}
