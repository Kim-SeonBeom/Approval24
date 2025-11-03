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

	public List<CategoryDTO> getCategoryList() {

		return categoryDAO.findAllCategories(); 

	}

}
