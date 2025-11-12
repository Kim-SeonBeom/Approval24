package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.InstDAO;
import com.example.approval24.domain.InstDTO;

@Service
public class InstService {
	
	@Autowired
	InstDAO instDAO;
	
	//페이징처리를 위한 카테고리별 inst개수(Filter 적용)
	public int countInsts(InstDTO filter) {
		 return instDAO.countByFilter(filter);
	}
	
	//카테고리별 기관목록(Filter 적용)
    public List<InstDTO> searchInsts(InstDTO filter) {
        return instDAO.findByFilter(filter); 
    }
    
    // 기관 상세
    public InstDTO getInstById(long instId) {
    	return instDAO.getInstById(instId);
    }
}
