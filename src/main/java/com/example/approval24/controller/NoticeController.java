package com.example.approval24.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;


import com.example.approval24.domain.NoticeDTO;
import com.example.approval24.service.NoticeService;

@Controller
public class NoticeController {

	
	@Autowired
	private NoticeService noticeService; 
	
	@GetMapping("/notice")
	public String noticeList(Model model) {
		List<NoticeDTO> list = noticeService.noticeList();
		model.addAttribute("noticeList", list);
		
		return "/notice";
	}
	
	@GetMapping("/notice/detail/{noticeId}")
	public String noticeDetail(@PathVariable Long noticeId, Model model) {
		
		System.out.println("컨트롤러 시작");
		NoticeDTO notice = noticeService.getnoticeDetail(noticeId);
		System.out.println(notice.toString());
		
		model.addAttribute("notice", notice);
		return "/noticeDetail";
	}

	@GetMapping("/notice/new")
	public String noticeWrite() {
		System.out.println("작성 컨트롤러 시작");
		return "/noticeWrite";
	}
	
	@PostMapping("/notice/save")
	public String saveNotice(NoticeDTO notice, Model model) {
		noticeService.saveNotice(notice);
		return "redirect:/notice";
	}
	
	@PostMapping("/notice/edit")
	public String editNoice(Model model) {
		return "redirect: /notice/detail/{noticeId}";
	}
}
