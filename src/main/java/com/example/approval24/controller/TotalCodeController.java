package com.example.approval24.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.approval24.service.TotalCodeService;

@Controller
public class TotalCodeController {
	@Autowired
	TotalCodeService codeService;
	
	// 코드 목록
	@GetMapping("admin/totalcode")
	public String code(Model model) {
		model.addAttribute("getAllTotalCodeList", codeService.getAllTotalCode());
		return "A/totalCode";
	}
}
