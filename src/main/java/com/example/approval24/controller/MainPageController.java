package com.example.approval24.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.approval24.domain.AccountDTO;
import com.example.approval24.service.AccountService;

@Controller
public class MainPageController {
	@Autowired
	AccountService accountService;
	
	@GetMapping("/")
	public String tesmain(HttpSession session,Model model) {
		/*Long userId = (Long) session.getAttribute("user");
		if(userId == null) {
			return null;
		}
		else {
			AccountDTO dto = accountService.myTeamAccountList(userId);
			accountService.getAccountsByFilter(filterMap);
		}*/
		return "index";
	}

}
