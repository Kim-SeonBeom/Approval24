package com.example.approval24.domain;

import java.util.List;

import lombok.Data;

@Data
public class ApprovalCreationRequestVO {

    private Long complainId;
    private List<ApprovalHistoryDTO> approvalLineData;
    private String contextUrl;
}