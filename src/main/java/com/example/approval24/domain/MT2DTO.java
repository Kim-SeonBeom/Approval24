package com.example.approval24.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MT2DTO {

	/** 민원 ID (FK) */
	private Long complainId;

	/** 출산일자 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthdate;

	/** 자녀 주민등록번호 */
	private String babyResiNo;

	private String babyResiNoFront;
	private String babyResiNoBack;

	/** 동거 여부 (Y/N) */
	private String cohabitYn;

	/** 관계 (예: 배우자, 자녀 등) */
	private String relationship;

	/** 사업주명 */
	private String bizOwnerNm;

	/** 사업장 우편번호 */
	private String bizPost;
	/** 사업장 주소 */
	private String bizAddr;

	/** 사업장 주소 상세 */
	private String bizAddrDetail;

	/** 고용보험 관리번호 */
	private String empInsurMngNo;

	/** 사업자등록번호 */
	private String bizRegNo;

	/** 법인등록번호 */
	private String corpRegNo;

	/** 자영업자 고용보험 가입여부 (Y/N) */
	private String selfEmpInsurYn;

	/** 급여유형 */
	private String benefitType;

	/** 임신 주차 */
	private String pregnancyWeek;

	/** 은행명 */
	private String bankNm;

	/** 계좌번호 */
	private String accountNo;

	/** 예금주명 */
	private String accountHolderNm;

	/** 소득활동 */
	private String incomeAct;

	/** 신청기간 연장 사유 */
	private String applPeriodExtReason;

	/** 신청일자 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date applDt;

	/** 생성일시 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createDt;

	/** 수정일시 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date updateDt;

	/** 생성자 ID (FK) */
	private Long createId;

	/** 수정자 ID (FK) */
	private Long updateId;

	/** 삭제 여부 (Y/N) */
	private String delYn;

	public String getBabyResiNo() {
		if (babyResiNo == null) {
			return babyResiNoFront + babyResiNoBack;
		} else
			return this.babyResiNo;
	}

	public void setBabyResiNo(String babyResiNo) {
		this.babyResiNo = babyResiNo;

		if (babyResiNo != null && babyResiNo.length() >= 13) {
			this.babyResiNoFront = babyResiNo.substring(0, 6);
			this.babyResiNoBack = babyResiNo.substring(6, 13);
		}
	}

}