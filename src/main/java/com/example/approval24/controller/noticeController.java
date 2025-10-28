package com.example.approval24.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.approval24.dao.NoticeDAO;
import com.example.approval24.domain.noticeDTO;

@Controller
public class noticeController {

	
	@Autowired
	private NoticeDAO noticeDAO; 
	
	@GetMapping("/notice")
	public String noticeList(Model model) {
		System.out.println("start");
		List<noticeDTO> list = noticeDAO.noticeList();
		System.out.println(list.toString());
		model.addAttribute("noticeList", list);
		
		return "notice";
	}
	
	@GetMapping("/notice/detail")
	public String noticeDetail() {
		return "noticeDetail";
	}

	@GetMapping("/notice/new")
	public String noticeWrite() {
		return "noticeWrite";
	}
}
