package com.example.approval24.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.service.TotalCodeService;

@Controller
public class TotalCodeController {
	@Autowired
	TotalCodeService codeService;
	
	// 코드 목록
	@GetMapping("/totalcode")
	public String code(TotalCodeDTO filter, Model model) {
		
		// 최초 진입 (빈 리스트)
		if (filter.isEmptyFilter()) {
			model.addAttribute("codeList", Collections.emptyList());
			model.addAttribute("filter", filter);
			model.addAttribute("totalCount", 0);
			model.addAttribute("totalPages", 0);
			return "A/totalCode";
		}
		
		// 조건 검색
		int totalCount = codeService.countCodes(filter);
		List<TotalCodeDTO> codeList = codeService.searchCodes(filter);
		
		model.addAttribute("codeList", codeList);
		model.addAttribute("filter", filter);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));
		return "A/totalCode";
	}
	
	// 코드 상세
	@GetMapping("/totalcode/detail")
	public String codeDetail(Model model, @RequestParam("code_id") String codeId) {
		model.addAttribute("codeInfo", codeService.TotalCodeInfo(codeId));
		return "A/totalCodeDetail";
	}
	
	// 코드 수정, 삭제
	@PostMapping("/totalcode/update")
	public String codeUpd(TotalCodeDTO codeDTO, RedirectAttributes rttr) {
		int result = codeService.TotalCodeUpd(codeDTO);
		
		if(result > 0 ) {
			rttr.addFlashAttribute("updMessage", "공통코드 정보가 성공적으로 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("updMessage", "공통코드 수정에 실패했습니다.");
		}
		return "redirect:/totalcode/detail?code_id=" + codeDTO.getCodeId();
	}
	
	// 코드 등록
	@GetMapping("/totalcode/new")
	public String codeNew() {
		return "A/totalCodeNew";
	}
	
	@PostMapping("/totalcode/new")
	public String codeInsert(TotalCodeDTO codeDTO, RedirectAttributes rttr, String codeId) {
		int result = codeService.TotalCodeInsert(codeDTO);
		
		if(result == -1) {
			rttr.addFlashAttribute("errorMessage", "이미 존재하는 코드ID입니다. 다른 코드ID를 사용해주세요.");
			return "redirect:/totalcode/new";
		}
		
		
		if(result > 0) {
			rttr.addFlashAttribute("insertMessage", "공통코드 정보가 성공적으로 등록되었습니다.");
			
		} else {
			rttr.addFlashAttribute("insertMessage", "공통코드 정보 등록에 실패했습니다.");
		}
		return "redirect:/totalcode";
	}
	
	// 민원서식 등록 유효성 검사 (공통코드에 미리 등록되어 있는지 확인)
	@GetMapping("/totalcode/check")
	@ResponseBody
	public boolean checkCodeExists(@RequestParam("codeId") String codeId) {
	    return codeService.existsByCodeId(codeId); // DB 조회
	}

}
