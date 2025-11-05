package com.example.approval24.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
public class MainPageController {
	
	@PostMapping("/")
	public String mainPage(HttpSession session,Model model) {
		return "index";
	}

}
