package com.example.approval24.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.example.approval24.dao.DeptInstDAO;
import com.example.approval24.dao.InstDAO;
import com.example.approval24.dao.RequestDAO;
import com.example.approval24.domain.AuthorityDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.InstDTO;
import com.example.approval24.domain.RequestDTO;

@Service
public class RequestService {
	
	@Autowired
	private   RequestDAO requestDAO;
	
	@Autowired
	private   InstDAO instDAO;
	
	@Autowired
	private   DeptInstDAO deptInstDAO;
	
	
	// 계정 등록
	public void approveRequest(RequestDTO requestDTO) {
		
		// 주민번호가 공란일때
		String residentNo = requestDTO.getUserResidentNo();
		if(residentNo == null || residentNo.isEmpty()) {
			throw new IllegalArgumentException("주민번호가 입력되지 않았습니다.");
		}
		// userNo가 없을수 있기에 null일 수 있는 Long 타입으로 변환
		Long userNo = requestDAO.checkUserNo(requestDTO.getUserResidentNo());
		if(userNo  == null) {
			throw new IllegalArgumentException("주민번호와 일치하는 직원이 없습니다.");
		}
		requestDTO.setUserNo(userNo);
		System.out.println("등록 서비스 시작");
		// 계정 등록 먼저
		requestDAO.approveRequest(requestDTO);
		// 권한 부여
		List<AuthorityDTO> authList = requestDTO.getAuthorityList();
		for(AuthorityDTO AuthorityList : authList) {
			requestDAO.approveAuth(requestDTO);
		}

	
		System.out.println("등록 서비스 끝");
	}
	
	// 아이디 중복 검사
	public boolean checkID(String loginId) {
		int count = requestDAO.checkID(loginId);
		return  count > 0;
	}
	
	// 기관 목록 불러오기
	public List<InstDTO> instList(){
		return instDAO.getAllInst();
	}
	
	// 부서목록 불러오기
	public List<DeptInstDTO> getdeptList(long instId){
		return deptInstDAO.findDeptByInst(instId);
	}
	
	//권한 불러오기
    public List<RequestDTO> getAllAuthorities() {
        return requestDAO.findAuth();
    }

}
