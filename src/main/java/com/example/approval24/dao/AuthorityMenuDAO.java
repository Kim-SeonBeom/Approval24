package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.AuthorityMenuDTO;

@Mapper
public interface AuthorityMenuDAO {

    // 권한 ID 리스트로 메뉴/버튼 권한 조회
    List<AuthorityMenuDTO> findByAuthorityIds(@Param("authorityIds") List<Long> authorityIds);

    // 전체 메뉴-권한 조회 (관리용)
    List<AuthorityMenuDTO> findAll();
}
