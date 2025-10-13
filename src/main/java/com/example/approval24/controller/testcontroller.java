package com.example.approval24.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class testcontroller {
	
	@GetMapping("/")
	public String testmain() {
		System.out.println("되냐?");
		return "index";
	}
	
	@GetMapping("/tables")
	public String tables() {
		return "tables";
	}
	
	@GetMapping("charts")
	public String charts() {
		return "charts";
	}

}
