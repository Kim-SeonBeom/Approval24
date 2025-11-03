package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.DeptDTO;

@Mapper
public interface DeptDAO {
	// 부서 기본정보
	public DeptDTO deptInfo(int deptId);
		
	// 부서 수정
	public int updateDept(DeptDTO deptDTO);
	
	// 부서 목록
	public List<DeptDTO> getAllDept();
	
	// 부서 삭제
	public int deleteDept(int deptId);
	
	// 부서 등록
	public int insertDept(DeptDTO dto);
	
	

}
