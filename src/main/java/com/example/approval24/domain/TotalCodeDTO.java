package com.example.approval24.domain;

import lombok.Data;

@Data
public class TotalCodeDTO {
    private String groupId;
    private String codeId;
    private String sequence;
    private String codeName;
    private String codeDetail;
    private String delYn;
}