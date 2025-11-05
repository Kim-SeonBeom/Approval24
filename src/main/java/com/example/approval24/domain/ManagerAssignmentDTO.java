package com.example.approval24.domain;

import lombok.Data;

@Data
public class ManagerAssignmentDTO {
	
	private long accountId;
	private String loginId;
	private String userName;
	
	private long deptId;
	private String deptName;
	
	private long complainCategoryId;
	private String categoryName;
	
	private long instId;
	private String instName;
	
	private String createDt;
	private String updateDt;
	
	private long createId;
	private long updateId;
	
	private String delYn;
}
