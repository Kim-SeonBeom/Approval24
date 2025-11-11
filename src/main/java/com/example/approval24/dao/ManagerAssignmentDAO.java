package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.ManagerAssignmentDTO;

@Mapper
public interface ManagerAssignmentDAO {
	// 담당자배정 목록 (id에 따른 name 가져오기)
	public List<ManagerAssignmentDTO> getAllManagerAssignment();
	
	// 담당자배정 상세
	public ManagerAssignmentDTO ManagerAssignmentInfo(ManagerAssignmentDTO managerDTO);
	
	// 담당자배정 수정/삭제 (select 값이 null이 아닐 때)
	public int ManagerAssignmentUpd(ManagerAssignmentDTO managerDTO);
	
	// 담당자배정 등록
	public int ManagerAssignmentInsert(ManagerAssignmentDTO managerDTO);
	
	// 담당자배정 로직
	public long ManagerAccountId(long complainCategoryId);
	
	// 검색에 해당되는 목록 개수
	public int countByFilter(ManagerAssignmentDTO filter);
	
	// 검색 조건
	public List<ManagerAssignmentDTO> findByFilter(ManagerAssignmentDTO filter);
}
