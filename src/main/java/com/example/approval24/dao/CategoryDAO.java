
package com.example.approval24.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.CategoryDTO;

@Mapper
public interface CategoryDAO {
	// 민원서식 목록
	public List<CategoryDTO> findAllCategories();
	
	// 민원서식별 처리기한 조회
	public int findDueDtById(long complainCategoryId);
	
	// URL로 findByCategoryUrl 찾기
	public CategoryDTO findByCategoryUrl(String categoryUrl);
	
	
	// 특정 부서의 매핑 민원서식
	public List<CategoryDTO> findCategoryByDept(Long deptId);
	
	// 민원서식 상세
	public CategoryDTO CategoryInfo(long complainCategoryId);
	
	// 민원서식 등록
	public int CategoryInsert(CategoryDTO categoryDTO);
	
	// 민원서식 수정, 삭제
	public int CategoryUpd(CategoryDTO categoryDTO);
	
}

