package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.DeptInstDTO;

@Mapper
public interface DeptInstDAO {
	
	// 특정 부서의 매핑 기관명
	public List<DeptInstDTO> instByDept(@Param("deptId") int deptId);
	
	// 부서와 기관 매핑 삭제
	public int deleteDI(@Param("deptId") int deptId);
	
	// 다중 매핑
	public int insertDI (@Param("deptId") int deptId, @Param("instIds") List<Integer> instIds);
	
	
}
