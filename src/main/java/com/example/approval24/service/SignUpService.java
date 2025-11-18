package com.example.approval24.service;


import java.util.HashMap;
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
import com.example.approval24.util.AesEncryptionService;
import com.example.approval24.util.BCryptUtil;

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
	
    @Autowired 
    public AesEncryptionService encryptionService;
	
	
	// 계정 등록
	public long approveRequest(Map<String,Object> m) {
		Object obj = m.get("residentNo");
		String residentNo = String.valueOf(obj);
		String  encryptedResidentNo = null;
	  	try {
            // 입력받은 평문 주민번호를 암호화
	  		encryptedResidentNo = encryptionService.encrypt(residentNo);
        } catch (Exception e) {
            e.printStackTrace(); 
            throw new RuntimeException("사용자 주민번호 암호화 중 치명적인 오류 발생", e);
        }
		UserDTO user = userDAO.findByResidentNo(encryptedResidentNo);
		if (user == null) {
		    throw new RuntimeException("해당 유저를 사용자를 찾을 수 없습니다: ");
		}
		Long newAccountId = null;
		if(user != null) {
			AccountDTO accountDTO = new AccountDTO();
			accountDTO.setLoginId((String)m.get("loginId"));
			
			String password = BCryptUtil.hash((String)m.get("password"));
			accountDTO.setPassword(password);
			
			accountDTO.setUserNo(user.getUserNo());
			
			String instIdStr = ((String) m.get("instId"));
			Long instId =Long.valueOf(instIdStr);
			accountDTO.setInstId(instId );
			
			String deptIdStr = ((String) m.get("deptId"));
			Long deptId = Long.valueOf(deptIdStr);
			accountDTO.setDeptId(deptId );
		
			accountDAO.insert(accountDTO);
			AccountDTO account = accountDAO.checkByLogin((String)m.get("loginId"));
			newAccountId = account.getAccountId();
		}
		
		
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
