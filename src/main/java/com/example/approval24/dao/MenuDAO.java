package com.example.approval24.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.MenuDTO;

@Mapper
public interface MenuDAO {

    // 권한 ID 리스트로 메뉴 조회
    List<MenuDTO> findByAuthorityIds(@Param("authorityIds") List<Long> authorityIds);

    // 전체 메뉴 조회 (관리용)
    List<MenuDTO> findAll();
    
    // 메뉴 필터 조회
    List<MenuDTO>findfilterMenu(Map<String, Object> filterMap);
    
    // 메뉴 전체 카운트
    int findCountAll();
    
    // 메뉴 아이디로 조회
	MenuDTO findById(Long menuId);
	
	// 메뉴 등록
    void insertMenu(MenuDTO menu);

    // 메뉴 수정
    int updateMenu(MenuDTO menu);

    // 메뉴 삭제 
    int deleteMenu(Long menuId);
}
