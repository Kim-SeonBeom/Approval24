package com.example.approval24.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.example.approval24.dao.AccountDAO;
import com.example.approval24.dao.AuthorityAccountDAO;
import com.example.approval24.dao.DeptInstDAO;
import com.example.approval24.dao.InstDAO;
import com.example.approval24.dao.UserDAO;
import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.AuthorityAccountDTO;
import com.example.approval24.domain.AuthorityDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.InstDTO;
import com.example.approval24.domain.RequestDTO;
import com.example.approval24.domain.UserDTO;

@Service
public class SignUpService {
	
	@Autowired
	private   InstDAO instDAO;
	
	@Autowired
	private   DeptInstDAO deptInstDAO;
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private AccountDAO accountDAO;
	
	@Autowired
	private AuthorityAccountDAO authAccountDAO;
	
	
	// 계정 등록
	public long approveRequest(Map<String,Object> m) {
		UserDTO user = userDAO.findByResidentNo((String)m.get("residentNo"));
		Long newAccountId = null;
		if(user != null) {
			AccountDTO accountDTO = new AccountDTO();
			accountDTO.setLoginId((String)m.get("loginId"));
			accountDTO.setPassword((String)m.get("password"));
			accountDTO.setUserNo(user.getUserNo());
			String instIdStr = ((String) m.get("instId"));
			Long instId =Long.valueOf(instIdStr);
			accountDTO.setInstId(instId );
			String deptIdStr = ((String) m.get("deptId"));
			Long deptId = Long.valueOf(deptIdStr);
			accountDTO.setDeptId(deptId );
		
			accountDAO.insert(accountDTO);
			
			AccountDTO account = accountDAO.findByLogin((String)m.get("loginId"));
			newAccountId = account.getAccountId();
		}
		
		System.out.println("등록 서비스 끝");
		
		return newAccountId;
	}
	
	//계정 권한 서비스
	public boolean authAccountSetup(AuthorityAccountDTO dto) {
		if(dto == null) {
			return false;
		}
		else {
			authAccountDAO.authAccountSetup(dto);
			return true;
		}
		
	}
	
	// 아이디 중복 검사
	public boolean checkID(String loginId) {
		 if(accountDAO.findByLogin(loginId) == null){ 
			 return false;
		 }
		return  true;
	}
	
	

}
