package com.example.approval24.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EM3DTO {
	private long complainId;
	
	private String universityName;
	
	private String participantType;
	
	private String studentNo;
	
	private String grade;
	
	private String major;
	
	private String studentStatus;
	
    @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date graduateDate;

}
