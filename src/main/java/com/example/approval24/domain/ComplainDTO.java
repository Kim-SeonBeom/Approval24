package com.example.approval24.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
	
	private String categoryUrl;
	
	
	private int complainuserNo;
	
	private String complainuserName;
	
	
	
	private int accountId; //담당자계정id 
	
	private String userName; //담당직원이름
	
	
	private String complainStatusCd;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date rcptDt;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date procDt;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date approvalProcDt;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date deadlineDt;
	
	private String complainComment;
	
	private char delYN;
	
	private int receiverAccountId; //접수자 id
	
	
}
