package com.example.approval24.domain;

import lombok.Data;

@Data
public class DeptDTO {
	private int deptId;
	
	private String deptName;
	
	private String deptPhone;
	
	private String createDt;
	
	private String updateDt;
	
	private String delYn;
	
	private int createId;
	
	private int updateId;
}
