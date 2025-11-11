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
	
	private String dateType;
	
	private int page = 1;          
    private int size = 10;         

    public int getOffset() {
        return (page - 1) * size;
    }

    public boolean isEmptyFilter() {
        return (isBlank(dateType) && isBlank(createDt) && isBlank(updateDt)
                && isBlank(delYn) && isBlank(instName) && isBlank(deptName)
                && isBlank(categoryName) && isBlank(loginId) && isBlank(userName));
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
