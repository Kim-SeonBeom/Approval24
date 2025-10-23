package com.example.approval24.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class testcontroller {

	@GetMapping("/") //메인페이지
	public String testmain() {
		return "index";
	} 

	@GetMapping("/tables") //민원 대기 목록(신청자,검토자,승인자)
	public String tables() {
		return "tables";
	}

	@GetMapping("/notice") //공지사항 
	public String charts() {
		return "notice";
	}

	@GetMapping("/login") //로그인페이지
	public String login() {
		return "login";
	}

	@GetMapping("/pending") // 검토자,승인자 결재 페이지
	public String pending() {
		// 잘 하는 집을 안 가봐서 그래
		return "pending";
	}

	@GetMapping("/account") //계정 관리(승인,거절버튼 필요) <- 수정해야함.
	public String account() {
		return "account";
	}

	@GetMapping("/account/auth") //계정 승인 반려 상세페이지
	public String accountApprove() {
		return "accountAuth";
	}
	
	@GetMapping("/account/requests") //계정 요청 페이지
	public String accountRequestList() {
		return "accountRequests";
	}
	
	@GetMapping("/mypage") //마이페이지
	public String mypage() {
		return "mypage";
	}

	@GetMapping("/application") // 담당자 결재 신청서
	public String application() {
		return "application";
	}

	@GetMapping("/regist")  //계정 신청
	public String accountRegist() {
		return "accountRegister";
	}

	@GetMapping("/benefits") //임시양식
	public String benefits() {
		return "benefits";
	}

	@GetMapping("/minwon") //민원인 페이지 예시 - 삭제 예정
	public String minwon() {
		return "index2";
	}

	@GetMapping("/notice/detail") //공지사항 디테일
	public String noticeDetail() {
		return "noticeDetail";
	}

	@GetMapping("/notice/new") // 공지사항 등록
	public String noticeWrite() {
		return "noticeWrite";
	}

	
	@GetMapping("/delegate") // 대결자
	public String delegatePage() {
		return "delegate";
	}

}
