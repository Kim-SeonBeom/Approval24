package com.example.approval24.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.approval24.dao.AccountDAO;
import com.example.approval24.dao.AuthorityAccountDAO;
import com.example.approval24.dao.AuthorityMenuDAO;
import com.example.approval24.dao.DeptInstDAO;
import com.example.approval24.dao.MenuDAO;
import com.example.approval24.dao.TotalCodeDAO;
import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.AuthorityMenuDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.MenuDTO;
import com.example.approval24.domain.MenuVO;
import com.example.approval24.domain.TotalCodeDTO;

@Service
public class AccountService {

    @Autowired
    private AccountDAO accountDAO;
    @Autowired
    private AuthorityAccountDAO authorityAccountDAO;
    @Autowired
    private AuthorityMenuDAO authorityMenuDAO;
    @Autowired
    private MenuDAO menuDAO;
    @Autowired
    private DeptInstDAO deptInstDAO;
    @Autowired
    private TotalCodeDAO codeDAO;

    //로그인 기능
    public Long login(String loginId,String password) {
        AccountDTO account = accountDAO.findByLogin(loginId);
        if (account == null) return null; 
        else if(password != account.getPassword())
        {
        	int cnt = account.getPwdFailCnt();
        	cnt++; account.setPwdFailCnt(cnt);
        	accountDAO.updateAccount(account);
        	//...
        }
        else {
        	
        }
        return account.getAccountId();
    }
    
    // 해당 계정의 메뉴/권한 조회
	public List<MenuVO> getAuthMenus(Long accountID) {
		 // 권한 ID 조회
	    List<Long> authorityIds = authorityAccountDAO.findByAccountId(accountID)
	        .stream()
	        .map(a -> a.getAuthorityId())
	        .collect(Collectors.toList());

	    // 권한이 없으면 메뉴 빈값 세션 저장
	    if (authorityIds.isEmpty()) {
	        System.out.println("⚠️ 권한이 없는 계정입니다.");
	        return Collections.emptyList();
	    }

	    // 4️⃣ 권한-메뉴 조회
	    List<AuthorityMenuDTO> authorityMenus = authorityMenuDAO.findByAuthorityIds(authorityIds);
	    if (authorityMenus.isEmpty()) {
	        System.out.println("⚠️ 메뉴 권한이 없는 계정입니다.");
	        return Collections.emptyList();
	    }

	    // 5️⃣ 전체 메뉴 조회
	    List<MenuDTO> menus = menuDAO.findAll();

	    // 6️⃣ 권한 매핑
	    List<MenuVO> menuVOList = menus.stream().map(menu -> {
	        MenuVO vo = new MenuVO();
	        vo.setMenuId(menu.getMenuId());
	        vo.setMenuName(menu.getMenuName());
	        vo.setMenuUrl(menu.getMenuUrl());
	        vo.setParentMenuId(menu.getParentMenuId());
	        vo.setSeq(menu.getSeq());
	        vo.setPopupYn(menu.getPopupYn());

	        authorityMenus.stream()
	            .filter(am -> am.getMenuId() != null && am.getMenuId().equals(menu.getMenuId()))
	            .findFirst()
	            .ifPresent(am -> {
	                vo.setReadYn(am.getReadYn());
	                vo.setCreateYn(am.getCreateYn());
	                vo.setUpdateYn(am.getUpdateYn());
	                vo.setDeleteYn(am.getDeleteYn());
	                vo.setApproveYn(am.getApproveYn());
	            });

	        return vo;
	    }).collect(Collectors.toList());
	    
		return menuVOList;
	}

	//계정 목록 필터링 조회
	public List<AccountDTO> getAccountsByFilter(Map<String, Object> filterMap) {
        return accountDAO.findAccountsByFilter(filterMap);
    }
	
	//계정 기관 아이디 조회
	public Long findInstIdByAccountId(Long accountId) {
	    return accountDAO.findInstIdByAccountId(accountId);
	}

	//부서 목록 조회
	public List<DeptInstDTO> getDeptList(Long instId) {
	    return deptInstDAO.findDeptByInst(instId);
	}

	//계정 상태 코드 이름 조회
	public List<TotalCodeDTO> getAccountStatusList(String groupId) {
	    return codeDAO.findCodesByGroupId(groupId);
	}
	
	//현재 로그인한 아이디와 같은기관&같은부서인 아이디 목록 조회
	public List<AccountDTO> myTeamAccountList(long accountId){
		 
		return accountDAO.findByAccountIdAndDeptIdAndInstId(accountId);
	}

}

