package com.example.approval24.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.AuthorityDTO;

@Mapper
public interface AuthorityDAO {

    // 계정 ID로 권한 리스트 조회 (계정-권한 테이블 조인 포함)
    List<AuthorityDTO> findByAccountId(@Param("accountId") Long accountId);

    // 전체 권한 조회 (관리용)
    List<AuthorityDTO> findAll(Map<String, Object> params);
    
    // 권한 ID로 조회
    AuthorityDTO findById(@Param("authorityId") Long authorityId);

    // 권한 등록
    void insertAuthority(AuthorityDTO authority);

    // 권한 수정
    void updateAuthority(AuthorityDTO authority);

    // 권한 삭제 (논리 삭제)
    void deleteAuthority(@Param("authorityId") Long authorityId);
    
    // 검색에 해당되는 목록 개수
 	public int countByFilter(AuthorityDTO filter);
 	
 	// 검색 조건
 	public List<AuthorityDTO> findByFilter(AuthorityDTO filter);
}
