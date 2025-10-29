package com.example.approval24.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ComplainRegDTO {

	private int complainCategoryId;
	
	private int complainuserNo;

	private String complainuserResiNoFront; // 주민번호 앞자리(6)
	private String complainuserResiNoBack; // 주민번호 뒷자리(7)

	private String complainuserName;
	private String complainuserPost;
	private String complainuserAddress;
	private String complainuserAddrDetail;
	private String complainuserTel;
	private String complainuserPhone;
	private String complainuserEmail;
	
	private LocalDateTime updateDt;

	private String complainuserResidentNo;

	public String getComplainuserResidentNo() {
		if (complainuserResidentNo == null) {
			return complainuserResiNoFront + complainuserResiNoBack;
		} else
			return this.complainuserResidentNo;
	}

	public void setComplainuserResidentNo(String complainuserResidentNo) {
		this.complainuserResidentNo = complainuserResidentNo;
		
		if (complainuserResidentNo != null && complainuserResidentNo.length() >= 13) {
			this.complainuserResiNoFront = complainuserResidentNo.substring(0, 6);
			this.complainuserResiNoBack = complainuserResidentNo.substring(6, 13);
		}
	}

}