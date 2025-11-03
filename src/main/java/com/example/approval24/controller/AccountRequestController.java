package com.example.approval24.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.approval24.domain.AuthorityDTO;
import com.example.approval24.domain.DeptDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.InstDTO;
import com.example.approval24.domain.RequestDTO;
import com.example.approval24.service.AuthorityService;
import com.example.approval24.service.DeptService;
import com.example.approval24.service.RequestService;

@Controller
@RequestMapping("/account") 
public class AccountRequestController {
	
	@Autowired
	private RequestService requestService; 
	
	 // 회원가입
    @GetMapping("/requestAccountForm")
    public String loginPage(Model model) {
    	List<InstDTO> inst = requestService.instList();
    	model.addAttribute("instList", inst);
    	// 권한 목록
    	List<RequestDTO> authList = requestService.getAllAuthorities();
    	model.addAttribute("authList", authList);
        return "accountRequest"; 
    }
    
    // 부서 목록
    @ResponseBody
    @GetMapping("/getDeptList")
    public List<DeptInstDTO> getDeptList(@RequestParam("instId") long instId) {
    	List<DeptInstDTO> deptList = requestService. getdeptList(instId);
    	return deptList;
    }
    
    //회원가입 신청
    @PostMapping("/approveForm")
    public String approveRequest(RequestDTO requestDTO) {
    	System.out.println("계정신청 컨트롤러 받음");
    	requestService.approveRequest(requestDTO);
    	return "index";
    }
    
    
    // 아이디 중복체크
    @GetMapping("/checkID")
    @ResponseBody
    public Map<String, Boolean> checkID(@RequestParam String loginId){
    	boolean isDuplicated = requestService.checkID(loginId);	
    	boolean isAvailable = !isDuplicated;
    	
    	Map<String, Boolean> result = new HashMap<>();
    	result.put("available", isAvailable);
    	return result;
    }
	
}
