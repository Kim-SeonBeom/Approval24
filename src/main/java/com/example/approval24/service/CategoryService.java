package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.CategoryDAO;
import com.example.approval24.dao.DeptWorkDAO;
import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.domain.DeptWorkDTO;

@Service
public class CategoryService {
	@Autowired
	private CategoryDAO categoryDAO;
	
	@Autowired
	private DeptWorkDAO deptWorkDAO;

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
	public int CategoryInsert(CategoryDTO categoryDTO, List<Long> deptIds) {
		int insert = categoryDAO.CategoryInsert(categoryDTO);
		
		Long complainCategoryId = categoryDTO.getComplainCategoryId();
		
		int mapping = 0;
		if (deptIds != null && !deptIds.isEmpty()) {
			for (Long deptId : deptIds) {
				if(deptId == null) continue;
				mapping+=deptWorkDAO.insertDW(deptId, complainCategoryId);
			}
		}
		
		return insert + mapping;
	}

	// 민원서식 수정, 삭제
	public int CategoryUpd(CategoryDTO categoryDTO, List<Long> deptIds) {
		// 민원서식 기본정보 upd
		int a = categoryDAO.CategoryUpd(categoryDTO);
		
		Long complainCategoryId = categoryDTO.getComplainCategoryId();
		
		// 매핑 삭제
		int d = deptWorkDAO.deleteDW(complainCategoryId);
		
		// 신규 매핑
		int i = 0;
		if (deptIds != null && !deptIds.isEmpty()) {
			for (Long deptId : deptIds) {
				if(deptId == null) continue;
				i+=deptWorkDAO.insertDW(deptId, complainCategoryId);
			}
		}
		
		return a + d + i;
	}

	// 카테고리URL로 카테고리id 얻기
	public Long getCategoryIdByUrl(String categoryUrl) {
		CategoryDTO categoryDTO = categoryDAO.findByCategoryUrl(categoryUrl);
		return categoryDTO.getComplainCategoryId();
	}
	
	
	//페이징처리를 위한 카테고리별 민원서식개수(Filter 적용)
	public int countInsts(CategoryDTO filter) {
		 return categoryDAO.countByFilter(filter);
	}
	
	//카테고리별 민원서식목록(Filter 적용)
    public List<CategoryDTO> searchInsts(CategoryDTO filter) {
        return categoryDAO.findByFilter(filter); 
    }
    
    // 특정 민원서식의 매핑 부서명
    public List<DeptWorkDTO> deptByCategory(long complainCategoryId) {
        return deptWorkDAO.deptByCategory(complainCategoryId);
    }

}
