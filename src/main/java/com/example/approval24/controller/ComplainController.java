package com.example.approval24.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
public class ComplainController {

	@Autowired
	private ComplainService complainService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ComplainuserService complainuserService;

	// 임시로 넣은 계정ID 13,41,61
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

		String title = "접수 민원 목록";
		List<ComplainDTO> complainList = complainService.complainList(accountId);
		System.out.println("확인 = " + complainList.toString());
		model.addAttribute("complainList", complainList);
		model.addAttribute("title", title);
//		System.out.println(complainList.toString());
//		System.out.println("contorller out");

		return "/complain/complainList";

	}

	@GetMapping("/{categoryUrl}")
	public String ue1List(Model model, @PathVariable String categoryUrl) {
		String categoryName = categoryService.getCategoryName(categoryUrl);
		List<ComplainDTO> complainList = complainService.complainsByCategory(categoryUrl);
		System.out.println("확인 = " + complainList.toString());
		model.addAttribute("title", categoryName);
		model.addAttribute("complainList", complainList);

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
		model.addAttribute("userInfo", complainuserDTO);
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
		model.addAttribute("userInfo", complainuserDTO);
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
	public String tempWorker(@PathVariable long complainId, Model model) {
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);
		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());
		System.out.println(complainuserDTO.toString());

		MT1DTO mt1DTO = complainService.getMT1Info(complainId);
		System.out.println("Get : " + mt1DTO.toString());
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", mt1DTO);

		return "complain/regEditForm/mt1";
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

		return "complain/regEditForm/mt2";

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
	public String emptyWork(@PathVariable int complainId, Model model,HttpSession session,HttpServletRequest req) {
		//저장된 페이지별 권한불러오기
        MenuVO pageAuth = (MenuVO) req.getAttribute("pageAuth");

        // 권한 확인 (Null 체크 필수!)
        if (pageAuth != null) {
        } else {
            System.out.println("**** [Auth Check] 이 URL에 대한 메뉴 권한 정보를 찾을 수 없습니다.");

        }
		ComplainDTO complainDTO = complainService.getComplainInfo(complainId);

		ComplainuserDTO complainuserDTO = complainuserService.complainuserInfo(complainDTO.getComplainuserNo());

		EM1DTO em1DTO = complainService.getEM1Info(complainId);
		
		model.addAttribute("complainInfo", complainDTO);
		model.addAttribute("pageAuth", pageAuth);
		model.addAttribute("userInfo", complainuserDTO);
		model.addAttribute("detail", em1DTO);

		return "complain/regEditForm/em1";

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

		return "complain/regEditForm/em2";

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

		return "complain/regEditForm/em3";

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
