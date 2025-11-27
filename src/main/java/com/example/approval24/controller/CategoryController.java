package com.example.approval24.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.service.CategoryService;
import com.example.approval24.service.DeptService;

@Controller
public class CategoryController {
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	DeptService deptService;
	
	// 민원서식 목록
	@GetMapping("/category")
	public String category(CategoryDTO filter, Model model) {
		
		// 최초 진입 (빈 리스트)
		if (filter.isEmptyFilter()) {
			model.addAttribute("categoryList", Collections.emptyList());
			model.addAttribute("filter", filter);
			model.addAttribute("totalCount", 0);
			model.addAttribute("totalPages", 0);
			return "A/category";
		}
		
		// 조건 검색
		int totalCount = categoryService.countInsts(filter);
		List<CategoryDTO> categoryList = categoryService.searchInsts(filter);
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("filter", filter);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));
		return "A/category";
	}
	
	// 민원서식 상세
	@GetMapping("/category/detail")
	public String categoryDetail(Model model, @RequestParam("complain_category_id") long complainCategoryId) {
		model.addAttribute("categoryInfo", categoryService.CategoryInfo(complainCategoryId));
		model.addAttribute("deptByCategoryList", categoryService.deptByCategory(complainCategoryId));
		model.addAttribute("getAllDept", deptService.getAllDept());
		return "A/categoryDetail";
	}
	
	// 민원서식 수정, 삭제
	@PostMapping("/category/update")
	public String categoryUpd(CategoryDTO categoryDTO, RedirectAttributes rttr, HttpSession session,
							  @RequestParam(value="deptIds", required=false) List<Long> deptIds) {
		Long id = (Long)session.getAttribute("user");
		if(id == null) {
			rttr.addFlashAttribute("updMessage", "로그인 정보가 없습니다. 로그인 해주세요.");
		}
		categoryDTO.setUpdateId(id);
		
		List<Long> safeDeptIds = (deptIds == null) ? Collections.emptyList() : deptIds;
		int result = categoryService.CategoryUpd(categoryDTO, safeDeptIds);
		if(result > 0) {
			rttr.addFlashAttribute("updMessage", "민원서식 정보가 정상적으로 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("updmessage", "민원서식 정보 수정에 실패했습니다.");
		}
		return "redirect:/category/detail?complain_category_id=" + categoryDTO.getComplainCategoryId();
	}
	
	// 민원서식 등록
	@GetMapping("/category/new")
	public String categoryNew(Model model) {
		model.addAttribute("getAllDept", deptService.getAllDept());
		return "A/categoryNew";
	}
	
	@PostMapping("/category/new")
	public String categoryInsert(CategoryDTO categoryDTO, RedirectAttributes rttr, HttpSession session,
								 @RequestParam(value="deptIds", required=false) List<Long> deptIds) {
		Long id = (Long)session.getAttribute("user");
		if(id == null) {
			rttr.addFlashAttribute("insertMessage", "로그인 정보가 없습니다. 로그인 해주세요.");
		}
		categoryDTO.setCreateId(id);
		
		List<Long> safeDeptIds = (deptIds == null) ? Collections.emptyList() : deptIds;
		int result = categoryService.CategoryInsert(categoryDTO, safeDeptIds);
		
		if(result > 0) {
			rttr.addFlashAttribute("insertMessage", "민원서식 정보가 정상적으로 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("insertMessage", "민원서식 정보 등록에 실패했습니다.");
		}
		return "redirect:/category";
	}
}
