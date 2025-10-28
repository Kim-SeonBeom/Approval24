package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.AuthorityDTO;

@Mapper
public interface AuthorityDAO {

    // 계정 ID로 권한 리스트 조회 (계정-권한 테이블 조인 포함)
    List<AuthorityDTO> findByAccountId(@Param("accountId") Long accountId);

    // 전체 권한 조회 (관리용)
    List<AuthorityDTO> findAll();
}
