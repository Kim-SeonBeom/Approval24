package com.example.approval24.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.approval24.service.CodeService;

@Controller
public class CodeController {
	@Autowired
	CodeService codeService;
	
	// 코드 목록
	@GetMapping("admin/code")
	public String code(Model model) {
		model.addAttribute("getAllCodeList", codeService.getAllCode());
		return "A/code";
	}
}
