package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.AuthorityAccountDTO;

@Mapper
public interface AuthorityAccountDAO {

    // 계정 ID로 권한 ID 리스트 조회
    List<AuthorityAccountDTO> findByAccountId(@Param("accountId") Long accountId);
}
