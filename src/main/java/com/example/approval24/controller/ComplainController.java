package com.example.approval24.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.ApprovalHistoryDTO;
import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.domain.ComplainFilterDTO;
import com.example.approval24.domain.ComplainRegDTO;
import com.example.approval24.domain.ComplainuserDTO;
import com.example.approval24.domain.EM1DTO;
import com.example.approval24.domain.EM2DTO;
import com.example.approval24.domain.EM3DTO;
import com.example.approval24.domain.MT1DTO;
import com.example.approval24.domain.MT2DTO;
import com.example.approval24.domain.MenuVO;
import com.example.approval24.domain.UE1DTO;
import com.example.approval24.domain.UE2DTO;
import com.example.approval24.service.ApprovalHistoryService;
import com.example.approval24.service.CategoryService;
import com.example.approval24.service.ComplainService;
import com.example.approval24.service.ComplainuserService;

@Controller
@RequestMapping("/complain")
public class ComplainController {

	@Autowired
	private ComplainService complainService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ComplainuserService complainuserService;
	
	@Autowired
	private ApprovalHistoryService historyService;

	@GetMapping("/myWork")
	public String myWorkList(Model model, HttpSession session) {
		Long accountId = (Long) session.getAttribute("user");

		List<ComplainDTO> myWorkList = complainService.getMyWorkList(accountId);

		model.addAttribute("myWorkList", myWorkList);

		return "myWork";
	}

	// 민원 접수 등록 이동(현재 로그인 한 계정의 부서 업무만 접수가능)
	@GetMapping("/new")
	public String complainRegForm(Model model, HttpSession session) {
		Long accountId = (Long) session.getAttribute("user");
		List<CategoryDTO> categories = new ArrayList<>();
		if (accountId != null) {
			categories = categoryService.getCategoryListByAccountId(accountId);
		}
		model.addAttribute("categoryList", categories);

		return "C/regEditForm/complainRegForm";

	}

	// 민원 접수 등록 form 제출
	@PostMapping("/new")
	public String complainRegist(Model model, ComplainRegDTO complainRegDTO, HttpSession session) {
		Long accountId = (Long) session.getAttribute("user");
		complainService.complainRegister(complainRegDTO, accountId);

		return "redirect:/";

	}
	
