package com.example.approval24.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class noticeDTO {
	private String title;
	private String content;	
	private long noticeId;
	private long categoryCd;
	private String userName;
	private Date createDt;
	private int viewAccount;
}
