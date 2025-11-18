package com.example.approval24.controller;

import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.domain.ComplainFilterDTO;
import com.example.approval24.domain.NoticeDTO;
import com.example.approval24.domain.NoticeFilterDTO;
import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.service.CategoryService;
import com.example.approval24.service.ComplainService;
import com.example.approval24.service.NoticeService;
import com.example.approval24.service.TotalCodeService;

@Controller
public class NoticeController {

	
	@Autowired
	private NoticeService noticeService; 
	
	@Autowired
	private CategoryService categoryService; 
	
	@Autowired
	private TotalCodeService totalcodeService; 
	
	
	//공지사항 목록(filter 적용)
	@GetMapping("/notice")
	public String complainList(Model model, NoticeFilterDTO filter, HttpSession session, @ModelAttribute("errorMessage") String errorMessage) {
		
		if (errorMessage != null && !errorMessage.isEmpty()) {
	        model.addAttribute("errorMessage", errorMessage);
	    }
		
		List<TotalCodeDTO> codeList = totalcodeService.getAllTotalCode();
		// 민원 서식과 공통 코드 가져오기
		List<TotalCodeDTO> filterList = codeList.stream()
			    .filter(dto -> dto.getCodeId() != null && dto.getCodeId().startsWith("G"))
			    .collect(Collectors.toList());
		

		//필터조건에 맞는 리스트 찾기
		int totalCount = noticeService.noticeCountFilter(filter);
		List<NoticeDTO> noticeList = noticeService.noticeFilterList(filter);
		
		System.out.println(filter);
		model.addAttribute("categoryList",filterList);								// 민원서식목록
		model.addAttribute("noticeList", noticeList);								//민원 목록
		model.addAttribute("filter", filter); 											//filter 조건
		model.addAttribute("totalCount", totalCount); 									//총 개수
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));	//토탈페이지개수


		return "/notice";

	}
	
	@GetMapping("/notice/detail/{noticeId}")
	public String noticeDetail(@PathVariable long noticeId, Model model) {

		NoticeDTO notice = noticeService.getnoticeDetail(noticeId);
		
		// 조회수 증가
		noticeService.increaseViewCount(noticeId);
		model.addAttribute("notice", notice);
		return "/noticeDetail";
	}

	@GetMapping("/notice/new")
	public String noticeWrite(Model model) {
		List<TotalCodeDTO> codeList = totalcodeService.getAllTotalCode();
		// 민원 서식과 공통 코드 가져오기
		List<TotalCodeDTO> filterList = codeList.stream()
			    .filter(dto -> dto.getCodeId() != null && dto.getCodeId().startsWith("G"))
			    .collect(Collectors.toList());
		model.addAttribute("categoryList",filterList);					
		return "/noticeWrite";
	}
	
	@PostMapping("/notice/save")
	public String saveNotice(NoticeDTO notice, RedirectAttributes rttr) {
		TotalCodeDTO dto = totalcodeService.TotalCodeInfo(notice.getCodeId());
		if (notice.getCodeId().isEmpty()) {
			// 카테고리 미선택
	        rttr.addFlashAttribute("errorMessage", "카테고리가 미선택 되었습니다.");
	        return "redirect:/notice";
	    }
		notice.setCategoryCd(dto.getCodeId());
		noticeService.saveNotice(notice);
		return "redirect:/notice";
	}
	// 업데이트 불러오기
	@GetMapping("/notice/edit/{noticeId}")
	public String editNotice(@PathVariable long noticeId, Model model) {
		NoticeDTO notice = noticeService.getnoticeDetail(noticeId);
		List<TotalCodeDTO> codeList = totalcodeService.getAllTotalCode();
		// 민원 서식과 공통 코드 가져오기
		List<TotalCodeDTO> filterList = codeList.stream()
			    .filter(dto -> dto.getCodeId() != null && dto.getCodeId().startsWith("G"))
			    .collect(Collectors.toList());
		model.addAttribute("categoryList",filterList);		
		model.addAttribute("notice", notice);
		return "/noticeEdit";
	}
	// 업데이트 반영
	@PostMapping("/notice/update")
	public String updateNotice(NoticeDTO notice, RedirectAttributes rttr) {
		TotalCodeDTO dto = totalcodeService.TotalCodeInfo(notice.getCodeId());
		if (notice.getCodeId().isEmpty()) {
			// 카테고리 미선택
	        rttr.addFlashAttribute("errorMessage", "카테고리가 미선택 되었습니다.");
	        return "redirect:/notice";
	    }
		notice.setCategoryCd(dto.getCodeId());
		noticeService.updateNotice(notice);		
		return "redirect:/notice/detail/" + notice.getNoticeId();
	}
	
	// 공지삭제
	@PostMapping( "/notice/delete")
	public String deleteNotice(NoticeDTO noticeDTO) {
		noticeService.deleteNotice(noticeDTO);
		return "redirect:/notice";
	}
}
