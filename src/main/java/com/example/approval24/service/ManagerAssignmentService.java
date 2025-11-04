package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.AccountDAO;
import com.example.approval24.dao.CategoryDAO;
import com.example.approval24.dao.DeptDAO;
import com.example.approval24.dao.DeptInstDAO;
import com.example.approval24.dao.InstDAO;
import com.example.approval24.dao.ManagerAssignmentDAO;
import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.InstDTO;
import com.example.approval24.domain.ManagerAssignmentDTO;

@Service
public class ManagerAssignmentService {
	@Autowired
	ManagerAssignmentDAO MAdao;
	
	@Autowired
	InstDAO instdao;
	
	@Autowired
	DeptInstDAO deptinstdao;
	
	@Autowired
	DeptDAO deptdao;
	
	@Autowired
	CategoryDAO categorydao;
	
	@Autowired
	AccountDAO accountdao;
	
	// 담당자배정 목록 (id에 따른 name 가져오기)
	public List<ManagerAssignmentDTO> getAllManagerAssignment() {
		return MAdao.getAllManagerAssignment();
	}
	
	// 담당자배정 상세 (기관, 부서, 민원서식, 계정 id 받기)
	public ManagerAssignmentDTO ManagerAssignmentInfo(ManagerAssignmentDTO managerDTO) {
		return MAdao.ManagerAssignmentInfo(managerDTO);
	}
	
    // 담당자배정 수정/삭제
    public int ManagerAssignmentUpd(ManagerAssignmentDTO managerDTO) {
    	return MAdao.ManagerAssignmentUpd(managerDTO);
    }
    
    // 담당자배정 등록
    public int ManagerAssignmentInsert(ManagerAssignmentDTO managerDTO) {
    	ManagerAssignmentDTO dto = MAdao.ManagerAssignmentInfo(managerDTO);
    	if (dto == null) {
    		return MAdao.ManagerAssignmentInsert(managerDTO);
    	} else {
    		return MAdao.ManagerAssignmentUpd(managerDTO);
    	}
    }
    
    // 전체 기관 리스트
    public List<InstDTO> getAllInst() {
    	return instdao.getAllInst();
    }
    
    // 특정 기관의 매핑 부서
    public List<DeptInstDTO> findDeptByInst(Long instId) {
    	return deptinstdao.findDeptByInst(instId);
    }
    
    // 특정 부서의 매핑 민원서식
    public List<CategoryDTO> findCategoryByDept(Long deptId) {
    	return categorydao.findCategoryByDept(deptId);
    }
    
    // 특정 부서에 따른 매핑 계정
    public List<AccountDTO> findAccountByDept(Long deptId) {
    	return accountdao.findAccountByDept(deptId);
    }
}
