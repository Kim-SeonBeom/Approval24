package com.example.approval24.domain;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ComplainDTO {
	
	private int complainId;
	
	private int	complainCategoryId;
	
	private String categoryName;
	
	private String complainuserName;
	
	private int complainuserNo;
	
	private int accountId;
	
	private String complainStatusCd;
	
	private LocalDateTime rcptDt;
	
	private LocalDateTime procDt;
	
	private LocalDateTime approvalProcDt;
	
	private LocalDateTime deadlineDt;
	
	private String complainComment;
	
	private char delYN;
	
	private int receiverAccountId;
}
