package com.example.approval24.domain;

import java.util.List;

import lombok.Data;

@Data
public class DeptInstDTO {
	private Integer deptId;
	
	private String deptName;
	
	private String deptPhone;
	
	private String createDt;
	
	private String updateDt;
	
	private String delYn;
	
	private int createId;
	
	private int updateId;
	
	private int instId;
	
	private String instName;
	
	private List<Integer> instIds;
}
