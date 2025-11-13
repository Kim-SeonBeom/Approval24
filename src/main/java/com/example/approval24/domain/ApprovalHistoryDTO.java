package com.example.approval24.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ApprovalHistoryDTO {
    private Long complainId;
    private Long delegateId;
    private Long accountId;
    private String approvalStatusCd;
    private String approverTypeCd;
    private Date processDt;
    private String approvalComment;
    private Long seqNo;
    private String url;
    
    //추가사항
    private String approvalStatusName; // 결재 상태 이름 승인,반려 등등..
    private String approverTypeName;    // 결재자 이름 접수자,담당자,승인자,반려자 등등..
    private String categoryCd;        
    private String categoryName;
    private String userName;
    
}
