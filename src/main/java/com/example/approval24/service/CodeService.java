package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.CodeDAO;
import com.example.approval24.domain.CodeDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CodeService {
	@Autowired
	CodeDAO codeDAO;
	
	// 코드 목록
	public List<CodeDTO> getAllCode() {
		return codeDAO.getAllCode();
	}
	

}
