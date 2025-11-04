package com.example.approval24.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.AccountDTO;

@Mapper
public interface AccountDAO {
    // 로그인용: loginId + password 일치하는 계정 조회
    AccountDTO findByLogin(@Param("loginId") String loginId,
                           @Param("password") String password);
    
    List<AccountDTO> findAccountsByFilter(Map<String, Object> filterMap);

	Long findInstIdByAccountId(Long accountId);
	
	// 계정 리스트 (로그인id 리스트)
	List<AccountDTO> getAllAccount();
	
	// 특정 부서에 따른 매핑 계정
	public List<AccountDTO> findAccountByDept(@Param("deptId") Long deptId);
}
