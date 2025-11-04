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
	public String noticeDetail(@PathVariable long noticeId, Model model) {
		
		System.out.println("컨트롤러 시작");
		NoticeDTO notice = noticeService.getnoticeDetail(noticeId);
		
		// 조회수 증가
		noticeService.increaseViewCount(noticeId);
		System.out.println(notice.toString());
		
		model.addAttribute("notice", notice);
		return "/noticeDetail";
	}

	@GetMapping("/notice/new")
	public String noticeWrite() {
		return "/noticeWrite";
	}
	
	@PostMapping("/notice/save")
	public String saveNotice(NoticeDTO notice) {
		System.out.println("세이브 컨트롤러 시작");
		noticeService.saveNotice(notice);
		return "redirect:/notice";
	}
	// 업데이트 불러오기
	@GetMapping("/notice/edit/{noticeId}")
	public String editNotice(@PathVariable long noticeId, Model model) {
		System.out.println("edit 컨트롤러 시작");
		NoticeDTO notice = noticeService.getnoticeDetail(noticeId);
		model.addAttribute("notice", notice);
		return "/noticeEdit";
	}
	// 업데이트 반영
	@PostMapping("/notice/update")
	public String updateNotice(NoticeDTO notice) {
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
