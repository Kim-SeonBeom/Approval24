package com.example.approval24.domain;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthorityAccountDTO {
    private Long accountId;      // ACCOUNT_ID
    private Long authorityId;    // AUTHORITY_ID
    private Date createDt;       // CREATE_DT
    private Date updateDt;       // UPDATE_DT
    private Long createId;       // CREATE_ID
    private Long updateId;       // UPDATE_ID
    private String delYn;        // DEL_YN
}
