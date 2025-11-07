package com.example.approval24.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// @Getter, @Setter로 모든 필드의 getter/setter 자동 생성
@Getter 
@Setter
@ToString
public class PageInfoVO {

    // ⭐️ 클라이언트가 요청한 정보
    private int page;         // 현재 페이지 번호 
    private int pageSize;     // 페이지당 항목 수 

    // ⭐️ 데이터베이스에서 조회한 정보
    private int totalCount;   // 전체 항목 수 
    
    // ⭐️ 계산된 정보
    private int totalPages;   // 전체 페이지 수 
    private int startRow;     // 현재 페이지의 시작 RNUM 
    private int endRow;       // 현재 페이지의 끝 RNUM 
    
    // ⭐️ 페이지네이션 UI를 위한 정보 
    private int startPage;    // 현재 블록의 시작 페이지 버튼 번호 
    private int endPage;      // 현재 블록의 마지막 페이지 버튼 번호 
    private static final int PAGE_BLOCK_SIZE = 10; // 페이지 버튼 블록 크기 (예: 1~10, 11~20)

    // ----------------------------------------------------
    // 💡 생성자 (요청 정보 및 전체 개수를 받아 계산)
    // ----------------------------------------------------
    public PageInfoVO(int page, int pageSize, int totalCount) {
        this.page = page;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        
        // 페이징 정보를 계산하는 메서드 호출
        calculatePageInfo();
    }
    
    private void calculatePageInfo() {
        // 1. 전체 페이지 수 계산 (올림 처리)
        this.totalPages = (int) Math.ceil((double) this.totalCount / this.pageSize);

        // 2. 오라클 RNUM을 위한 시작/종료 로우 계산
        this.endRow = this.page * this.pageSize;
        this.startRow = this.endRow - this.pageSize + 1;
        
        // 요청된 페이지가 1보다 작으면 1페이지로 고정
        if (this.page < 1) {
            this.page = 1;
        }

        // 요청된 페이지가 전체 페이지 수를 초과하면 마지막 페이지로 조정
        if (this.totalPages > 0 && this.page > this.totalPages) {
            this.page = this.totalPages;
        }
        
        // 3. 페이지 블록 계산 (페이지네이션 버튼 UI)
        this.startPage = ((this.page - 1) / PAGE_BLOCK_SIZE) * PAGE_BLOCK_SIZE + 1;

        // 현재 블록의 마지막 페이지 계산
        this.endPage = this.startPage + PAGE_BLOCK_SIZE - 1;

        // 마지막 페이지 버튼이 전체 페이지 수를 초과하지 않도록 조정
        if (this.endPage > this.totalPages) {
            this.endPage = this.totalPages;
        }
    }

}