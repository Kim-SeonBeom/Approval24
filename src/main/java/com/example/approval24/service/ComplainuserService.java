package com.example.approval24.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.ComplainuserDAO;
import com.example.approval24.domain.ComplainuserDTO;

@Service
public class ComplainuserService {

	@Autowired
	ComplainuserDAO complainuserDAO;

	public ComplainuserDTO complainuserInfo(int complainuserNo) {

		return complainuserDAO.findByComplainuserNo(complainuserNo); 
	}
	
	public int saveComplainuser(ComplainuserDTO dto) {
		
		return complainuserDAO.updateComplainuserInfo(dto);
		
	}

}
