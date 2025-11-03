package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.RequestDTO;

@Mapper
public interface RequestDAO {
	// 폼 등록
	public void approveRequest(RequestDTO requestDTO);
	// 권한 등록
	public void approveAuth(RequestDTO requsetDTO);
	// 아이디 중복 확인
	public int  checkID(String loginId);
	// 목록
	public List<RequestDTO> requestList();
	// 주민번호로 유저 유무 찾기
	public Long  checkUserNo(String userResident);
	// 권한 아이디 이름 가져오기
	public List<RequestDTO>findAuth();

}
