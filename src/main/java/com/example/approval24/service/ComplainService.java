package com.example.approval24.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.CategoryDAO;
import com.example.approval24.dao.ComplainDAO;
import com.example.approval24.dao.ComplainUserDAO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.domain.ComplainRegDTO;

@Service
public class ComplainService {

	@Autowired
	private ComplainDAO complainDAO;

	@Autowired
	private ComplainUserDAO complainUserDAO;

	@Autowired
	private CategoryDAO categoryDAO;

	public List<ComplainDTO> getMyWorkList(int accountId) {

		return complainDAO.getMyWorks(accountId);
	}

	public void complainRegister(ComplainRegDTO complainRegDTO, int accountId) {
	
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

		//민원인No
		int complainuserNo = complainUserDAO.findByResidentNo(fullRegidentNo);

		// Receiver_account_Id
		// 접수자 계정 id
		int receiverAccountId = accountId;

		// 담당자 지정 로직 들어와야 함 임시로 강제지정
		// Manager_account_id
		int managerAccountId = 13;

		// 서식별 처리기한 로직
		int dueDt = categoryDAO.findDueDtById(complainRegDTO.getComplainCategoryId());
		LocalDateTime deadlineDt = LocalDateTime.now().plusDays((long) dueDt);

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

}
