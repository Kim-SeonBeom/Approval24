package com.example.approval24.domain;

import lombok.Data;

@Data
public class DeptInstDTO {
	private long deptId;
	
	private String deptName;
	
	private String deptPhone;
	
	private String createDt;
	
	private String updateDt;
	
	private String delYn;
	
	private long createId;
	
	private long updateId;
	
	private long instId;
	
	private String instName;
}
