package com.example.approval24.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// @Getter, @Setter로 모든 필드의 getter/setter 자동 생성
@Getter 
@Setter
@ToString
public class PageInfoVO {

    private int page;         
    private int pageSize;   

   
    private int totalCount;   
    
    private int totalPages;   
    private int startRow;    
    private int endRow;      
    
  
    private int startPage;    
    private int endPage;     
    private static final int PAGE_BLOCK_SIZE = 10; 

    public PageInfoVO(int page, int pageSize, int totalCount) {
        this.page = page;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        
        calculatePageInfo();
    }
    
    private void calculatePageInfo() {
        this.totalPages = (int) Math.ceil((double) this.totalCount / this.pageSize);

        this.endRow = this.page * this.pageSize;
        this.startRow = this.endRow - this.pageSize + 1;
        
        if (this.page < 1) {
            this.page = 1;
        }

        if (this.totalPages > 0 && this.page > this.totalPages) {
            this.page = this.totalPages;
        }
        
        this.startPage = ((this.page - 1) / PAGE_BLOCK_SIZE) * PAGE_BLOCK_SIZE + 1;

        this.endPage = this.startPage + PAGE_BLOCK_SIZE - 1;

        if (this.endPage > this.totalPages) {
            this.endPage = this.totalPages;
        }
    }

}