package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.CategoryDAO;
import com.example.approval24.domain.CategoryDTO;

@Service
public class CategoryService {
	@Autowired
	private CategoryDAO categoryDAO;

	// 현재 로그인한 아이디로 접수 할 수 있는 민원서식 목록
	public List<CategoryDTO> getCategoryListByAccountId(long accountId) {
		return categoryDAO.findByAccountId(accountId);
	}

	// 민원서식 목록
	public List<CategoryDTO> getCategoryList() {
		return categoryDAO.findAllCategories();
	}

	// URL로 findByCategoryUrl 찾기
	public String getCategoryName(String categoryUrl) {
		CategoryDTO dto = categoryDAO.findByCategoryUrl(categoryUrl);
		return dto.getCategoryName();
	}

	// 민원서식 상세
	public CategoryDTO CategoryInfo(long complainCategoryId) {
		return categoryDAO.CategoryInfo(complainCategoryId);
	}

	// 민원서식 등록
	public int CategoryInsert(CategoryDTO categoryDTO) {
		return categoryDAO.CategoryInsert(categoryDTO);
	}

	// 민원서식 수정, 삭제
	public int CategoryUpd(CategoryDTO categoryDTO) {
		return categoryDAO.CategoryUpd(categoryDTO);
	}

	// 카테고리URL로 카테고리id 얻기
	public Long getCategoryIdByUrl(String categoryUrl) {
		CategoryDTO categoryDTO = categoryDAO.findByCategoryUrl(categoryUrl);
		return categoryDTO.getComplainCategoryId();
	}

}
