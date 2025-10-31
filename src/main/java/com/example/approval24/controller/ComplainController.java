package com.example.approval24.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.domain.ComplainRegDTO;
import com.example.approval24.domain.ComplainuserDTO;
import com.example.approval24.domain.UE1DTO;
import com.example.approval24.domain.UE2DTO;
import com.example.approval24.service.CategoryService;
import com.example.approval24.service.ComplainService;
import com.example.approval24.service.ComplainuserService;

@Controller
public class ComplainController {

	@Autowired
	private ComplainService complainService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ComplainuserService complainuserService;

	public long accountId = 13;

	@GetMapping("/myWork")
	public String myWorkList(Model model
	// ,HttpSession session(여기서 현재 로그인id 가져오기)
	) {

		List<ComplainDTO> myWorkList = complainService.getMyWorkList(accountId);

		model.addAttribute("myWorkList", myWorkList);

		return "myWork";
	}

	@GetMapping("/complain/new")
	public String complainRegForm(Model model) {
		List<CategoryDTO> categories = categoryService.getCategoryList();
		// System.out.println(categories.toString());
		model.addAttribute("categoryList", categories);

		return "complain/regEditForm/complainRegForm";

	}

	@PostMapping("/complain/new")
	public String complainRegist(Model model, ComplainRegDTO complainRegDTO
	// ,HttpSession session(여기서 현재 로그인id 가져오기)
	) {
		complainService.complainRegister(complainRegDTO, accountId);

		return "redirect:/";

	}

	@GetMapping("/complains")
	public String complainList(Model model
	// ,HttpSession session(여기서 현재 로그인id가져오기)
	) {
//		System.out.println("controller in");
		List<ComplainDTO> complainList = complainService.complainList(accountId);
		model.addAttribute("complainList", complainList);
//		System.out.println(complainList.toString());
//		System.out.println("contorller out");

		return "/complain/complainList";

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
		model.addAttribute("user", complainuserDTO);
		model.addAttribute("detail", ue1DTO);

		return "complain/regEditForm/ue1";
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
		model.addAttribute("user", complainuserDTO);
		model.addAttribute("detail", ue2DTO);

		return "complain/regEditForm/ue2";
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
	public String tempWorker(@PathVariable int complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		model.addAttribute("user", complainuserDTO);

		return "complain/regEditForm/mt1";
	}

	// 고용보험 미적용자 출산 급여 신청
	@GetMapping("/mt2/{complainId}")
	public String insurance(@PathVariable int complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		model.addAttribute("user", complainuserDTO);

		return "complain/regEditForm/mt2";

	}

	// 청년 빈 일자리 취업지원 특화 프로그램 수당 지급신청
	@GetMapping("/em1/{complainId}")
	public String subsidy(@PathVariable int complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		model.addAttribute("user", complainuserDTO);

		return "complain/regEditForm/em1";
	}

	// 청년 도전 사업 지원 신청
	@GetMapping("/em2/{complainId}")
	public String challenge(@PathVariable int complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		model.addAttribute("user", complainuserDTO);

		return "complain/regEditForm/em2";
	}

	// 졸업생 특화 프로그램 신청
	@GetMapping("/em3/{complainId}")
	public String graduateProgram(@PathVariable int complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		model.addAttribute("user", complainuserDTO);

		return "complain/regEditForm/em3";

	}

}
