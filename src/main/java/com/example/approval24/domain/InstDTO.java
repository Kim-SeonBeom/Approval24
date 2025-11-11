package com.example.approval24.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InstDTO {
	
	private long instId;
	
	private String instName;

	private String createDt;
	
	private String updateDt;
	
	private String instAddress;
	
	private String instDetailAddress; 
	
	private String instPhone;
	
	private String instPost;
	
	private String instHeadName;
	
	private String delYn;
	
	private String dateType;
	
	private int page = 1;          
    private int size = 10;         

    public int getOffset() {
        return (page - 1) * size;
    }

    public boolean isEmptyFilter() {
        return (isBlank(dateType) && isBlank(createDt) && isBlank(updateDt)
                && isBlank(delYn) && isBlank(instName) && isBlank(instHeadName)
                && isBlank(instAddress));
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

}
