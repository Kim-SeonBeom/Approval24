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

	@GetMapping("/notice")
	public String charts() {
		return "notice";
	}

	@GetMapping("/login")
	public String login() {
		return "login";
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

	@GetMapping("/trainingLoan")
	public String trainingExpense() {
		return "trainingLoan";
	}

	@GetMapping("/trainingSubsidy")
	public String subsidy() {
		return "trainingSubsidy";
	}

	@GetMapping("/minwon")
	public String minwon() {
		return "index2";
	}

	@GetMapping("/notice/detail")
	public String noticeDetail() {
		return "noticeDetail";
	}

	@GetMapping("/notice/new")
	public String noticeWrite() {
		return "noticeWrite";
	}

	@GetMapping("/account/auth")
	public String accountApprove() {
		return "accountAuth";
	}

	@GetMapping("/account/requests")
	public String accountRequestList() {
		return "accountRequests";
	}
	
	@GetMapping("/delegate")
	public String delegatePage() {
		return "delegate";
	}

}
