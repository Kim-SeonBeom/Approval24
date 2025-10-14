package com.example.approval24.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class testcontroller {
	
	@GetMapping("/")
	public String testmain() {
		return "index";
	}
	
	@GetMapping("/tables")
	public String tables() {
		return "tables";
	}
	
	@GetMapping("/charts")
	public String charts() {
		return "charts";
	}
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/pending")
	public String pending() {
		//잘 하는 집을 안 가봐서 그래
		return "pending";
	}

}
