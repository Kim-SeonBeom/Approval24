package com.example.approval24.domain;

import lombok.Data;

@Data
public class NoticeFilterDTO {   
    private Long complainCategoryId;
    private String noticeId;
    private String categoryCd;
    private String codeId;
    
    private String createDt;     
    private String startDate;        
    private String endDate;    
    private String startRow;
    private String endRow;

    private String status;          
    private String userName;
    
    private String title;
    private String categoryName;
    
    private Long viewCount;

    private int page = 1;          
    private int size = 10;         

    public int getOffset() {
        return (page - 1) * size;
    }

    public boolean isEmptyFilter() {
        return (isBlank(title)&&isBlank(categoryName) && isBlank(userName) && isBlank(createDt)
                && viewCount == null);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}