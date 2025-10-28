package com.example.approval24.domain;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthorityDTO {
    private Long authorityId;      // AUTHORITY_ID
    private String authorityName;  // AUTHORITY_NAME
    private Date createDt;         // CREATE_DT
    private Date updateDt;         // UPDATE_DT
    private Long createId;         // CREATE_ID
    private Long updateId;         // UPDATE_ID
    private String delYn;          // DEL_YN
    private String isSystem;       // IS_SYSTEM
}
