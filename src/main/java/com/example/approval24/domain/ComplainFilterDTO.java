package com.example.approval24.domain;

import lombok.Data;

@Data
public class ComplainFilterDTO {
    private String categoryUrl;    
    private Long complainCategoryId;

    private String dateType;       
    private String startDate;       
    private String endDate;

    private String status;          
    private String complainUserName;
    private String manager;

    private int page = 1;          
    private int size = 10;         

    public int getOffset() {
        return (page - 1) * size;
    }

    public boolean isEmptyFilter() {
        return (isBlank(dateType) && isBlank(startDate) && isBlank(endDate)
                && isBlank(status) && isBlank(complainUserName) && isBlank(manager));
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}