package com.example.approval24.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class InstDTO {
	
	private int instId;
	
	private String instName;
	
	private Date createDt;
	
	private Date updateDt;
	
	private String instAddress;
	
	private String instDetailAddress;
	
	private String instPhone;
	
	private String instPost;
	
	private String instHeadName;

}
