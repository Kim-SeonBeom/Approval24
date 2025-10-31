package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.CodeDTO;

@Mapper
public interface CodeDAO {
	// 코드 목록
	public List<CodeDTO> getAllCode();
}
