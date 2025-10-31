package com.example.approval24.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class InstDTO {
	
	private int instId;
	
	private String instName;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createDt;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updateDt;
	
	private String instAddress;
	
	private String instDetailAddress; 
	
	private String instPhone;
	
	private String instPost;
	
	private String instHeadName;

}
