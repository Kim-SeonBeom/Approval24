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
	

	// 코드 상세
	public TotalCodeDTO TotalCodeInfo(String codeId) {
		return totalCodeDAO.TotalCodeInfo(codeId);
	}
	
	// 코드 수정, 삭제
	public int TotalCodeUpd(TotalCodeDTO codeDTO) {
		return totalCodeDAO.TotalCodeUpd(codeDTO);
	}
	
	// 코드 등록
	public int TotalCodeInsert(TotalCodeDTO codeDTO) {
		
		// 코드 등록시 코드ID 중복체크
		int count = totalCodeDAO.CountByCodeId(codeDTO.getCodeId());
		if(count > 0) {
			return -1;
		}
		return totalCodeDAO.TotalCodeInsert(codeDTO);
	}
	
	public List<TotalCodeDTO> getTotalCodeByGroupId(String groupId){
		return totalCodeDAO.findCodesByGroupId(groupId);
	}
	
	//페이징처리를 위한 카테고리별 totalCode개수(Filter 적용)
	public int countCodes(TotalCodeDTO filter) {
		 return totalCodeDAO.countByFilter(filter);
	}
	
	//카테고리별 totalCode목록(Filter 적용)
    public List<TotalCodeDTO> searchCodes(TotalCodeDTO filter) {
        return totalCodeDAO.findByFilter(filter); 
    }
    
    public boolean existsByCodeId(String codeId) {
        return totalCodeDAO.countByCodeId(codeId) > 0;
    }

}