	//민원 접수 목록(filter 적용)
	@GetMapping("/list")
	public String complainList(Model model, ComplainFilterDTO filter, HttpSession session) {
		Long accountId = (Long) session.getAttribute("user");
		String title = "접수 민원 목록";
		
		//계정이 속한 부서의 민원서식목록(id, name)
		List<CategoryDTO> categoryList = categoryService.getCategoryListByAccountId(accountId);
		model.addAttribute("title", title);													//제목
		model.addAttribute("categoryList",categoryList);									//계정이 속한 부서의 민원서식목록

		// 초기 진입(검색 없음)
		if (filter.isEmptyFilter()) {
			model.addAttribute("complainList", java.util.Collections.emptyList());			//빈  민원목록
			model.addAttribute("filter", filter);											//필터
			return "C/complainListMydept";
		}
		
		//필터조건에 맞는 리스트 찾기
		int totalCount = complainService.countComplainsByDept(filter, accountId);
		List<ComplainDTO> complainList = complainService.complainListByDept(filter, accountId);
	 
		model.addAttribute("categoryList",categoryList);								//계정이 속한 부서의 민원서식목록
		model.addAttribute("complainList", complainList);								//민원 목록
		model.addAttribute("filter", filter); 											//filter 조건
		model.addAttribute("totalCount", totalCount); 									//총 개수
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));	//토탈페이지개수


		return "/C/complainListMydept";

	}

	// 카테고리별 민원 리스트(조건별 검색)
	@GetMapping("/category/{categoryUrl}")
	public String complainsList(@PathVariable String categoryUrl, ComplainFilterDTO filter, Model model) {

		// 카테고리 설정
		filter.setCategoryUrl(categoryUrl);
		filter.setComplainCategoryId(categoryService.getCategoryIdByUrl(categoryUrl));

		// 초기 진입(검색 없음)
		if (filter.isEmptyFilter()) {
			model.addAttribute("complainList", java.util.Collections.emptyList());
			model.addAttribute("title", categoryService.getCategoryName(categoryUrl));
			model.addAttribute("filter", filter);
			return "C/complainList";
		}

		// 검색 결과
		int totalCount = complainService.countComplains(filter);
		List<ComplainDTO> complainList = complainService.searchComplains(filter);
	
		model.addAttribute("complainList", complainList);							//민원목록
		model.addAttribute("categoryUrl", categoryUrl);								//카테고리url
		model.addAttribute("title", categoryService.getCategoryName(categoryUrl)); 	//민원서식명(카테고리명)
		model.addAttribute("filter", filter); 										//filter 조건
		model.addAttribute("totalCount", totalCount); 								//총 개수
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));	//토탈페이지개수
		

		return "C/complainList";
	}

	// 실업자취업훈련비 대부신청
	@GetMapping("/category/ue1/{complainId}")
	public String trainingLoan(@PathVariable int complainId, Model model, HttpSession session, HttpServletRequest req) {
		MenuVO pageAuth = (MenuVO) req.getAttribute("pageAuth");
		
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());


		UE1DTO ue1DTO = complainService.getUE1Info(complainId);
		
		model.addAttribute("complainInfo", complainDTO);
		model.addAttribute("pageAuth", pageAuth);
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", ue1DTO);

		return "C/regEditForm/ue1";
	}

	@PostMapping("/category/ue1/{complainId}")
	public String submitTrainingLoan(@PathVariable long complainId, UE1DTO ue1DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {


		complainuserService.saveComplainuser(complainuserDTO);

		complainService.saveue1(ue1DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/complain/category/ue1/" + complainId;
	}

	// 실업인정신청
	@GetMapping("/category/ue2/{complainId}")
	public String report(@PathVariable int complainId, Model model, HttpSession session, HttpServletRequest req) {
		MenuVO pageAuth = (MenuVO) req.getAttribute("pageAuth");
		
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		UE2DTO ue2DTO = complainService.getUE2Info(complainId);
		
		model.addAttribute("complainInfo", complainDTO);
		model.addAttribute("pageAuth", pageAuth);
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", ue2DTO);

		return "C/regEditForm/ue2";
	}

	@PostMapping("/category/ue2/{complainId}")
	public String submitreport(@PathVariable long complainId, UE2DTO ue2DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		complainuserService.saveComplainuser(complainuserDTO);

		complainService.saveue2(ue2DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/complain/category/ue2/" + complainId;
	}

	// 기간제 파견근로자 출산 전후 휴가 급여신청
	@GetMapping("/category/mt1/{complainId}")
	public String tempWorker(@PathVariable int complainId, Model model, HttpSession session, HttpServletRequest req) {
		MenuVO pageAuth = (MenuVO) req.getAttribute("pageAuth");
		
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		MT1DTO mt1DTO = complainService.getMT1Info(complainId);
		
		model.addAttribute("complainInfo", complainDTO);
		model.addAttribute("pageAuth", pageAuth);
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", mt1DTO);

		return "C/regEditForm/mt1";
	}

	@PostMapping("/category/mt1/{complainId}")
	public String submitTempWorker(@PathVariable long complainId, MT1DTO mt1DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		complainuserService.saveComplainuser(complainuserDTO);

		complainService.savemt1(mt1DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/complain/category/mt1/" + complainId;
	}

	// 고용보험 미적용자 출산 급여 신청
	@GetMapping("/category/mt2/{complainId}")
	public String noInsurance(@PathVariable int complainId, Model model, HttpSession session, HttpServletRequest req) {
		MenuVO pageAuth = (MenuVO) req.getAttribute("pageAuth");
		
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		MT2DTO mt2DTO = complainService.getMT2Info(complainId);
		
		model.addAttribute("complainInfo", complainDTO);
		model.addAttribute("pageAuth", pageAuth);
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", mt2DTO);

		return "C/regEditForm/mt2";

	}

	@PostMapping("/category/mt2/{complainId}")
	public String submitNoInsurance(@PathVariable long complainId, MT2DTO mt2DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		complainuserService.saveComplainuser(complainuserDTO);

		complainService.savemt2(mt2DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/complain/category/mt2/" + complainId;
	}

	// 청년 빈 일자리 취업지원 특화 프로그램 수당 지급신청
	@GetMapping("/category/em1/{complainId}")
	public String emptyWork(@PathVariable int complainId, Model model, HttpSession session, HttpServletRequest req) {

		MenuVO pageAuth = (MenuVO) req.getAttribute("pageAuth");

		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);

		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		EM1DTO em1DTO = complainService.getEM1Info(complainId);

		model.addAttribute("complainInfo", complainDTO);
		model.addAttribute("pageAuth", pageAuth);
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", em1DTO);

		return "C/regEditForm/em1";

	}

	//수정부분
	//
	//
	//


	
	//수정
	@PostMapping("/category/em1/{complainId}")
	public String submitEmptyWork(@PathVariable long complainId, EM1DTO em1DTO, ComplainuserDTO complainuserDTO,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		
		Long userId = (Long) session.getAttribute("user");
		ComplainDTO complainDTO = complainService.getComplainById(complainId);
		boolean check = historyService.checkHistoryIng(complainId,userId);
		
		if(complainDTO == null) {
			redirectAttributes.addFlashAttribute("msg", "민원이 존재하지 않습니다.");
			return "redirect:/complain/category/em1/" + complainId;
		}
		else if(!((Long)complainDTO.getAccountId()).equals(userId)) {
			redirectAttributes.addFlashAttribute("msg", "해당 담당자가 아닙니다.");
			return "redirect:/complain/category/em1/" + complainId;
		}
		else if(check) {
			redirectAttributes.addFlashAttribute("msg", "결재 중에 수정할 수 없습니다.");
			return "redirect:/complain/category/em1/" + complainId;
		}
		else if(!complainDTO.getComplainStatusCd().equals("D001") && !complainDTO.getComplainStatusCd().equals("D002")) {
			redirectAttributes.addFlashAttribute("msg", "민원 상태를 변경할 수 없습니다."); 
			return "redirect:/complain/category/em1/" + complainId;
		}
		complainuserService.saveComplainuser(complainuserDTO);
		complainService.saveem1(em1DTO);

		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/complain/category/em1/" + complainId;
	}
	//
	//
	//
	//
	//
	//
	//
	

	// 청년 도전 사업 지원 신청
	@GetMapping("/category/em2/{complainId}")
	public String youthChallange(@PathVariable int complainId, Model model, HttpSession session, HttpServletRequest req) {
		MenuVO pageAuth = (MenuVO) req.getAttribute("pageAuth");
		
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		EM2DTO em2DTO = complainService.getEM2Info(complainId);
		
		model.addAttribute("complainInfo", complainDTO);
		model.addAttribute("pageAuth", pageAuth);
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", em2DTO);

		return "C/regEditForm/em2";

	}

	@PostMapping("/category/em2/{complainId}")
	public String submitYouthChallange(@PathVariable long complainId, EM2DTO em2DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		complainuserService.saveComplainuser(complainuserDTO);

		complainService.saveem2(em2DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/complain/category/em2/" + complainId;
	}

	// 졸업생 특화 프로그램 신청
	@GetMapping("/category/em3/{complainId}")
	public String graduateProgram(@PathVariable int complainId, Model model, HttpSession session, HttpServletRequest req) {
		MenuVO pageAuth = (MenuVO) req.getAttribute("pageAuth");
		
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		EM3DTO em3DTO = complainService.getEM3Info(complainId);
		
		model.addAttribute("complainInfo", complainDTO);
		model.addAttribute("pageAuth", pageAuth);
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", em3DTO);

		return "C/regEditForm/em3";

	}

	@PostMapping("/category/em3/{complainId}")
	public String submitGraduateProgram(@PathVariable long complainId, EM3DTO em3DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		complainuserService.saveComplainuser(complainuserDTO);

		complainService.saveem3(em3DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/complain/category/em3/" + complainId;
	}

}
