package com.example.approval24.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UE1DTO {

	private int complainId;

	private int complainuserNo;

	private String prevCoNm;

	private String prevCoTelNo;

	private String prevCoPosition;

	/** EMP_DT */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date empDt;

	/** UNEMP_DT */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date unempDt;

	/** UNEMP_PERIOD */
	private String unempPeriod;

	/** SUBSIDY_BENEFIT_YN (Y/N) */
	private String subsidyBenefitYn;

	/** SUBSIDY_AMT */
	private Long subsidyAmt;

	/** BIZ_REG_YN (Y/N) */
	private String bizRegYn;

	/** TRAIN_INST_NM */
	private String trainInstNm;

	/** TRAIN_POST */
	private String trainPost;

	/** TRAIN_INST_ADDR */
	private String trainInstAddr;

	/** TRAIN_INST_ADDR_DETAIL */
	private String trainInstAddrDetail;

	/** TRAIN_START_DT */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date trainStartDt;

	/** TRAIN_END_DT */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date trainEndDt;

	/** TRAIN_PERIOD (일수 등 정수성 데이터) */
	private int trainPeriod;

	/** TUITION_FEE_AMT */
	private Long tuitionFeeAmt;

	/** LOAN_APPL_AMT */
	private Long loanApplAmt;

	/** APPL_DT (DEFAULT SYSDATE) */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date applDt;

	/** CREATE_DT (DEFAULT SYSDATE) */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createDt;

	/** UPDATE_DT (DEFAULT SYSDATE) */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updateDt;

	/** CREATE_ID */
	private int createId;

	/** UPDATE_ID */
	private int updateId;

	/** DEL_YN (Y/N, DEFAULT 'N') */
	private String delYn;
}
