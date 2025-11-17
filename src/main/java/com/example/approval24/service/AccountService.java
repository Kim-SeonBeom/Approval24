package com.example.approval24.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.AccountDAO;
import com.example.approval24.dao.AuthorityAccountDAO;
import com.example.approval24.dao.AuthorityMenuDAO;
import com.example.approval24.dao.MenuDAO;
import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.AuthorityMenuDTO;
import com.example.approval24.domain.MenuDTO;
import com.example.approval24.domain.MenuVO;
import com.example.approval24.util.BCryptUtil;

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

    //로그인 기능
    public AccountDTO login(String loginId, String password) {
        AccountDTO account = accountDAO.checkByLogin(loginId);
        if (account == null) return null;
        boolean check = BCryptUtil.matches(password, account.getPassword());
        if (!check)
        {
        	int cnt = account.getPwdFailCnt();
        	if(cnt < 5) {
        		cnt++; 
        		account.setPwdFailCnt(cnt);
        		accountDAO.updateAccount(account);
        		account.setAccountStatusCd("mispassword");
        	}else{
        		account.setAccountStatusCd("B005");
        		accountDAO.updateAccount(account);
        		account.setAccountStatusCd("lockaccount");
        	}
        	
        }
        else {
        	if(account.getAccountStatusCd().equals("B002")) {
    		account.setPwdFailCnt(0);
    		accountDAO.updateAccount(account);
        	}
        	else if(account.getAccountStatusCd().equals("B001")) {
        		account.setAccountStatusCd("waitaccount");
        	}
        	else if(account.getAccountStatusCd().equals("B003")) {
        		account.setAccountStatusCd("backaccount");
        	}
        	else if(account.getAccountStatusCd().equals("B004")) {
        		account.setAccountStatusCd("noneaccount");
        	}
        	else if(account.getAccountStatusCd().equals("B005")) {
        		account.setAccountStatusCd("lockaccount");
        	}else {
        		return account;
        	}
    	}
        	account.setPassword(null);
        	return account;
       
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
	        return Collections.emptyList();
	    }

	    // 권한-메뉴 조회
	    List<AuthorityMenuDTO> authorityMenus = authorityMenuDAO.findByAuthorityIds(authorityIds);
	    if (authorityMenus.isEmpty()) {
	        return Collections.emptyList();
	    }

	    // 전체 메뉴 조회
	    List<MenuDTO> menus = menuDAO.findAll();

	    // 권한 매핑
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
	
	//현재 로그인한 아이디와 같은기관&같은부서인 아이디 목록 조회
	public List<AccountDTO> myTeamAccountList(long accountId){
		return accountDAO.findByAccountIdAndDeptIdAndInstId(accountId);
	}
	
	// 카운트
	public int countAccountsByFilter(Map<String, Object> params) {
		return accountDAO.countAccountsByFilter(params);
	}
	
	@Transactional
	public void updateAccountList(List<AccountDTO> accountList) {
		for(AccountDTO account : accountList) {
			accountDAO.updateAccount(account);
		}
	}
	
	// ajax
	public List<AccountDTO> accountsByInstDept(Long instId, Long deptId) {
	    return accountDAO.findAccountsByInstAndDept(instId, deptId);
	}

}

