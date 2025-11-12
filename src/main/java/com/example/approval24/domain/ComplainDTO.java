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

	private long complainId;

	private long complainCategoryId;

	private String categoryName;

	private String categoryUrl;

	private long complainuserNo;

	private String complainuserName;

	private long accountId; // 담당자계정id

	private String userName; // 담당직원이름

	private String complainStatusCd;

	private String rcptDt;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date procDt;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date approvalProcDt;

	private String deadlineDt;

	private String complainComment;

	private char delYN;

	private long receiverAccountId; // 접수자 id

	//추가사항
	private long instId;
	
}
