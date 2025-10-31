package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.DeptInstDTO;

@Mapper
public interface DeptInstDAO {
	
	// 특정 부서의 매핑 기관
	public List<DeptInstDTO> instByDept(@Param("deptId") long deptId);
	
	// 특정 기관의 매핑 부서
	public List<DeptInstDTO> findDeptByInst(@Param("instId") long instId);
	
	// 부서와 기관 매핑 삭제
	public int deleteDI(@Param("deptId") long deptId);
	
	// 다중 매핑
	public int insertDI (@Param("deptId") int deptId, @Param("instIds") List<Integer> instIds);
	
	
}
