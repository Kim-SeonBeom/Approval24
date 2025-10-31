package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.TotalCodeDAO;
import com.example.approval24.domain.TotalCodeDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TotalCodeService {
	@Autowired
	TotalCodeDAO totalCodeDAO;
	
	// 코드 목록
	public List<TotalCodeDTO> getAllTotalCode() {
		return totalCodeDAO.getAllTotalCode();
	}
	

}
