package com.example.approval24.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EM1DTO {

	private long complainId;
	private String bizOwnerNm;
	private String industryType;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date employmentDt;
	private String bizPost;
	private String bizAddr;
	private String bizAddrDetail;
	private String trainCourseNm;
	private String trainInstituteNm;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date trainStartDt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date trainEndDt;
	private String accountHolderNm;
	private String bankNm;
	private String accountNo;


}
