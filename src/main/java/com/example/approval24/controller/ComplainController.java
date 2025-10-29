package com.example.approval24.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.domain.ComplainRegDTO;
import com.example.approval24.service.CategoryService;
import com.example.approval24.service.ComplainService;

@Controller("/complain")
public class ComplainController {

	@Autowired
	private ComplainService complainService;

	@Autowired
	private CategoryService categoryService;

	public int accountId = 13;

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
		//		System.out.println(categories.toString());
		model.addAttribute("categoryList", categories);

		return "complain/regEditForm/complainRegForm";

	}

	@PostMapping("/complain/new")
	public String complainRegist(Model model, ComplainRegDTO complainRegDTO
			//,HttpSession session(여기서 현재 로그인id 가져오기)
			) {
		complainService.complainRegister(complainRegDTO,accountId);
		
		return "redirect:/";

	}

}
