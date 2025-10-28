package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.AccountDTO;

@Mapper
public interface AccountDAO {
    // 로그인용: loginId + password 일치하는 계정 조회
    AccountDTO findByLogin(@Param("loginId") String loginId,
                           @Param("password") String password);
}
