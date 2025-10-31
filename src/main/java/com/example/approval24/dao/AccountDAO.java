package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.AccountDTO;

@Mapper
public interface AccountDAO {
	public AccountDTO findById(long accountId);

}
