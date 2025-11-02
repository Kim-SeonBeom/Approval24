package com.example.approval24.service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.CategoryDAO;
import com.example.approval24.dao.ComplainDAO;
import com.example.approval24.dao.ComplainuserDAO;
import com.example.approval24.dao.EM3DAO;
import com.example.approval24.dao.MT1DAO;
import com.example.approval24.dao.MT2DAO;
import com.example.approval24.dao.UE1DAO;
import com.example.approval24.dao.UE2DAO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.domain.ComplainRegDTO;
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
	private UE1DAO ue1DAO;
	
	@Autowired
	private UE2DAO ue2DAO;
	
	@Autowired
	private MT1DAO mt1DAO;
	
	@Autowired
	private MT2DAO mt2DAO;
	
	
	
	
	@Autowired
	private EM3DAO em3DAO;


	public List<ComplainDTO> getMyWorkList(long accountId) {

		return complainDAO.getMyWorks(accountId);
	}

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

		// 담당자 지정 로직 들어와야 함 임시로 강제지정
		// Manager_account_id
		long managerAccountId = 41;

		// 서식별 처리기한 로직
		int dueDt = categoryDAO.findDueDtById(complainRegDTO.getComplainCategoryId());
		LocalDateTime localDateTime = LocalDateTime.now().plusDays(dueDt);
		Date deadlineDt = java.util.Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());

		ComplainDTO complainDTO = new ComplainDTO();
		complainDTO.setComplainCategoryId(complainRegDTO.getComplainCategoryId());
		complainDTO.setComplainuserNo(complainuserNo);
		complainDTO.setAccountId(managerAccountId);

		// 민원 상태 코드 변경할지 말지 체크(현재는 하드코딩함)
		//
		//
		// 한번 확인할것!!!!
		complainDTO.setComplainStatusCd("접수");
		//
		//
		complainDTO.setDeadlineDt(deadlineDt);
		complainDTO.setReceiverAccountId(receiverAccountId);

		int result = complainDAO.registComplain(complainDTO);
		if (result == 1) {
			System.out.println("민원 등록 성공");
		} else {
			System.out.println("민원 등록 실패");
		}

	}

	public List<ComplainDTO> complainList(long accountId) {
//		System.out.println("service input");

		List<ComplainDTO> complainList = complainDAO.findByDeptOfAccountId(accountId);
//		System.out.println("***" + complainList);
//		System.out.println("service out");

		return complainList;
	}

	public ComplainDTO getComplainInfo(long complainId) {

		ComplainDTO dto = complainDAO.findById(complainId);

		return dto;
	}
	
	//ue1 메서드
	public UE1DTO getUE1Info(long complainId) {
		System.out.println("getUE1Info 진입");

		int count = ue1DAO.existByComplainId(complainId);
		if (count > 0) {
			System.out.println("등록된 민원존재");

			return ue1DAO.findByComplainId(complainId);
			
		} else {
			System.out.println("등록된 민원 없음");
			UE1DTO ue1dto = new UE1DTO();
			ue1dto.setComplainId(complainId);
			ue1DAO.insertInfo(ue1dto);
			System.out.println("민원 생성");
			System.out.println(ue1dto.toString());
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
			System.out.println("등록된 민원존재");

			return ue2DAO.findByComplainId(complainId);
			
		} else {
			System.out.println("등록된 민원 없음");
			UE2DTO ue2dto = new UE2DTO();
			ue2dto.setComplainId(complainId);
			ue2DAO.insertInfo(ue2dto);
			System.out.println("민원 생성");
			System.out.println(ue2dto.toString());
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
			System.out.println("등록된 민원존재");

			return mt1DAO.findByComplainId(complainId);
			
		} else {
			System.out.println("등록된 민원 없음");
			MT1DTO mt1dto = new MT1DTO();
			mt1dto.setComplainId(complainId);
			mt1DAO.insertInfo(mt1dto);
			System.out.println("민원 생성");
			System.out.println(mt1dto.toString());
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
			System.out.println("등록된 민원존재");

			return mt2DAO.findByComplainId(complainId);
			
		} else {
			System.out.println("등록된 민원 없음");
			MT2DTO mt2dto = new MT2DTO();
			mt2dto.setComplainId(complainId);
			mt2DAO.insertInfo(mt2dto);
			System.out.println("민원 생성");
			System.out.println(mt2dto.toString());
			return mt2dto;  
		}
	}

	public void savemt2(MT2DTO mt2DTO) {
		mt2DAO.updateInfo(mt2DTO);

	}
	
	
	
	
	
	
	//em3 메서드
	public EM3DTO getEM3Info(long complainId) {

		int count = em3DAO.existByComplainId(complainId);
		if (count > 0) {
			System.out.println("등록된 민원존재");

			return em3DAO.findByComplainId(complainId);
			
		} else {
			System.out.println("등록된 민원 없음");
			EM3DTO em3dto = new EM3DTO();
			em3dto.setComplainId(complainId);
			em3DAO.insertInfo(em3dto);
			System.out.println("민원 생성");
			System.out.println(em3dto.toString());
			return em3dto;  
		}
	}

	public void saveem3(EM3DTO em3dto) {
		em3DAO.updateInfo(em3dto);

	}

}
