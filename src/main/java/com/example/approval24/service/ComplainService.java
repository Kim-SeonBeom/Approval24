package com.example.approval24.service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.CategoryDAO;
import com.example.approval24.dao.ComplainDAO;
import com.example.approval24.dao.ComplainuserDAO;
import com.example.approval24.dao.EM1DAO;
import com.example.approval24.dao.EM2DAO;
import com.example.approval24.dao.EM3DAO;
import com.example.approval24.dao.MT1DAO;
import com.example.approval24.dao.MT2DAO;
import com.example.approval24.dao.ManagerAssignmentDAO;
import com.example.approval24.dao.UE1DAO;
import com.example.approval24.dao.UE2DAO;
import com.example.approval24.domain.AlarmDTO;
import com.example.approval24.domain.CategoryDTO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.domain.ComplainFilterDTO;
import com.example.approval24.domain.ComplainRegDTO;
import com.example.approval24.domain.EM1DTO;
import com.example.approval24.domain.EM2DTO;
import com.example.approval24.domain.EM3DTO;
import com.example.approval24.domain.MT1DTO;
import com.example.approval24.domain.MT2DTO;
import com.example.approval24.domain.UE1DTO;
import com.example.approval24.domain.UE2DTO;

@Service
public class ComplainService {

	@Autowired
	private ComplainDAO complainDAO;

	@Autowired
	private ComplainuserDAO complainUserDAO;

	@Autowired
	private CategoryDAO categoryDAO;
	
	@Autowired
	private ManagerAssignmentDAO managerDAO;
	
	@Autowired
	private AlarmService alarmService;

	@Autowired
	private UE1DAO ue1DAO;
	
	@Autowired
	private UE2DAO ue2DAO;
	
	@Autowired
	private MT1DAO mt1DAO;
	
	@Autowired
	private MT2DAO mt2DAO;
	
	@Autowired
	private EM1DAO em1DAO;
	
	@Autowired
	private EM2DAO em2DAO;
	
	@Autowired
	private EM3DAO em3DAO;


	public List<ComplainDTO> getMyWorkList(long accountId) {

		return complainDAO.getMyWorks(accountId);
	}

	@Transactional
	public void complainRegister(ComplainRegDTO complainRegDTO, long accountId) {

		String fullRegidentNo = complainRegDTO.getComplainuserResidentNo();
		complainRegDTO.setComplainuserResidentNo(fullRegidentNo);

		// 이미 등록된 민원인인지 확인
		int count = complainUserDAO.countByResidentNo(fullRegidentNo);

		if (count > 0) {
			// 이미 등록된 민원인이면 민원인 정보 update
			complainUserDAO.updateUserInfo(complainRegDTO);
		} else {
			// 신규 등록되는 민원인이면 insert
			complainUserDAO.registUserInfo(complainRegDTO);
		}

		// 민원인No
		long complainuserNo = complainUserDAO.findByResidentNo(fullRegidentNo);

		// Receiver_account_Id
		// 접수자 계정 id
		long receiverAccountId = accountId;

		ComplainDTO complainDTO = new ComplainDTO();
		
		long complainCategoryId = complainRegDTO.getComplainCategoryId();

		Long managerAccountId = managerDAO.ManagerAccountId(complainCategoryId);

		// 서식별 처리기한 로직
		int dueDt = categoryDAO.findDueDtById(complainRegDTO.getComplainCategoryId());
		String deadlineDt = LocalDate.now(ZoneId.systemDefault())
		        .plusDays(dueDt)
		        .format(DateTimeFormatter.ISO_DATE);
		
		complainDTO.setComplainCategoryId(complainRegDTO.getComplainCategoryId());
		complainDTO.setComplainuserNo(complainuserNo);
		complainDTO.setAccountId(managerAccountId);
		complainDTO.setComplainStatusCd("D001");
		complainDTO.setDeadlineDt(deadlineDt);
		complainDTO.setReceiverAccountId(receiverAccountId);

		complainDAO.registComplain(complainDTO);
		
		Long complainId = complainDTO.getComplainId();
		 
		// 담당자에게 알림 로직
		AlarmDTO alarmDTO = new AlarmDTO();
		alarmDTO.setSenderId(accountId);
		alarmDTO.setReceiverId(managerAccountId);
		String categoryName = categoryDAO.CategoryInfo(complainRegDTO.getComplainCategoryId()).getCategoryName();
		String categoryUrl = categoryDAO.CategoryInfo(complainRegDTO.getComplainCategoryId()).getCategoryUrl();
		String message = categoryName + "(민원 번호: " + complainId + ") 민원 접수";
		String url ="/approval24/complain/category/" + categoryUrl + "/" + complainId;
		alarmDTO.setMessage(message);
		alarmDTO.setUrl(url);
		alarmService.sendAlarm(alarmDTO);
	}
	// 페이징처리를 위한 "민원 접수 목록"  개수(Filter 적용)
	public int countComplainsByDept(ComplainFilterDTO filter,long accountId) {
		 return complainDAO.countByDeptOfAccountIdAndFilter(filter, accountId);
	}
	

