package com.example.approval24.domain;

import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MT1DTO {

    /** COMPLAIN_ID (PK & FK) */
    private long complainId;

    /** BIRTH_DT (아이 출생일) */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthDt;

    /** INFANT_RRN_FRONT (자녀 주민번호 앞자리) */
    private String infantRrnFront;

    /** INFANT_RRN_BACK (자녀 주민번호 뒷자리) */
    private String infantRrnBack;

    /** MULTIPLE_BIRTH_YN (다태아 여부, Y/N, default 'N') */
    private String multipleBirthYn;

    /** PREMATURE_BABY_YN (미숙아 여부, Y/N, default 'N') */
    private String prematureBabyYn;

    /** CONTRACT_START_DT (근로계약 시작일) */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date contractStartDt;

    /** CONTRACT_END_DT (근로계약 종료일) */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date contractEndDt;

    /** MATERNITY_LEAVE_PERIOD (출산휴가 기간(문자표기)) */
    private String maternityLeavePeriod;

    /** CURRENT_APPL_START_DT (이번 신청기간 시작) */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date currentApplStartDt;

    /** CURRENT_APPL_END_DT (이번 신청기간 종료) */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date currentApplEndDt;

    /** PAYMENT_ACCOUNT_NO (지급 계좌번호) */
    private String paymentAccountNo;

    /** BANK_NM (은행명) */
    private String bankNm;

    /** ACCOUNT_HOLDER_NM (예금주) */
    private String accountHolderNm;

    /** INCOME_YN (소득 발생 여부, Y/N, default 'N') */
    private String incomeYn;

    /** INCOME_TYPE (소득 종류) */
    private String incomeType;

    /** INCOME_START_TIME (소득 발생 시작시간) */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date incomeStartTime;

    /** INCOME_END_TIME (소득 발생 종료시간) */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date incomeEndTime;

    /** WORK_HOURS (근로시간(문자)) */
    private String workHours;

    /** APPL_DT (신청일, default SYSDATE) */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date applDt;

    /** CREATE_DT (생성시각, TIMESTAMP) */
    private Date createDt;

    /** UPDATE_DT (수정시각, TIMESTAMP) */
    private Date updateDt;

    /** CREATE_ID (작성자 계정ID, FK) */
    private Long createId;

    /** UPDATE_ID (수정자 계정ID, FK) */
    private Long updateId;

    /** DEL_YN (논리삭제 Y/N, default 'N') */
    private String delYn;
}
