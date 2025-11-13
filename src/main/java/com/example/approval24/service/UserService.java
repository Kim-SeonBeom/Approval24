package com.example.approval24.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.UserDAO;
import com.example.approval24.domain.UserDTO;

@Service
public class UserService {

    private final UserDAO userDAO;

    @Autowired
    public UserService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    // 사용자 목록 조회 (필터링 포함)
    public List<UserDTO> getUsers(Map<String, Object> params) {
        return userDAO.findUsersByFilter(params);
    }
    
    //페이징처리를 위한 카테고리별 user개수(Filter 적용)
  	public int countInsts(UserDTO filter) {
  		 return userDAO.countByFilter(filter);
  	}
  	
  	//카테고리별 유저목록(Filter 적용)
	public List<UserDTO> searchInsts(UserDTO filter) {
	    return userDAO.findByFilter(filter); 
	}
    
    

    // 2. 사용자 상세 조회 (주민번호 기준)
    public UserDTO getUserDetailByResidentNo(String userResidentNo) {
        UserDTO user = userDAO.findByResidentNo(userResidentNo);
        if (user != null && "Y".equals(user.getDelYn())) {
            return null; 
        }
        return user;
    }
    
    // 3. 사용자 등록
    @Transactional
    public int registerUser(UserDTO user) {
        UserDTO existingUser = userDAO.findByResidentNo(user.getUserResidentNo());

        if (existingUser != null) {
            if ("Y".equals(existingUser.getDelYn())) {
                user.setDelYn("N");
                return userDAO.updateUser(user);
            } else if ("N".equals(existingUser.getDelYn())) {
                throw new IllegalArgumentException("이미 활성화된 상태의 사용자입니다. 수정 기능을 이용해 주세요.");
            }
        }
        return userDAO.insertUser(user);
    }

    // 4. 사용자 정보 수정 
    @Transactional
    public int updateUserInfo(UserDTO user) {
        return userDAO.updateUser(user);
    }

    // 5. 사용자 논리 삭제 
    @Transactional
    public int deactivateUser(Long userNo,Long updateId) {
        return userDAO.deleteUser(userNo,updateId);
    }

	public int countUsersByFilter(Map<String, Object> params) {
		return userDAO.countUsersByFilter(params);
	}

	public UserDTO getUserDetailByUserNo(Long userNo) {
		return userDAO.findByUserNo(userNo);
	}
}