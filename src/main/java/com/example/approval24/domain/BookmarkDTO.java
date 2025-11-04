package com.example.approval24.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class BookmarkDTO {
    private Long bookmarkId;
    private Long accountId;
    private String bookmarkName;
    private Date createDt;
    private Date updateDt;
    private String delYn;

    // 상세 결재자 리스트
    private List<Approver> approvers;

    @Data
    public static class Approver {
        private Long seqNo;             
        private Long approverId;
        private String approverTypeCd;
        private Date createDt;
        private Date updateDt;
        private String delYn;
    }
}
