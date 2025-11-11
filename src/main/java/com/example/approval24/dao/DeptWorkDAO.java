package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.DeptWorkDTO;

@Mapper
public interface DeptWorkDAO {
	
	// 특정 민원서식의 매핑 부서
	public List<DeptWorkDTO> deptByCategory (@Param("complainCategoryId") long complainCategoryId);
	
	// 단일 매핑
	public int insertDW (@Param("deptId") Long deptId, @Param("complainCategoryId") Long complainCategoryId);
	
	// 부서와 민원서식 매핑 삭제
	public int deleteDW(@Param("complainCategoryId") long complainCategoryId);
}
