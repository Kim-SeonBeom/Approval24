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

import com.example.approval24.domain.DeptDTO;
import com.example.approval24.service.DeptService;
@Controller
public class DeptController {
	@Autowired
	DeptService deptService;
	
	// 부서목록
	@GetMapping("/dept")
	public String deptList(DeptDTO filter, Model model) {
		
		// 최초 징비 (빈 리스트)
		if (filter.isEmptyFilter()) {
			model.addAttribute("deptList", Collections.emptyList());
			model.addAttribute("filter", filter);
			model.addAttribute("totalCount", 0);
			model.addAttribute("totalPages", 0);
			return "A/dept";
		}
		// 조건 검색
		int totalCount = deptService.countDepts(filter);
		List<DeptDTO> deptList = deptService.searchDepts(filter);
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("filter", filter);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount /filter.getSize()));
		return "A/dept";
	}
	
	// 부서상세
	@GetMapping("/dept/detail")
	public String divisionDetail(Model model, @RequestParam("dept_id") long deptId) {
		model.addAttribute("instByDeptList", deptService.instByDept(deptId));
		model.addAttribute("deptInfo", deptService.deptInfo(deptId));
		model.addAttribute("getAllInst", deptService.getAllInst());
		return "A/deptDetail";
	}
	
	
	// 부서수정
	@PostMapping("/dept/update")
	public String deptUpdate(@RequestParam("deptId") long deptId,
							 @RequestParam("deptName") String deptName,
							 @RequestParam(value="deptPhone", required=false) String deptPhone,
							 @RequestParam(value="delYn") String delYn,
							 @RequestParam(value="instIds", required=false) List<Long> instIds,
							 RedirectAttributes rttr) {
		
		List<Long> safeInstIds = (instIds == null) ? Collections.emptyList() : instIds;
		
		long result = deptService.updateDept(deptId, deptName, deptPhone, delYn, safeInstIds);
		
		if(result > 0) {
			rttr.addFlashAttribute("updMessage", "부서 정보가 성공적으로 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("updMessage", "부서 정보 수정에 실패했습니다.");
		}
		return "redirect:/dept/detail?dept_id=" + deptId;
	}
	
	// 부서 삭제
	@PostMapping("/dept/delete")
	public String deptDelete(long deptId, RedirectAttributes rttr) {
		int result = deptService.deleteDept(deptId);
		
		if (result > 0) {
			rttr.addFlashAttribute("delMessage", "부서 정보가 성공적으로 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("delMessage", "부서 정보 삭제에 실패했습니다.");
		}
		return "redirect:/dept";
	}
	
	// 부서 등록
	@GetMapping("/dept/new")
	public String deptNew(Model model) {
		model.addAttribute("getAllInst", deptService.getAllInst());
		return "A/deptNew";
	}
	
	@PostMapping("/dept/new")
	public String deptNew(@RequestParam("deptName") String deptName,
						  @RequestParam(value="deptPhone", required=false) String deptPhone,
						  @RequestParam(value="instIds", required=false) List<Long> instIds,
						  RedirectAttributes rttr) {
		List<Long> safeInstIds = (instIds == null) ? Collections.emptyList() : instIds;
		long result = deptService.insertDept(deptName, deptPhone, safeInstIds);
		
		if(result > 0) {
			rttr.addFlashAttribute("insertMessage", "부서 정보가 성공적으로 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("insertMessage", "부서 정보 등록에 실패했습니다.");
		}
		
		return "redirect:/dept";
		
	}
}
