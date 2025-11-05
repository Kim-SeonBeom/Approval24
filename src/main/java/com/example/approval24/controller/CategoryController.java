package com.example.approval24.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.service.CategoryService;

@Controller
@RequestMapping("/admin")
public class CategoryController {
	@Autowired
	CategoryService categoryService;
	
	// 민원서식 목록
	@GetMapping("/category")
	public String categoryList(Model model) {
		model.addAttribute("getAllCategoryList", categoryService.getCategoryList());
		return "A/category";
	}
	
	// 민원서식 상세
	@GetMapping("/category/detail")
	public String categoryDetail(Model model, @RequestParam("complain_category_id") long complainCategoryId) {
		model.addAttribute("categoryInfo", categoryService.CategoryInfo(complainCategoryId));
		return "A/categoryDetail";
	}
	
	// 민원서식 수정, 삭제
	@PostMapping("/category/update")
	public String categoryUpd(CategoryDTO categoryDTO, RedirectAttributes rttr, HttpSession session) {
		Long id = (Long)session.getAttribute("user");
		if(id == null) {
			rttr.addFlashAttribute("updMessage", "로그인 정보가 없습니다. 로그인 해주세요.");
		}
		categoryDTO.setUpdateId(id);
		
		int result = categoryService.CategoryUpd(categoryDTO);
		if(result > 0) {
			rttr.addFlashAttribute("updMessage", "민원서식 정보가 정상적으로 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("updmessage", "민원서식 정보 수정에 실패했습니다.");
		}
		return "redirect:/admin/category/detail?complain_category_id=" + categoryDTO.getComplainCategoryId();
	}
	
	// 민원서식 등록
	@GetMapping("/category/new")
	public String categoryNew() {
		return "A/categoryNew";
	}
	
	@PostMapping("/category/new")
	public String categoryInsert(CategoryDTO categoryDTO, RedirectAttributes rttr, HttpSession session) {
		Long id = (Long)session.getAttribute("user");
		if(id == null) {
			rttr.addFlashAttribute("insertMessage", "로그인 정보가 없습니다. 로그인 해주세요.");
		}
		categoryDTO.setCreateId(id);
		
		int result = categoryService.CategoryInsert(categoryDTO);
		if(result > 0) {
			rttr.addFlashAttribute("insertMessage", "민원서식 정보가 정상적으로 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("insertMessage", "민원서식 정보 등록에 실패했습니다.");
		}
		return "redirect:/admin/category";
	}
}
