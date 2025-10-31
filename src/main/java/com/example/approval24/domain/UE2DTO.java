package com.example.approval24.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UE2DTO {

	    /** COMPLAIN_ID (PK1) */
	    private long complainId;

	    /** COMPLAINUSER_NO (PK2) */
	    private long complainuserNo;

	    /** BANK_NM */
	    private String bankNm;

	    /** ACCOUNT_HOLDER_NM */
	    private String accountHolderNm;

	    /** ACCOUNT_NO */
	    private String accountNo;

	    /** INCOME_OCCUR_YN (Y/N, default 'N') */
	    private String incomeOccurYn;

	    /** INCOME_DETAIL */
	    private String incomeDetail;

	    /** WORK_START_DT */
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    private Date workStartDt;

	    /** INCOME_AMT */
	    private Long incomeAmt;

	    /** INCOME_EST_AMT */
	    private Long incomeEstAmt;

	    /** BIZ_REG_YN (Y/N, default 'N') */
	    private String bizRegYn;

	    /** BIZ_REG_DT */
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    private Date bizRegDt;

	    /** BIZ_DETAIL */
	    private String bizDetail;

	    /** SELF_EMP_PREP_ACT_YN (Y/N, default 'N') */
	    private String selfEmpPrepActYn;

	    /** SELF_EMP_PREP_ACT */
	    private String selfEmpPrepAct;

	    /** SELF_EMP_START_PLAN_DT */
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    private Date selfEmpStartPlanDt;

	    /** RE_EMPLOYMENT_YN (Y/N, default 'N') */
	    private String reEmploymentYn;

	    /** RE_EMPLOYMENT_PLAN_DT */
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    private Date reEmploymentPlanDt;

	    /** CO_NM */
	    private String coNm;

	    /** CO_TEL_NO */
	    private String coTelNo;

	    /** NON_JOB_SEEK_ACTIVITY */
	    private String nonJobSeekActivity;

	    /** APPL_DT */
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    private Date applDt;

	    /** CREATE_DT */
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    private Date createDt;

	    /** UPDATE_DT */
	    @DateTimeFormat(pattern = "yyyy-MM-dd")
	    private Date updateDt;

	    /** CREATE_ID */
	    private long createId;

	    /** UPDATE_ID */
	    private long updateId;

	    /** DEL_YN (Y/N, default 'N') */
	    private String delYn;
	}
