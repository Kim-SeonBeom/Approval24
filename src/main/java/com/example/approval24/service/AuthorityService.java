package com.example.approval24.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.AuthorityAccountDAO;
import com.example.approval24.dao.AuthorityDAO;
import com.example.approval24.dao.AuthorityDeptDAO;
import com.example.approval24.dao.AuthorityMenuDAO;
import com.example.approval24.dao.DeptDAO;
import com.example.approval24.dao.MenuDAO;
import com.example.approval24.domain.AlarmDTO;
import com.example.approval24.domain.AuthorityAccountDTO;
import com.example.approval24.domain.AuthorityDTO;
import com.example.approval24.domain.AuthorityDeptDTO;
import com.example.approval24.domain.AuthorityMenuDTO;
import com.example.approval24.domain.DeptDTO;
import com.example.approval24.domain.MenuDTO;

@Service
public class AuthorityService {

    @Autowired
    private AuthorityDAO authorityDAO;
    
    @Autowired
    private AuthorityMenuDAO authorityMenuDAO;
    
    @Autowired 
    private MenuDAO menuDAO;
    
    @Autowired
    private AuthorityDeptDAO authorityDeptDAO;
    
    @Autowired
    private DeptDAO	deptDAO;

    public List<AuthorityDTO> getAllAuthorities(Long deptId, String sortField, String sortOrder) {
        Map<String, Object> params = new HashMap<>();
            
        if (deptId != null) {
            params.put("deptId", deptId);
        }
        
        if (sortField != null && !sortField.isEmpty()) {
            params.put("sortField", sortField);
            
            if (sortOrder == null || sortOrder.isEmpty()) {
                params.put("sortOrder", "DESC");
            } else {
                params.put("sortOrder", sortOrder.toUpperCase());
            }
        }
        
        return authorityDAO.findAll(params);
    }

    // 권한 ID로 상세 조회
    public AuthorityDTO getAuthorityById(Long authorityId) {
        return authorityDAO.findById(authorityId);
    }

    // 권한 등록
    @Transactional
    public void createAuthority(AuthorityDTO authority) {
        authorityDAO.insertAuthority(authority);
    }

    // 권한 수정
    @Transactional
    public void updateAuthority(AuthorityDTO authority) {
        authorityDAO.updateAuthority(authority);
    }

    // 권한 삭제
    @Transactional
    public void deleteAuthority(Long authorityId) {
        authorityDAO.deleteAuthority(authorityId);
    }
    
    //권한 ID로 메뉴 매핑 조회
    public List<AuthorityMenuDTO> getMenusByAuthorityId(Long authorityId) {
        return authorityMenuDAO.findByAuthorityId(authorityId);
    }

    //메뉴 ID로 메뉴 정보 조회 (단일 메뉴 정보)
    public MenuDTO getMenuById(Long menuId) {
        return menuDAO.findById(menuId);
    }

    //권한-메뉴 등록 (한꺼번에 여러 개 가능)
    @Transactional
    public void createAuthorityMenus(List<AuthorityMenuDTO> authorityMenus) {
        for (AuthorityMenuDTO am : authorityMenus) {
        	AuthorityMenuDTO deletedMenu = authorityMenuDAO.findDeletedAuthorityMenu(am);
        	if (deletedMenu != null) {
                authorityMenuDAO.updateAuthorityMenu(am);
            } else {
       
                authorityMenuDAO.insertAuthorityMenu(am);
            }
        }
    }
    
    //업데이트
    @Transactional
    public void updateAuthorityMenu(AuthorityMenuDTO authorityMenu) {
        authorityMenuDAO.updateAuthorityMenu(authorityMenu);
    }
    
    //권한-메뉴 삭제 (특정 메뉴 하나씩)
    @Transactional
    public void deleteAuthorityMenu(Long authorityId, Long menuId) {
        authorityMenuDAO.deleteAuthorityMenu(authorityId, menuId);
    }

    // 전체 메뉴 조회
    public List<MenuDTO> getAllMenus() {
        return menuDAO.findAll();
    }
    
    // 권한-부서 조회
    public List<DeptDTO> getDepartmentsByAuthorityId(Long authorityId) {
        return authorityDeptDAO.getDeptsByAuthorityId(authorityId);
    }
    // 권한 ID로 권한 ID 리스트 조회
    public List<AuthorityDTO> findByAccountId(Long accountId){
    	return authorityDAO.findByAccountId(accountId);
    }
    
    @Transactional
    public void addOrReactivateAuthorityDepartments(Long authorityId, List<Long> deptIds, Long currentUserId) {
        if (deptIds != null) {
            for (Long deptId : deptIds) {
                
                AuthorityDeptDTO existingMapping = authorityDeptDAO.selectAuthorityDept(authorityId, deptId);

                if (existingMapping == null) {
                    AuthorityDeptDTO newMapping = new AuthorityDeptDTO();
                    newMapping.setAuthorityId(authorityId);
                    newMapping.setDeptId(deptId);
                    newMapping.setCreateId(currentUserId);
                    authorityDeptDAO.insertAuthorityDept(newMapping);

                } else if ("Y".equals(existingMapping.getDelYn())) {
                    existingMapping.setUpdateId(currentUserId);
                    existingMapping.setDelYn("N");
                    
                    authorityDeptDAO.updateAuthorityDept(existingMapping); 
                }
            }
        }
    }
    
    @Transactional
    public void deactivateAuthorityDepartment(Long authorityId, Long deptId, Long currentUserId) {
        AuthorityDeptDTO existingMapping = authorityDeptDAO.selectAuthorityDept(authorityId, deptId);
        
        if (existingMapping != null && "N".equals(existingMapping.getDelYn())) {
            existingMapping.setUpdateId(currentUserId);
            existingMapping.setDelYn("Y");
            authorityDeptDAO.updateAuthorityDept(existingMapping); 
        }
    }
    
    @Transactional
    public List<DeptDTO> getAllDepartments() {
        return deptDAO.getAllDept();
    }
    
    
    
	//페이징처리를 위한 카테고리별 Authority개수(Filter 적용)
	public int countAuthority(AuthorityDTO filter) {
		 return authorityDAO.countByFilter(filter);
	}
	
	//카테고리별 권한목록(Filter 적용)
    public List<AuthorityDTO> searchAuthority(AuthorityDTO filter) {
        return authorityDAO.findByFilter(filter); 
    }
    
}
