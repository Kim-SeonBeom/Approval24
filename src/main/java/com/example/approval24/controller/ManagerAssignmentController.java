package com.example.approval24.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.ManagerAssignmentDTO;
import com.example.approval24.service.ManagerAssignmentService;

@Controller
public class ManagerAssignmentController {
	@Autowired
	ManagerAssignmentService MAService;
	
	// 담당자배정 목록 (id에 따른 name 가져오기)
	@GetMapping("/MA")
	public String mangerAssignment(ManagerAssignmentDTO filter, Model model) {
		
		// 최초 진입 (빈 리스트)
		if (filter.isEmptyFilter()) {
			model.addAttribute("MAList", Collections.emptyList());
			model.addAttribute("filter", filter);
			model.addAttribute("totalCount", 0);
			model.addAttribute("totalPages", 0);
			return "A/managerAssignment";
		}
		
		// 조건 검색
		int totalCount = MAService.countMA(filter);
		List<ManagerAssignmentDTO> MAList = MAService.searchMA(filter);
		
		model.addAttribute("MAList", MAList);
		model.addAttribute("filter", filter);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));
		return "A/managerAssignment";
	}
	
	// 담당자배정 상세
	@GetMapping("/MA/detail")
	public String MADetail(@RequestParam("inst_id") long instId,
					 @RequestParam("dept_id") long deptId,
					 @RequestParam("complain_category_id") long complainCategoryId,
					 @RequestParam("account_id") long accountId,
					 ManagerAssignmentDTO managerDTO,
					 Model model) {
		
		managerDTO.setInstId(instId);
	    managerDTO.setDeptId(deptId);
	    managerDTO.setComplainCategoryId(complainCategoryId);
	    managerDTO.setAccountId(accountId);
		
		
		model.addAttribute("MAInfo", MAService.ManagerAssignmentInfo(managerDTO));
		return "A/managerAssignmentDetail";
	}
	
	// 담당자배정 수정, 삭제
	@PostMapping("/MA/update")
	public String MAUpdate(ManagerAssignmentDTO managerDTO, RedirectAttributes rttr, HttpSession session) {
		
		Long id = (Long)session.getAttribute("user");
		if(id == null) {
			rttr.addFlashAttribute("updMessage", "로그인 정보가 없습니다. 로그인 해주세요.");
		}
		
		managerDTO.setUpdateId(id);
		System.out.println(managerDTO);
		int result = MAService.ManagerAssignmentUpd(managerDTO);
		
		if(result > 0) {
			rttr.addFlashAttribute("updMessage", "담당자배정 정보가 성공적으로 변경되었습니다.");
		} else {
			rttr.addFlashAttribute("updMessage", "담당자배정 정보 변경에 실패하였습니다.");
		}
		return "redirect:/MA/detail"
	     + "?inst_id=" + managerDTO.getInstId()
	     + "&dept_id=" + managerDTO.getDeptId()
	     + "&complain_category_id=" + managerDTO.getComplainCategoryId()
	     + "&account_id=" + managerDTO.getAccountId();

	}
	
	// 담당자배정 등록
	@GetMapping("/MA/new")
	public String MANew(Model model, @RequestParam(value = "inst_id", required = false) Long instId,
									 @RequestParam(value = "dept_id", required = false) Long deptId) {
		model.addAttribute("getAllInst", MAService.getAllInst());
		model.addAttribute("deptByInst", MAService.findDeptByInst(instId));
		model.addAttribute("categoryByDept", MAService.findCategoryByDept(deptId));
		model.addAttribute("accountByDept", MAService.findAccountByDept(deptId));
		return "A/managerAssignmentNew";
	}
	
	
    // ===== AJAX JSON 엔드포인트 =====
    // 기관 → 부서
    @GetMapping(value = "/MA/depts", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<DeptInstDTO> getDeptsByInst(@RequestParam("inst_id") Long instId) {
        if (instId == null) return Collections.emptyList();
        return MAService.findDeptByInst(instId);
    }

    // 부서 → 민원서식
    @GetMapping(value = "/MA/categories", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<CategoryDTO> getCategoriesByDept(@RequestParam("dept_id") Long deptId) {
        if (deptId == null) return Collections.emptyList();
        return MAService.findCategoryByDept(deptId);
    }

    // 부서 → 계정(사용자)
    @GetMapping(value = "/MA/accounts", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<AccountDTO> getAccountsByDept(@RequestParam("dept_id") Long deptId) {
        if (deptId == null) return Collections.emptyList();
        return MAService.findAccountByDept(deptId);
    }
	
	@PostMapping("/MA/new")
	public String MANew(ManagerAssignmentDTO managerDTO, RedirectAttributes rttr, HttpSession session) {
		
		Long id = (Long)session.getAttribute("user");
		if(id == null) {
			rttr.addFlashAttribute("insertMessage", "로그인 정보가 없습니다. 로그인 해주세요.");
		}
		managerDTO.setCreateId(id);
		
		int result = MAService.ManagerAssignmentInsert(managerDTO);
		
		if(result > 0) {
			rttr.addFlashAttribute("insertMessage", "담당자배정 정보가 성공적으로 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("insertMessage", "담당자배정 등록에 실패했습니다.");
		}
		
		return "redirect:/MA";
	}
	
}
