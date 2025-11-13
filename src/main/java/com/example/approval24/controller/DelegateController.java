package com.example.approval24.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.DelegateDTO;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.DelegateService;

@Controller
public class DelegateController {

	@Autowired
	private DelegateService delegateService;

	@Autowired
	private AccountService accountService;

	//기간만료되지 않고 사용중인 내 대결자 목록
	@GetMapping("/delegate")
	public String delegateList(Model model,HttpSession session, DelegateDTO filter) {
		
		Long accountId = (Long)session.getAttribute("user");
		if (accountId == null) {
            return "redirect:/login";
        }
		
		filter.setAbsId(accountId);
		
		// 최초 진입 (빈 리스트)
		if (filter.isEmptyFilter()) {
			model.addAttribute("delegateList", Collections.emptyList());
			model.addAttribute("filter", filter);
			model.addAttribute("totalCount", 0);
			model.addAttribute("totalPages", 0);
			return "delegate";
		}
		
		// 조건 검색
		int totalCount = delegateService.countDelegate(filter);
		List<DelegateDTO> delegateList = delegateService.searchDelegate(filter);
		
		
		model.addAttribute("delegateList", delegateList);
		model.addAttribute("filter", filter);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));
		return "delegate";
	}

	//신규대결자 등록 폼
	@GetMapping("/delegate/new")
	public String delegateForm(Model model, HttpSession session) {
		Long accountId = (Long)session.getAttribute("user");
		if (accountId == null) {
            return "redirect:/login";
        }
		
		List<AccountDTO> accountList = accountService.myTeamAccountList(accountId);
		System.out.println(accountList.toString());
		model.addAttribute("accountList", accountList);
		return "delegateNew";
	}
	//신규 대결자 등록
	@PostMapping("/delegate/new")
	public String registDelegate(Model model, DelegateDTO delegateDTO, RedirectAttributes rttr, HttpSession session) {
		Long accountId = (Long)session.getAttribute("user");
		if(accountId == null) {
			return "redirect:/login";
		}
		
		int result = delegateService.insertDelegate(accountId, delegateDTO);
		if (result > 0) {
			rttr.addFlashAttribute("regMsg", "대결자 설정이 성공적으로 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("regMsg", "등록에 실패하였습니다.");
		}

		return "redirect:/delegate";
	}

	//대결자설정 상세보기
	@GetMapping("/delegate/detail/{seqNo}")
	public String delegateDetail(Model model, @PathVariable int seqNo, HttpSession session) {
		Long accountId = (Long)session.getAttribute("user");
		if(accountId == null) {
			return "redirect:/login";
		}
		
		System.out.println("controller = " + seqNo);

		DelegateDTO delegatedto = delegateService.delegateDetail(seqNo);

		List<AccountDTO> accountList = accountService.myTeamAccountList(accountId);

		model.addAttribute("detail", delegatedto);
		model.addAttribute("accountList", accountList);
		System.out.println(delegatedto.toString());
		return "delegateDetail";
	}

	//대결자정보 수정
	@PostMapping("/delegate/detail/{seqNo}")
	public String insertDelegate(Model model, @PathVariable int seqNo, RedirectAttributes rttr, DelegateDTO delegateDTO, HttpSession session) {
		Long accountId = (Long)session.getAttribute("user");
		
		if(accountId == null) {
			return "redirect:/login";
		}

		int result = delegateService.updateDelegate(accountId, delegateDTO);
		if (result > 0) {
			rttr.addFlashAttribute("insertMsg", "대결자 설정이 성공적으로 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("insertMsg", "수정에 실패하였습니다.");
		}

		return "redirect:/delegate/detail/"+seqNo;
	}
	
	//대결자 삭제
	@PostMapping("/delegate/{seqNo}/delete")
	public String deleteDelegate(@PathVariable long seqNo, RedirectAttributes rttr) {
		int result = delegateService.deleteDelegate(seqNo);
		
		if (result > 0) {
			rttr.addFlashAttribute("delMsg", "대결자 설정이 성공적으로 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("delMsg", "대결자 설정이 삭제에 실패했습니다.");
		}
		return "redirect:/delegate";
	}
	
}
