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

	@GetMapping("/list")
	public String complainList(Model model, HttpSession session) {
//		System.out.println("controller in");
		Long accountId = (Long) session.getAttribute("user");

		String title = "접수 민원 목록";
		List<ComplainDTO> complainList = complainService.complainList(accountId);
		System.out.println("확인 = " + complainList.toString());
		model.addAttribute("complainList", complainList);
		model.addAttribute("title", title);
//		System.out.println(complainList.toString());
//		System.out.println("contorller out");

		return "/C/complainList";

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

		System.out.println("****확인입니다.");
		System.out.println(complainList.toString());

		model.addAttribute("complainList", complainList);
		model.addAttribute("categoryUrl", categoryUrl);
		model.addAttribute("title", categoryService.getCategoryName(categoryUrl));
		model.addAttribute("filter", filter);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));

		return "C/complainList";
	}

	// 실업자취업훈련비 대부신청
	@GetMapping("/ue1/{complainId}")
	public String trainingLoan(@PathVariable long complainId, Model model) {
		System.out.println("ue1 controller진입");
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());
		System.out.println(complainuserDTO.toString());

		UE1DTO ue1DTO = complainService.getUE1Info(complainId);
		System.out.println(ue1DTO.toString());
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", ue1DTO);

		return "C/regEditForm/ue1";
	}

	@PostMapping("/ue1/{complainId}")
	public String submitTrainingLoan(@PathVariable long complainId, UE1DTO ue1DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		System.out.println("post 진입");
		System.out.println(complainuserDTO);
		complainuserService.saveComplainuser(complainuserDTO);

		System.out.println(ue1DTO);
		complainService.saveue1(ue1DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/ue1/" + complainId;
	}

	// 실업인정신청
	@GetMapping("/ue2/{complainId}")
	public String report(@PathVariable long complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());
		System.out.println(complainuserDTO.toString());

		UE2DTO ue2DTO = complainService.getUE2Info(complainId);
		System.out.println("Get : " + ue2DTO.toString());
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", ue2DTO);

		return "C/regEditForm/ue2";
	}

	@PostMapping("/ue2/{complainId}")
	public String submitreport(@PathVariable long complainId, UE2DTO ue2DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		System.out.println("post 진입");
		System.out.println(complainuserDTO);
		complainuserService.saveComplainuser(complainuserDTO);

		System.out.println(ue2DTO);
		complainService.saveue2(ue2DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/ue2/" + complainId;
	}

	// 기간제 파견근로자 출산 전후 휴가 급여신청
	@GetMapping("/mt1/{complainId}")
	public String tempWorker(@PathVariable long complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());
		System.out.println(complainuserDTO.toString());

		MT1DTO mt1DTO = complainService.getMT1Info(complainId);
		System.out.println("Get : " + mt1DTO.toString());
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", mt1DTO);

		return "C/regEditForm/mt1";
	}

	@PostMapping("/mt1/{complainId}")
	public String submitTempWorker(@PathVariable long complainId, MT1DTO mt1DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		System.out.println("post 진입");
		System.out.println(complainuserDTO);
		complainuserService.saveComplainuser(complainuserDTO);

		System.out.println(mt1DTO);
		complainService.savemt1(mt1DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/mt1/" + complainId;
	}

	// 고용보험 미적용자 출산 급여 신청
	@GetMapping("/mt2/{complainId}")
	public String noInsurance(@PathVariable int complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());
		System.out.println(complainuserDTO.toString());

		MT2DTO mt2DTO = complainService.getMT2Info(complainId);
		System.out.println("Get : " + mt2DTO.toString());
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", mt2DTO);

		return "C/regEditForm/mt2";

	}

	@PostMapping("/mt2/{complainId}")
	public String submitNoInsurance(@PathVariable long complainId, MT2DTO mt2DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		System.out.println("post 진입");
		System.out.println(complainuserDTO);
		complainuserService.saveComplainuser(complainuserDTO);

		System.out.println(mt2DTO);
		complainService.savemt2(mt2DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/mt2/" + complainId;
	}

	// 청년 빈 일자리 취업지원 특화 프로그램 수당 지급신청
	@GetMapping("/em1/{complainId}")
	public String emptyWork(@PathVariable int complainId, Model model, HttpSession session, HttpServletRequest req) {
		System.out.println("!!!!!!!!!!!!!!!!!controller입니다.");

		MenuVO pageAuth = (MenuVO) req.getAttribute("pageAuth");

		// 권한 확인 (Null 체크 필수!)
		if (pageAuth != null) {
			System.out.println("**** [Auth Check] 현재 메뉴: " + pageAuth.getMenuName());
			System.out.println("**** [Auth Check] 읽기 권한: " + pageAuth.getReadYn());
			System.out.println("**** [Auth Check] 수정 권한: " + pageAuth.getUpdateYn());
			System.out.println("**** [Auth Check] 등록 권한: " + pageAuth.getCreateYn());
			System.out.println("**** [Auth Check] 승인 권한: " + pageAuth.getApproveYn());
			System.out.println("**** [Auth Check] 삭제 권한: " + pageAuth.getDeleteYn());

		} else {
			System.out.println("**** [Auth Check] 이 URL에 대한 메뉴 권한 정보를 찾을 수 없습니다.");

		}
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		System.out.println("****민원내용 확인 = " + complainDTO.toString());

		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());
		System.out.println("****민원인정보 확인 = " + complainuserDTO.toString());

		EM1DTO em1DTO = complainService.getEM1Info(complainId);
		System.out.println("****GET EM1정보 확인 : " + em1DTO.toString());

		model.addAttribute("complainInfo", complainDTO);
		model.addAttribute("pageAuth", pageAuth);
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", em1DTO);
		System.out.println("!!!!!!!!!!!!!!!!!controller 끝입니다.");

		return "C/regEditForm/em1";

	}

	@PostMapping("/em1/{complainId}")
	public String submitEmptyWork(@PathVariable long complainId, EM1DTO em1DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		System.out.println("post 진입");
		System.out.println(complainuserDTO);
		complainuserService.saveComplainuser(complainuserDTO);

		System.out.println(em1DTO);
		complainService.saveem1(em1DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/em1/" + complainId;
	}

	// 청년 도전 사업 지원 신청
	@GetMapping("/em2/{complainId}")
	public String youthChallange(@PathVariable int complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());
		System.out.println(complainuserDTO.toString());

		EM2DTO em2DTO = complainService.getEM2Info(complainId);
		System.out.println("Get : " + em2DTO.toString());
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", em2DTO);

		return "C/regEditForm/em2";

	}

	@PostMapping("/em2/{complainId}")
	public String submitYouthChallange(@PathVariable long complainId, EM2DTO em2DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		System.out.println("post 진입");
		System.out.println(complainuserDTO);
		complainuserService.saveComplainuser(complainuserDTO);

		System.out.println(em2DTO);
		complainService.saveem2(em2DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/em2/" + complainId;
	}

	// 졸업생 특화 프로그램 신청
	@GetMapping("/em3/{complainId}")
	public String graduateProgram(@PathVariable int complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());
		System.out.println(complainuserDTO.toString());

		EM3DTO em3DTO = complainService.getEM3Info(complainId);
		System.out.println("Get : " + em3DTO.toString());
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", em3DTO);

		return "C/regEditForm/em3";

	}

	@PostMapping("/em3/{complainId}")
	public String submitGraduateProgram(@PathVariable long complainId, EM3DTO em3DTO, ComplainuserDTO complainuserDTO,
			RedirectAttributes redirectAttributes) {

		System.out.println("post 진입");
		System.out.println(complainuserDTO);
		complainuserService.saveComplainuser(complainuserDTO);

		System.out.println(em3DTO);
		complainService.saveem3(em3DTO);

		// 등록 완료 후 리다이렉트 (예: 상세 페이지나 목록)
		redirectAttributes.addFlashAttribute("msg", "정상저장 되었습니다.");
		return "redirect:/em3/" + complainId;
	}

}
