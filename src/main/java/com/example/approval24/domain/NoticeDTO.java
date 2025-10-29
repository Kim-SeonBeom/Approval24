package com.example.approval24.domain;

import java.util.Date;

import lombok.Data;

@Data

public class NoticeDTO {
	private String title;
	private String content;	
	private long noticeId;
	private long categoryCd;
	private String userName;
	private Date createDt;
	private Date updateDt;
	private int viewAccount;
	private long createId;
	private long updateId;
	private String popupYn;
	private String delYn;
}
