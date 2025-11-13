package com.example.approval24.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.domain.ComplainFilterDTO;
import com.example.approval24.domain.NoticeDTO;
import com.example.approval24.domain.NoticeFilterDTO;
import com.example.approval24.service.CategoryService;
import com.example.approval24.service.ComplainService;
import com.example.approval24.service.NoticeService;

@Controller
public class NoticeController {

	
	@Autowired
	private NoticeService noticeService; 
	
	@Autowired
	private CategoryService categoryService; 
	
	
	//공지사항 목록(filter 적용)
	@GetMapping("/notice")
	public String complainList(Model model, NoticeFilterDTO filter, HttpSession session) {

		
		//전체 민원 서식 목록(카테고리)
		List<CategoryDTO> categoryList = categoryService.getCategoryList();
		model.addAttribute("categoryList",categoryList);									//민원서식목록

		//필터조건에 맞는 리스트 찾기
		int totalCount = noticeService.noticeCountFilter(filter);
		List<NoticeDTO> noticeList = noticeService.noticeFilterList(filter);
		
		
	 
		model.addAttribute("categoryList",categoryList);								//계정이 속한 부서의 민원서식목록
		model.addAttribute("noticeList", noticeList);								//민원 목록
		model.addAttribute("filter", filter); 											//filter 조건
		model.addAttribute("totalCount", totalCount); 									//총 개수
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));	//토탈페이지개수


		return "/notice";

	}
	
	@GetMapping("/notice/detail/{noticeId}")
	public String noticeDetail(@PathVariable long noticeId, Model model) {

		NoticeDTO notice = noticeService.getnoticeDetail(noticeId);
		
		// 조회수 증가
		noticeService.increaseViewCount(noticeId);
		model.addAttribute("notice", notice);
		return "/noticeDetail";
	}

	@GetMapping("/notice/new")
	public String noticeWrite(Model model) {
		List<CategoryDTO> categoryList = categoryService.getCategoryList();
		model.addAttribute("categoryList",categoryList);					
		return "/noticeWrite";
	}
	
	@PostMapping("/notice/save")
	public String saveNotice(NoticeDTO notice) {
		CategoryDTO dto= categoryService.CategoryInfo(notice.getComplainCategoryId());
		notice.setCategoryCd(dto.getCategoryCd());
		noticeService.saveNotice(notice);
		return "redirect:/notice";
	}
	// 업데이트 불러오기
	@GetMapping("/notice/edit/{noticeId}")
	public String editNotice(@PathVariable long noticeId, Model model) {
		NoticeDTO notice = noticeService.getnoticeDetail(noticeId);
		List<CategoryDTO> categoryList = categoryService.getCategoryList();
		model.addAttribute("categoryList",categoryList);		
		model.addAttribute("notice", notice);
		return "/noticeEdit";
	}
	// 업데이트 반영
	@PostMapping("/notice/update")
	public String updateNotice(NoticeDTO notice) {
		CategoryDTO dto= categoryService.CategoryInfo(notice.getComplainCategoryId());
		notice.setCategoryCd(dto.getCategoryCd());
		noticeService.updateNotice(notice);		
		return "redirect:/notice/detail/" + notice.getNoticeId();
	}
	
	// 공지삭제
	@PostMapping( "/notice/delete")
	public String deleteNotice(NoticeDTO noticeDTO) {
		noticeService.deleteNotice(noticeDTO);
		return "redirect:/notice";
	}
}
