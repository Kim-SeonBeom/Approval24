
package com.example.approval24.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.AccountDTO;

@Mapper
public interface AccountDAO {
    // 로그인용: loginId + password 일치하는 계정 조회
    AccountDTO findByLogin(String loginId);
    
    List<AccountDTO> findAccountsByFilter(Map<String, Object> filterMap);
    
    public AccountDTO checkByLogin(String loginId);
    
	Long findInstIdByAccountId(Long accountId);

	public AccountDTO findById(long accountId);
	
	// 특정 부서에 따른 매핑 계정
	public List<AccountDTO> findAccountByDept(@Param("deptId") Long deptId);
  
  public void updateAccount(AccountDTO account);
  
  void insert(AccountDTO accountDTO);
  
  // 계정 리스트 (로그인id 리스트)
	List<AccountDTO> getAllAccount();
  
  List<AccountDTO> findByAccountIdAndDeptIdAndInstId(@Param("accountId") long accountId);

  int countAccountsByFilter(Map<String, Object> params);
  
  // 선택한 기관/부서의 계정 목록
  List<AccountDTO> findAccountsByInstAndDept(@Param("instId") Long instId, @Param("deptId") Long deptId);
}



