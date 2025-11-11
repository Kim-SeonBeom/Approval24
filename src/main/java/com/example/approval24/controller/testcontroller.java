package com.example.approval24.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class testcontroller {
	
	@GetMapping("/user/userAppplication")
	public String Application() {
		return "userApplication";
	}

	@GetMapping("/tables")
	public String tables() {
		return "tables";
	}


	@GetMapping("/pending")
	public String pending() {
		// 잘 하는 집을 안 가봐서 그래
		return "pending";
	}

	@GetMapping("/account")
	public String account() {
		return "account";
	}

	@GetMapping("/mypage")
	public String mypage() {
		return "mypage";
	}

	@GetMapping("/application")
	public String application() {
		return "application";
	}

	@GetMapping("/regist")
	public String accountRegist() {
		return "accountRegister";
	}

	@GetMapping("/benefits")
	public String benefits() {
		return "benefits";
	}

	
	@GetMapping("/account/auth")
	public String accountApprove() {
		return "accountAuth";
	}

	@GetMapping("/account/requests")
	public String accountRequestList() {
		return "accountRequests";
	}

	
	@GetMapping("/authorityList")
	public String authorityList() {
		return "authorityList";
	}
	
	@GetMapping("/authorityCreate")
	public String authorityCreate() {
		return "authorityCreate";
	}
	
	@GetMapping("/authorityEdit")
	public String authorityEdit() {
		return "authorityEdit";
	}
	
	//approvalLine
	@GetMapping("/approvalLine")
	public String approvalLine() {
		return "D/approvalLine";
	}
	

	@GetMapping("/division")
	public String division() {
		return "division";
	}
	
	@GetMapping("/division/detail")
	public String divisionDetail() {
		return "divisionDetail";
	}

}
