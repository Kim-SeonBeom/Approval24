package com.example.approval24.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EM2DTO {

	private long complainId;
	private String bankNm;
	private String accountNo;
	private String collegerYn;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date graduateDate;

}
