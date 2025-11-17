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
    private String approvalTypeCd;
    
    //추가사항
    private String approvalStatusName; 
    private String approverTypeName;    
    private String approvalTypeName;
    private String categoryCd;        
    private String categoryName;
    private String userName;
    private String processorName;
}
