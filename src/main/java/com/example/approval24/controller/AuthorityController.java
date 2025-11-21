package com.example.approval24.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.AuthorityDTO;
import com.example.approval24.domain.AuthorityMenuDTO;
import com.example.approval24.domain.DeptDTO;
import com.example.approval24.domain.MenuDTO;
import com.example.approval24.service.AuthorityService;

@Controller
@RequestMapping("/authority")
public class AuthorityController {

    @Autowired
    private AuthorityService authorityService;

    @GetMapping("")
    public String Defalt() {
    	return "redirect:/authority/list";
    }
    // 전체 권한 목록 조회
    @GetMapping("/list")
    public String listAuthorities(
    		@RequestParam(value = "createDt", required = false) String createDtStr,
            @RequestParam(value = "updateDt", required = false) String updateDtStr,
        /*@RequestParam(value = "deptId", required = false) Long deptId,
        @RequestParam(value = "sortField", required = false) String sortField,
        @RequestParam(value = "sortOrder", required = false) String sortOrder,*/
        AuthorityDTO filter,
        Model model) {
        
        /*List<AuthorityDTO> authorities = authorityService.getAllAuthorities(deptId, sortField, sortOrder);*/
        
        //부서 목록 조회 및 모델에 담기 (JSP 드롭다운 생성용)
        /*List<DeptDTO> allDepartments = authorityService.getAllDepartments();
        model.addAttribute("allDepartments", allDepartments);
        
        model.addAttribute("authorities", authorities);*/
        
        //현재 선택된 필터/정렬 상태를 모델에 담아 JSP가 상태를 유지하도록 함
        /*model.addAttribute("currentDeptId", deptId);
        model.addAttribute("currentSortField", sortField);
        model.addAttribute("currentSortOrder", sortOrder);*/
    	filter.applyDateStrings(createDtStr, updateDtStr);
    	
    	// 최초 진입 (빈 리스트)
		if (filter.isEmptyFilter()) {
			model.addAttribute("authorityList", Collections.emptyList());
			model.addAttribute("filter", filter);
			model.addAttribute("totalCount", 0);
			model.addAttribute("totalPages", 0);
			return "A/authorityList";
		}
		// 조건 검색
		int totalCount = authorityService.countAuthority(filter);
		List<AuthorityDTO> authorityList = authorityService.searchAuthority(filter);
		
		model.addAttribute("authorityList", authorityList);
		model.addAttribute("filter", filter);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / filter.getSize()));
    	
        
        return "A/authorityList"; 
    }
    
    // 권한 등록/수정 폼 이동
    @GetMapping({"/create", "/edit/{authorityId}"})
    public String form(@PathVariable(required = false) Long authorityId, Model model) {
        AuthorityDTO authority = authorityId != null ? authorityService.getAuthorityById(authorityId) : new AuthorityDTO();
        model.addAttribute("authority", authority != null ? authority : new AuthorityDTO());
        return "A/authorityForm"; // create/edit 공용 폼
    }

    // 권한 등록 처리
    @PostMapping("/create")
    public String createAuthority(@ModelAttribute AuthorityDTO authority) {
        authorityService.createAuthority(authority);
        return "redirect:/authority/list";
    }

    // 권한 수정 처리
    @PostMapping("/edit")
    public String updateAuthority(@ModelAttribute AuthorityDTO authority) {
        authorityService.updateAuthority(authority);
        return "redirect:/authority/list";
    }

    // 권한 삭제 처리
    @PostMapping("/delete/{authorityId}")
    public String deleteAuthority(@PathVariable Long authorityId) {
        authorityService.deleteAuthority(authorityId);
        return "redirect:/authority/list";
    }

    // 권한 상세 페이지
    @GetMapping("/detail/{authorityId}")
    public String authorityDetail(@PathVariable Long authorityId, Model model) {
        AuthorityDTO authority = authorityService.getAuthorityById(authorityId);
        model.addAttribute("authority", authority != null ? authority : new AuthorityDTO());

        List<AuthorityMenuDTO> authorityMenus = authorityService.getMenusByAuthorityId(authorityId);
        model.addAttribute("authorityMenus", authorityMenus);

        // 이미 권한에 할당된 메뉴 ID 모음
        Set<Long> assignedMenuIds = authorityMenus.stream()
                .map(AuthorityMenuDTO::getMenuId)
                .collect(Collectors.toSet());

        // 전체 메뉴 중 미할당 메뉴만 필터링
        List<MenuDTO> allMenus = authorityService.getAllMenus().stream()
                .filter(menu -> !assignedMenuIds.contains(menu.getMenuId()))
                .sorted(Comparator.comparingLong(MenuDTO::getSeq))
                .collect(Collectors.toList());

        model.addAttribute("unassignedMenus", allMenus);

        List<DeptDTO> authorityDepartments = authorityService.getDepartmentsByAuthorityId(authorityId);
        model.addAttribute("authorityDepartments", authorityDepartments);

        // 미할당 부서 목록 조회
        Set<Long> assignedDeptIds = authorityDepartments.stream()
                .map(DeptDTO::getDeptId)
                .collect(Collectors.toSet());
        
        // 전체 부서 목록을 가져오는 서비스 메서드 호출
        List<DeptDTO> unassignedDepartments = authorityService.getAllDepartments().stream()
                .filter(dept -> !assignedDeptIds.contains(dept.getDeptId()))
                .collect(Collectors.toList());

        model.addAttribute("unassignedDepartments", unassignedDepartments);
        

        return "A/authorityDetail";
    }

    // 권한-메뉴 매핑 등록 (한꺼번에)
    @PostMapping("/addMenus")
    public String addAuthorityMenus(@RequestParam Long authorityId,
    								@RequestParam(value = "menuIds", required = false) List<Long> menuIds,
    								@RequestParam Map<String, String> allParams,
                                    HttpSession session) {

        Long id = (Long) session.getAttribute("user"); 
        if (id == null) {
        	return "redirect:/login";
        }
        
        if (menuIds != null && !menuIds.isEmpty()) {
            List<AuthorityMenuDTO> authorityMenus = new java.util.ArrayList<>();
            
            for (Long menuId : menuIds) { 
                AuthorityMenuDTO am = new AuthorityMenuDTO();
                am.setCreateId(id);
                am.setUpdatedId(id);
                am.setAuthorityId(authorityId);
                am.setMenuId(menuId);

                am.setReadYn(allParams.containsKey("readYn_" + menuId) ? "Y" : "N");
                am.setCreateYn(allParams.containsKey("createYn_" + menuId) ? "Y" : "N");
                am.setUpdateYn(allParams.containsKey("updateYn_" + menuId) ? "Y" : "N");
                am.setDeleteYn(allParams.containsKey("deleteYn_" + menuId) ? "Y" : "N");
                am.setApproveYn(allParams.containsKey("approveYn_" + menuId) ? "Y" : "N");
                authorityMenus.add(am);
            }
            authorityService.createAuthorityMenus(authorityMenus);
        }

        return "redirect:/authority/detail/" + authorityId;
    }

    @PostMapping("/updateMenu")
    public String updateAuthorityMenu(@RequestParam Long authorityId,
                                      @RequestParam Long menuId,
                                      @RequestParam(defaultValue = "N") String readYn,
                                      @RequestParam(defaultValue = "N") String createYn,
                                      @RequestParam(defaultValue = "N") String updateYn,
                                      @RequestParam(defaultValue = "N") String deleteYn,
                                      @RequestParam(defaultValue = "N") String approveYn,
                                      HttpSession session, 
                                      RedirectAttributes rttr) {

        AuthorityMenuDTO am = new AuthorityMenuDTO();
        am.setAuthorityId(authorityId);
        am.setMenuId(menuId);
        am.setReadYn(readYn);
        am.setCreateYn(createYn);
        am.setUpdateYn(updateYn);
        am.setDeleteYn(deleteYn);
        am.setApproveYn(approveYn);

        Long id = (Long) session.getAttribute("user"); 
        if (id == null) {
        	return "redirect:/login";
        }

        am.setUpdatedId(id);
        authorityService.updateAuthorityMenu(am);

        return "redirect:/authority/detail/" + authorityId;
    }
    
    
    // 권한-메뉴 삭제 (단일)
    @PostMapping("/deleteMenu")
    public String deleteAuthorityMenu(@RequestParam Long authorityId, @RequestParam Long menuId) {
        authorityService.deleteAuthorityMenu(authorityId, menuId);
        return "redirect:/authority/detail/" + authorityId;
    }
    
    
    //권한 부서 등록
    @PostMapping("/addDepartments")
    public String addAuthorityDepartments(@RequestParam Long authorityId,
                                            @RequestParam(value = "deptIds", required = false) List<Long> deptIds,
                                            HttpSession session) {

        Long currentUserId = (Long) session.getAttribute("user");
        if (currentUserId == null) {
            return "redirect:/login"; 
        }

        if (deptIds != null && !deptIds.isEmpty()) {
            authorityService.addOrReactivateAuthorityDepartments(authorityId, deptIds, currentUserId);
        }

        return "redirect:/authority/detail/" + authorityId;
    }


    // 권한-부서 삭제
    @PostMapping("/removeDepartment")
    public String removeAuthorityDepartment(@RequestParam Long authorityId, @RequestParam Long deptId, HttpSession session) {
        
        Long currentUserId = (Long) session.getAttribute("user");
        if (currentUserId == null) {
            return "redirect:/login"; 
        }

        authorityService.deactivateAuthorityDepartment(authorityId, deptId, currentUserId);
        return "redirect:/authority/detail/" + authorityId;
    }
}
