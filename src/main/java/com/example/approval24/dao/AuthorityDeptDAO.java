package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.AuthorityDeptDTO;
import com.example.approval24.domain.DeptDTO;

@Mapper
public interface AuthorityDeptDAO {
	List<DeptDTO> getDeptsByAuthorityId(Long authorityId);
	
	int insertAuthorityDept(AuthorityDeptDTO authorityDeptDTO);
	
	int updateAuthorityDept(AuthorityDeptDTO authorityDeptDTO);
	
	AuthorityDeptDTO selectAuthorityDept(@Param("authorityId") Long authorityId, @Param("deptId") Long deptId);

	
}
