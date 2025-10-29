package com.example.approval24.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ComplainDTO {
	
	private int complainId;
	
	
	private int	complainCategoryId;
	
	private String categoryName;
	
	
	private int complainuserNo;
	
	private String complainuserName;
	
	
	
	private int accountId;
	
	private String userName;
	
	
	private String complainStatusCd;
	
	private Date rcptDt;
	
	private Date procDt;
	
	private Date approvalProcDt;
	
	private Date deadlineDt;
	
	private String complainComment;
	
	private char delYN;
	
	private int receiverAccountId;
}
