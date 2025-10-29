package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.CategoryDTO;

@Mapper
public interface CategoryDAO {
	
	public List<CategoryDTO> findAllCategories();
	
	public int findDueDtById(int complainCategoryId);

}
