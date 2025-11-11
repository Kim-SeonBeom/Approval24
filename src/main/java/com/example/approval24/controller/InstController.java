package com.example.approval24.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.dao.InstDAO;
import com.example.approval24.domain.InstDTO;
import com.example.approval24.service.InstService;

@Controller
public class InstController {
	@Autowired
	InstDAO dao;
	
	@Autowired
	InstService instService;
	
	// 기관목록
	@GetMapping("/insts")
	public String insts(InstDTO filter, Model model) {
		
		// 최초 진입 (빈 리스트)
		if (filter.isEmptyFilter()) {
			model.addAttribute("instList", Collections.emptyList());
			model.addAttribute("filter", filter);
			model.addAttribute("totalCount", 0);
			model.addAttribute("totalPages", 0);
			return "A/insts";
		}
		
		// 조건 검색
		int totalCount = instService.countInsts(filter);
		List<InstDTO> instList = instService.searchInsts(filter);
		
		model.addAttribute("instList", instList);
		model.addAttribute("filter", filter);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));
		return "A/insts";
	}
	
	
	// 기관등록
	@GetMapping("/insts/new")
	public String instsNew() {
	    return "A/instsNew"; 
	}
	
	@PostMapping("/insts/new")
	public String insertInst(InstDTO instDTO, RedirectAttributes rttr) {
	    
	    int result = dao.insertInst(instDTO);
	    
	    if(result > 0) {
	        rttr.addFlashAttribute("insertMessage", "기관 정보가 성공적으로 등록되었습니다.");
	    } else {
	        rttr.addFlashAttribute("insertMessage", "기관 정보 등록에 실패했습니다.");
	    }
	    
	    return "redirect:/insts";
	}
	
	// 기관상세
	@GetMapping("/insts/detail")
	public String instsDetail(Model model, @RequestParam("inst_id") long instId) {
	    InstDTO inst = dao.getInstById(instId);
	    model.addAttribute("inst", inst);
	    return "A/instsDetail";
	}
	
	// 기관수정
	@PostMapping("/insts/update")
	public String instsUpdate(InstDTO instDTO, RedirectAttributes rttr) {
	    int result = dao.updateInst(instDTO);
	    
	    if (result > 0) {
	        rttr.addFlashAttribute("updMessage", "기관 정보가 성공적으로 수정되었습니다.");
	    } else {
	        rttr.addFlashAttribute("updMessage", "기관 정보 수정에 실패했습니다.");
	    }
	    
	    
	    return "redirect:/insts/detail?inst_id=" + instDTO.getInstId();
	}
	
	// 기관삭제
	@PostMapping("/insts/delete")
	public String instsUpdate(long instId, RedirectAttributes rttr) {
		int result = dao.deleteInst(instId);
		
		if (result > 0 ) {
			rttr.addFlashAttribute("delMessage", "기관 정보가 성공적으로 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("delMessage", "기관 정보 삭제에 실패했습니다.");
		}
		return "redirect:/insts";
	}

}
