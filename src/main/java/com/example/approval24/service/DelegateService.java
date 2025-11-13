package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.DelegateDAO;
import com.example.approval24.domain.DelegateDTO;

@Service
public class DelegateService {
	
	@Autowired
	private DelegateDAO delegateDAO;

	public List<DelegateDTO> getMyDelegateList(long accountId) {
		
		return delegateDAO.findByAbsId(accountId);
	}

	public int insertDelegate(long accountId, DelegateDTO delegateDTO) {
		delegateDTO.setAbsId(accountId);
		System.out.println(delegateDTO.toString());
		
		return delegateDAO.insertDelegate(delegateDTO);
		
	}
	
	public DelegateDTO delegateDetail(long seqNo) {
		return delegateDAO.findBySeqNo(seqNo);
	}

	public int updateDelegate(long accountId, DelegateDTO delegateDTO) {
		delegateDTO.setAbsId(accountId);
		System.out.println(delegateDTO.toString());
		
		return delegateDAO.updateDelegate(delegateDTO);
	}

	public int deleteDelegate(long seqNo) {
		
		return delegateDAO.deleteDelegate(seqNo);
	}
	
	
	//페이징처리를 위한 카테고리별 대결자(Filter 적용)
	public int countDelegate(DelegateDTO filter) {
		 return delegateDAO.countByFilter(filter);
	}
	
	//카테고리별 기관목록(Filter 적용)
    public List<DelegateDTO> searchDelegate(DelegateDTO filter) {
        return delegateDAO.findByFilter(filter); 
    }

}
