package com.example.approval24.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.MenuDAO;
import com.example.approval24.domain.MenuDTO;

@Service
public class MenuService {

    @Autowired
    private MenuDAO menuDAO;

    // 전체 메뉴 조회
    public List<MenuDTO> getAllMenus() {
        return menuDAO.findAll();
    }

    // 메뉴 아이디로 상세 조회
    public MenuDTO getMenuById(Long menuId) {
        return menuDAO.findById(menuId);
    }

    // 메뉴 등록
    public void createMenu(MenuDTO menu) {
        menuDAO.insertMenu(menu); // insert 후 menuId가 DTO에 세팅됨
        return ;
    }

    // 메뉴 수정
    public void updateMenu(MenuDTO menu) {
        menuDAO.updateMenu(menu);
    }

    // 메뉴 삭제 (논리 삭제)
    public void deleteMenu(Long menuId) {
        menuDAO.deleteMenu(menuId);
    }
    
    // 메뉴 조회 페이징용
    public int findCountAll() {
    	return menuDAO.findCountAll();
    }
    
    // 메뉴 필터
    public List<MenuDTO>findfilterMenu(Map<String, Object> filterMap){
    	return menuDAO.findfilterMenu(filterMap);
    }
    
    // 메뉴 필터 수
    public int findCountByFilter(Map<String, Object> filterMap){
    	return menuDAO.findCountByFilter(filterMap);
    }
}

