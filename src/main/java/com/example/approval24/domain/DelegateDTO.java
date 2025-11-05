package com.example.approval24.domain;

import lombok.Data;

@Data
public class DelegateDTO {

	private Long absId;
	private Long delegateId;
	private String delegateUserName;
	private String startDt;
	private String endDt;
	private String proxyComment;
	private Long seqNo;

}
