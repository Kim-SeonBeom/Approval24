package com.example.approval24.controller;

import org.springframework.web.bind.annotation.GetMapping;

public class deptController {
	@GetMapping("/admin/dept")
	public String division() {
		return "A/division";
	}
	
	@GetMapping("admin/dept/detail")
	public String divisionDetail() {
		return "A/divisionDetail";
	}

}
