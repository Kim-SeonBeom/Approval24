package com.example.approval24.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InstDTO {
	
	private int instId;
	
	private String instName;
	
	private String createDt;
	
	private String updateDt;
	
	private String instAddress;
	
	private String instDetailAddress;
	
	private String instPhone;
	
	private String instPost;
	
	private String instHeadName;
	
	private String delYn;

}
