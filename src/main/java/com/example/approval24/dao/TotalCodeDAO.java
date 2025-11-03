package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.TotalCodeDTO;

@Mapper
public interface TotalCodeDAO {
    List<TotalCodeDTO> findCodesByGroupId(@Param("groupId") String groupId);
    
	public List<TotalCodeDTO> getAllTotalCode();
}
