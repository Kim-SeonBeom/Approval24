package com.example.approval24.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserDTO {
    private String userResidentNo; // 주민등록번호
    private Long userNo;           // 사용자 번호 (PK)
    private String userName;       // 사용자 이름
    private String userEmail;      // 이메일
    private String userTel;        // 전화번호
    private String userPhone;      // 휴대전화
    private String userPositionCd; // 직급 코드
    private String delYn;          // 삭제 여부
    private Date createDt;         // 생성일
    private Date updateDt;         // 수정일
    private Long createId;         // 생성자 ID
    private Long updateId;         // 수정자 ID
    
    private String userPositionName; //직급 이름
}
