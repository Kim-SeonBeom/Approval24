package com.example.approval24.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.AuthorityDTO;
import com.example.approval24.domain.NoticeDTO;
import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.domain.UserDTO;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.ApprovalHistoryService;
import com.example.approval24.service.AuthorityService;
import com.example.approval24.service.NoticeService;
import com.example.approval24.service.TotalCodeService;
import com.example.approval24.service.UserService;



@Controller
public class MainPageController {
	
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private ApprovalHistoryService accountHistoryService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private TotalCodeService totalCodeService;
	
	@Autowired
	private AuthorityService authorityService;
	
	
	@GetMapping("/")
	public String mainPage(@SessionAttribute(name = "user", required = false) long accountId, Model model, HttpSession session) {
		Long instId = accountService.findInstIdByAccountId(accountId);
		// -------------인사---------------
		// 내 기관 전체 계정
		Map<String, Object> filter = new HashMap<>();
		filter.put("instId", instId);
		int myDetpCount= accountService.countAccountsByFilter(filter);
		model.addAttribute("total", myDetpCount);
		// 기관내 활성화 계정
		filter.put("accountStatusCd", "B002");
		filter.put("instId", instId);
		int myDeptEnable = accountService.countAccountsByFilter(filter);
		model.addAttribute("enableAccount", myDeptEnable);
		
		// 기관내 신청 대기
		filter.remove("accountStatusCd");
		filter.put("accountStatusCd", "B001");
		int myDeptWaiting = accountService.countAccountsByFilter(filter);
		model.addAttribute("waitingAccount", myDeptWaiting);
		
		// 기관내 정지(비번잠김)
		filter.remove("accountStatusCd");
		filter.put("accountStatusCd", "B005");
		int myDeptLock = accountService.countAccountsByFilter(filter);
		model.addAttribute("lockAccount", myDeptLock);
		//-------------인사 끝--------------
		
		// -------------일반---------------
		 Long userId = (Long) session.getAttribute("user");
		Map<String, Object> filterMap = new HashMap<>();
		
		// 내 전체 민원
		filterMap.put("accountId", userId);
		int myTotalApproval = accountHistoryService.countMyApprovalHistoryList(filterMap);
		model.addAttribute("totalApproval", myTotalApproval);
		
		// 결재 대기중인 내 민원(History 상태 결재)
		filterMap.put("approvalStatusCd", "E001");
		int myWaitingApproval = accountHistoryService.countMyApprovalHistoryList(filterMap);
		model.addAttribute("waitingApproval", myWaitingApproval);
		
		// 승인
		filterMap.remove("approvalStatusCd");
		filterMap.put("approvalStatusCd", "E002");
		int myRefuseApproval = accountHistoryService.countMyApprovalHistoryList(filterMap);
		model.addAttribute("refuseApproval", myRefuseApproval);
		
		// 반려한 결재
		filterMap.remove("approvalStatusCd");
		filterMap.put("approvalStatusCd", "E003");
		int myapprovalsInTransit = accountHistoryService.countMyApprovalHistoryList(filterMap);
		model.addAttribute("approvalInTransit", myapprovalsInTransit);
		// -------------일반 끝---------------
		
		// -------------공통----------------
		// 공지사항
		List<NoticeDTO> list = noticeService.noticeList();
		model.addAttribute("noticeList", list);
		// -------------공통 끝----------------
		return "index";
	}
	
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		long accountId = (long) session.getAttribute("user");
		// userNo
		Map<String, Object> filter = new HashMap<>();
		filter.put("accountId", accountId);
		// account info
		List<AccountDTO> account = accountService.getAccountsByFilter(filter);
		AccountDTO accountDto = account.get(0);
		// userinfo
		UserDTO userinfo = userService.getUserDetailByUserNo(accountDto.getUserNo());
		model.addAttribute("userinfo", userinfo);
		String CodeId = userinfo.getUserPositionCd();
		// 직책 이름
		TotalCodeDTO totalinfo = totalCodeService.TotalCodeInfo(CodeId);
		model.addAttribute("totalinfo", totalinfo);
		
		
		// 계정 권한정보
		List<AuthorityDTO> authAccountDto =authorityService.findByAccountId(accountId);
		model.addAttribute("authList",authAccountDto);
		return "mypage";
	}

}
