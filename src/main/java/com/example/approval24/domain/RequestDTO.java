package com.example.approval24.domain;

import java.util.List;

import lombok.Data;

@Data
public class RequestDTO {
	private String instName;
	private String deptName;
	private String userName;
	private String loginId;
	private String password;
	private String phone;
	private long userNo;
	private String authName;
	private String userResidentNo;
	private long authorityId;
	private String authorityName;
	List<AuthorityDTO> authorityList;
}
