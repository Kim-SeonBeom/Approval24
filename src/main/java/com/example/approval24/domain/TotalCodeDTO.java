package com.example.approval24.domain;

import lombok.Data;

@Data
public class TotalCodeDTO {

    private String groupId;
    private String codeId;
    
    private String codeName;
    private String codeDetail;
    private String delYn;
	
	private int page = 1;          
    private int size = 10;         

    public int getOffset() {
        return (page - 1) * size;
    }

    public boolean isEmptyFilter() {
        return (isBlank(delYn) && isBlank(groupId)
        		&& isBlank(codeId) && isBlank(codeName) && isBlank(codeDetail));
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
