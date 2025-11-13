package com.example.approval24.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccountDTO {
    private Long accountId;          // ACCOUNT_ID
    private Long userNo;             // USER_NO
    private Long instId;             // INST_ID
    private String instName;
    private Long deptId;             // DEPT_ID
    private String loginId;          // LOGIN_ID
    private String password;         // PASSWORD
    private Date createDt;           // CREATE_DT
    private Date updateDt;           // UPDATE_DT
    private String delYn;            // DEL_YN
    private Long createId;           // CREATE_ID
    private Long updateId;           // UPDATE_ID
    private String accountStatusCd;  // ACCOUNT_STATUS_CD
    private Integer pwdFailCnt;      // PWD_FAIL_CNT
    private Date pwdChangeDt;        // PWD_CHANGE_DT
    private String isSystem;         // IS_SYSTEM
    
    private String userName; 		 // 추가 사항 유저이름
    private String deptName;         // 추가 사항 부서이름
    private String accountStatusName; // 계정 상태 이름
}

