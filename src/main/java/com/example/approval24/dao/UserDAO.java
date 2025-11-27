package com.example.approval24.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.UserDTO;

@Mapper
public interface UserDAO {

    // 조건 검색 + 전체 조회 통합 (필터링 포함)
    List<UserDTO> findUsersByFilter(Map<String, Object> params);

    // 주민번호로 단건 조회
    UserDTO findByResidentNo(String userResidentNo);

    // 사용자 등록
    int insertUser(UserDTO user);

    // 사용자 수정
    int updateUser(UserDTO user);

    // 논리 삭제
    int deleteUser(@Param("userNo")Long userNo,@Param("updateId") Long updateId);

	int countUsersByFilter(Map<String, Object> params);

	UserDTO findByUserNo(Long userNo);
	
	// 검색에 해당되는 목록 개수
	public int countByFilter(UserDTO filter);
	
	// 검색 조건
	public List<UserDTO> findByFilter(UserDTO filter);
}
