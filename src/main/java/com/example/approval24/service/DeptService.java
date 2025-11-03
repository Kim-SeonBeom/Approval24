package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.DeptDAO;
import com.example.approval24.dao.DeptInstDAO;
import com.example.approval24.dao.InstDAO;
import com.example.approval24.domain.DeptDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.InstDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DeptService {
	
	@Autowired
	InstDAO instdao;
	
	@Autowired
	DeptInstDAO deptinstdao;
	
	@Autowired
	DeptDAO deptdao;
	
	// 전체 부서
	public List<DeptDTO> getAllDept() {
		return deptdao.getAllDept();
	}
	
	// 부서 상세 조회
	public DeptDTO deptInfo(int deptId) {
		return deptdao.deptInfo(deptId);
	}
	// 특정 부서의 매핑 기관명
	public List<DeptInstDTO> instByDept(int deptId) {
		return deptinstdao.instByDept(deptId);
	}
	public List<InstDTO> getAllInst() {
		return instdao.getAllInst();
	}
	
	// 부서수정
	@Transactional
	public int updateDept(int deptId, String deptName, String deptPhone, List<Integer> instIds) {
		DeptDTO dto = new DeptDTO();
		dto.setDeptId(deptId);
		dto.setDeptName(deptName);
		dto.setDeptPhone(deptPhone);
		int a = deptdao.updateDept(dto);
		
		int d = deptinstdao.deleteDI(deptId);
		int i = (instIds == null || instIds.isEmpty()) ? 0 : deptinstdao.insertDI(deptId, instIds);
		
		return a + d + i;
	}
	
	// 부서 삭제
	public int deleteDept(int deptId) {
		return deptdao.deleteDept(deptId);
	}
	
	// 부서 등록 + 부서 등록에서 소속 기관 다중 매핑
	public int insertDept(String deptName, String deptPhone, List<Integer> instIds) {
		DeptDTO dto = new DeptDTO();
		dto.setDeptName(deptName);
		dto.setDeptPhone(deptPhone);
		int d = deptdao.insertDept(dto);
		int deptId = dto.getDeptId();
		int i = (instIds == null || instIds.isEmpty()) ? 0 : deptinstdao.insertDI(deptId, instIds);
		
		return d + i;
	}

}
