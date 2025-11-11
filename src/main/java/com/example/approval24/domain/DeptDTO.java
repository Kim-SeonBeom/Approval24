package com.example.approval24.domain;

import lombok.Data;

@Data
public class DeptDTO {
	private long deptId;
	
	private String deptName;
	
	private String deptPhone;
	
	private String createDt;
	
	private String updateDt;
	
	private String delYn;
	
	private long createId;
	
	private long updateId;
	
	private String dateType;
	
	private int page = 1;          
    private int size = 10;         

    public int getOffset() {
        return (page - 1) * size;
    }

    public boolean isEmptyFilter() {
        return (isBlank(dateType) && isBlank(createDt) && isBlank(updateDt)
                && isBlank(delYn) && isBlank(deptName));
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
