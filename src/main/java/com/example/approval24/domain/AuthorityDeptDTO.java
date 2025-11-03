package com.example.approval24.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AuthorityDeptDTO {
    private Long deptId;      // DEPT_ID (부서 ID)
    private Long authorityId; // AUTHORITY_ID (권한 ID)
    private Date createDt;    // CREATE_DT (생성일자)
    private Date updateDt;    // UPDATE_DT (수정일자)
    private Long createId;    // CREATE_ID (생성자 ID)
    private Long updateId;    // UPDATE_ID (수정자 ID)
    private String delYn;     // DEL_YN (삭제 여부, CHAR(1))
}
