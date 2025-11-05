package com.example.approval24.controller;

import java.util.ArrayList;
import java.util.Arrays;
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

import com.example.approval24.dao.AuthorityDeptDAO;
import com.example.approval24.dao.DeptInstDAO;
import com.example.approval24.dao.InstDAO;
import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.AuthorityAccountDTO;
import com.example.approval24.domain.AuthorityDTO;
import com.example.approval24.domain.AuthorityDeptDTO;
import com.example.approval24.domain.DeptDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.InstDTO;
import com.example.approval24.domain.RequestDTO;
import com.example.approval24.domain.UserDTO;
import com.example.approval24.service.AuthorityService;
import com.example.approval24.service.DeptService;
import com.example.approval24.service.SignUpService;
import com.example.approval24.service.UserService;

@Controller
@RequestMapping("/signup") 
public class SignupController {
	
	@Autowired
	private SignUpService signUpService; 
	
	@Autowired
	private UserService userService; 
	
	@Autowired
	private   InstDAO instDAO;
	
	@Autowired
	private DeptInstDAO deptInstDAO;
	
	@Autowired
	private AuthorityDeptDAO authDeptDAO;
	

	
	 // 회원가입
    @GetMapping("/Form")
    public String loginPage(Model model) {
    	List<InstDTO> inst = instDAO.getAllInst();
    	model.addAttribute("instList", inst);
        return "/B/signUp"; 
    }
    
    // 부서 목록
    @ResponseBody
    @GetMapping("/getDeptList")
    public List<DeptInstDTO> getDeptList(@RequestParam("instId") long instId) {
    	List<DeptInstDTO> deptList = deptInstDAO.findDeptByInst(instId);
    	return deptList;
    }
    
    // 권한 목록
    @ResponseBody
    @GetMapping("/getAuthList")
    public List<AuthorityDTO> getAuthList(@RequestParam("deptId") long deptId) {
    
    	List<AuthorityDTO> authList = authDeptDAO.getAuthoritysByDeptId(deptId);
    	
    	System.out.println(authList.toString());
    	return authList;
    }
    
    //회원가입 신청
    @PostMapping("/approveForm")
    public String approveRequest(@RequestParam Map<String,Object> m,
    		 @RequestParam(value = "authorityIds", required = false) List<String> authorityIds)  {
    	System.out.println("계정신청 컨트롤러 받음");
    	// 주민번호가 공란일때
    	String residentNo = (String) m.get("residentNo"); 
    	if(residentNo == null || residentNo.isEmpty()) {
    			throw new IllegalArgumentException("주민번호가 입력되지 않았습니다.");
    		}
    	UserDTO userdto = userService.getUserDetailByResidentNo(residentNo);
    	if(userdto == null) {
    		throw new IllegalArgumentException("해당하는 직원이 없습니다.");
    		}
    		// 생성된 계정 id
    		Long accountId = signUpService.approveRequest(m);
    		// 권한 id 만큼 반복(null 확인)
    		if(authorityIds != null && !authorityIds.isEmpty()) {
    			List<AuthorityAccountDTO> authList = new ArrayList<>();
        		for(String id : authorityIds) {
        			AuthorityAccountDTO dto = new AuthorityAccountDTO();
        			dto.setAuthorityId(Long.parseLong(id));
        			dto.setAccountId(accountId);
        			authList.add(dto);
        		}
        		// 길이 만큼 서비스 로직 반복
        		for(AuthorityAccountDTO d : authList) {
        			signUpService.authAccountSetup(d);
        		}
        		
    		}   		 
    		 return "redirect:/";
    
    }
    
    
    // 아이디 중복체크
    @GetMapping("/checkID")
    @ResponseBody
    public boolean checkID(@RequestParam String loginId){
    	boolean isDuplicated = signUpService.checkID(loginId);	
    	return isDuplicated;
    }
	
}