	//민원 접수 목록 
	public List<ComplainDTO> complainListByDept(ComplainFilterDTO filter, long accountId) {

		return complainDAO.findByDeptOfAccountIdAndFilter(filter, accountId);
	}

	public ComplainDTO getComplainInfo(long complainId) {

		return complainDAO.findById(complainId);
	}
	
	//ue1 메서드
	public UE1DTO getUE1Info(long complainId) {

		int count = ue1DAO.existByComplainId(complainId);
		if (count > 0) {

			return ue1DAO.findByComplainId(complainId);
			
		} else {
			UE1DTO ue1dto = new UE1DTO();
			ue1dto.setComplainId(complainId);
			ue1DAO.insertInfo(ue1dto);
			return ue1dto;
		}
	}

	public void saveue1(UE1DTO ue1DTO) {
		ue1DAO.updateInfo(ue1DTO);

	}
	
	
	//ue2메서드
	
	public UE2DTO getUE2Info(long complainId) {

		int count = ue2DAO.existByComplainId(complainId);
		if (count > 0) {

			return ue2DAO.findByComplainId(complainId);
			
		} else {
			UE2DTO ue2dto = new UE2DTO();
			ue2dto.setComplainId(complainId);
			ue2DAO.insertInfo(ue2dto);
			return ue2dto; 
		}
	}

	public void saveue2(UE2DTO ue2DTO) {
		ue2DAO.updateInfo(ue2DTO);

	}
	
	//mt1 메서드
	public MT1DTO getMT1Info(long complainId) {

		int count = mt1DAO.existByComplainId(complainId);
		if (count > 0) {

			return mt1DAO.findByComplainId(complainId);
			
		} else {
			MT1DTO mt1dto = new MT1DTO();
			mt1dto.setComplainId(complainId);
			mt1DAO.insertInfo(mt1dto);
			return mt1dto; 
		}
	}

	public void savemt1(MT1DTO mt1DTO) {
		mt1DAO.updateInfo(mt1DTO);

	}
	
	//mt2 메서드
	public MT2DTO getMT2Info(long complainId) {

		int count = mt2DAO.existByComplainId(complainId);
		if (count > 0) {

			return mt2DAO.findByComplainId(complainId);
			
		} else {
			MT2DTO mt2dto = new MT2DTO();
			mt2dto.setComplainId(complainId);
			mt2DAO.insertInfo(mt2dto);
			return mt2dto;  
		}
	}

	public void savemt2(MT2DTO mt2DTO) {
		mt2DAO.updateInfo(mt2DTO);

	}
	
	
	//em1 메서드
		public EM1DTO getEM1Info(long complainId) {

			int count = em1DAO.existByComplainId(complainId);
			if (count > 0) {

				return em1DAO.findByComplainId(complainId);
				
			} else {
				EM1DTO em1dto = new EM1DTO();
				em1dto.setComplainId(complainId);
				em1DAO.insertInfo(em1dto);
				return em1dto; 
			}
		}

		public void saveem1(EM1DTO em1dto) {
			complainDAO.updateStatusByComplainId(em1dto.getComplainId(),"D002");
			em1DAO.updateInfo(em1dto);
		}
	
	

	
	//em2 메서드
	public EM2DTO getEM2Info(long complainId) {

		int count = em2DAO.existByComplainId(complainId);
		if (count > 0) {

			return em2DAO.findByComplainId(complainId);
			
		} else {
			EM2DTO em2dto = new EM2DTO();
			em2dto.setComplainId(complainId);
			em2DAO.insertInfo(em2dto);
			return em2dto; 
		}
	}

	public void saveem2(EM2DTO em2dto) {
		em2DAO.updateInfo(em2dto);

	}
	
	
	
	
	
	
	//em3 메서드
	public EM3DTO getEM3Info(long complainId) {

		int count = em3DAO.existByComplainId(complainId);
		if (count > 0) {

			return em3DAO.findByComplainId(complainId);
			
		} else {
			EM3DTO em3dto = new EM3DTO();
			em3dto.setComplainId(complainId);
			em3DAO.insertInfo(em3dto);
			return em3dto;  
		}
	}

	public void saveem3(EM3DTO em3dto) {
		em3DAO.updateInfo(em3dto);

	}

	public List<ComplainDTO> complainsByCategory(String categoryUrl) {
		CategoryDTO categoryDTO = categoryDAO.findByCategoryUrl(categoryUrl);

		List<ComplainDTO> complainList = complainDAO.findByCategoryId(categoryDTO.getComplainCategoryId());

		return complainList;

	}
	
	//페이징처리를 위한 카테고리별 complain개수(Filter 적용)
	public int countComplains(ComplainFilterDTO filter) {
		 return complainDAO.countByFilter(filter);
	}
	
	//카테고리별 complain목록(Filter 적용)
    public List<ComplainDTO> searchComplains(ComplainFilterDTO filter) {
        return complainDAO.findByFilter(filter); 
    }

	public void setComplainStatus(Long complainId, String codeId) {
		complainDAO.updateStatusByComplainId(complainId, codeId);
	}

	public ComplainDTO getComplainById(long complainId)
	{
		return complainDAO.findById(complainId);
	}
}
