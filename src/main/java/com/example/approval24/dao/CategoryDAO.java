
package com.example.approval24.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.CategoryDTO;

@Mapper
public interface CategoryDAO {
   // 민원서식 전체 리스트
   public List<CategoryDTO> findAllCategories();
   
   // 민원서식별 처리기한 조회
   public int findDueDtById(long complainCategoryId);
   
   // 특정 부서의 매핑 민원서식
   public List<CategoryDTO> findCategoryByDept(@Param("deptId") Long deptId);

}

package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.CategoryDTO;

@Mapper
public interface CategoryDAO {
	
	public List<CategoryDTO> findAllCategories();
	
	public int findDueDtById(long complainCategoryId);

	public CategoryDTO findByCategoryUrl(String categoryUrl);
		
	

}

