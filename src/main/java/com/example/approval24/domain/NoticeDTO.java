package com.example.approval24.domain;

import java.util.Date;

import lombok.Data;

@Data

public class NoticeDTO {
	private long noticeId;
	private String title;
	private String content;
	private String categoryCd;
	private String categoryName;
	private String userName;
	private Date createDt;
	private Date updateDt;
	private Long viewCount;
	private Long createId;
	private Long updateId;
	private String popupYn;
	private String delYn;

}
