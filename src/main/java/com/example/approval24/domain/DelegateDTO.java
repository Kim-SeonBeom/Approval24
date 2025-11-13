package com.example.approval24.domain;

import lombok.Data;

@Data
public class DelegateDTO {

	private Long absId;
	private Long delegateId;
	private String delegateUserName;
	private String startDt; // 시작일
	private String endDt; // 종료일
	private String proxyComment; // 사유
	private Long seqNo; // 순번
	private String delYn;
	private String createDt; // 생성일
	private String updateDt; // 수정일
	
	private String dateType;
	
	private int page = 1;          
    private int size = 10;         

    public int getOffset() {
        return (page - 1) * size;
    }

    public boolean isEmptyFilter() {
        return (isBlank(dateType) && isBlank(delYn) && isBlank(delegateUserName) && isBlank(startDt)
                && isBlank(endDt) && isBlank(proxyComment) && isNullOrEmpty(seqNo));
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
    
    private boolean isNullOrEmpty(Object o) {
        return o == null || o.toString().trim().isEmpty();
    }

}
