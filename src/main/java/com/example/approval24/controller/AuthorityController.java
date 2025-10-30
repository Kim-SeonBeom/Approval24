package com.example.approval24.controller;

import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.AuthorityDTO;
import com.example.approval24.domain.AuthorityMenuDTO;
import com.example.approval24.domain.MenuDTO;
import com.example.approval24.service.AuthorityService;

@Controller
@RequestMapping("/authority")
public class AuthorityController {

    @Autowired
    private AuthorityService authorityService;

    // 전체 권한 목록 조회
    @GetMapping("/list")
    public String listAuthorities(Model model) {
        List<AuthorityDTO> authorities = authorityService.getAllAuthorities();
        model.addAttribute("authorities", authorities);
        return "A/authorityList"; // list.jsp
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

        model.addAttribute("allMenus", allMenus);

        return "A/authorityDetail";
    }

    // 권한-메뉴 매핑 등록 (한꺼번에)
    @PostMapping("/addMenus")
    public String addAuthorityMenus(@RequestParam Long authorityId,
                                    @RequestParam(value = "menuIds", required = false) List<Long> menuIds,
                                    @RequestParam(value = "readYn", required = false) List<String> readYns,
                                    @RequestParam(value = "createYn", required = false) List<String> createYns,
                                    @RequestParam(value = "updateYn", required = false) List<String> updateYns,
                                    @RequestParam(value = "deleteYn", required = false) List<String> deleteYns,
                                    @RequestParam(value = "approveYn", required = false) List<String> approveYns) {

        if (menuIds != null && !menuIds.isEmpty()) {
            List<AuthorityMenuDTO> authorityMenus = new java.util.ArrayList<>();
            for (int i = 0; i < menuIds.size(); i++) {
                AuthorityMenuDTO am = new AuthorityMenuDTO();
                am.setAuthorityId(authorityId);
                am.setMenuId(menuIds.get(i));
                am.setReadYn(readYns != null && readYns.size() > i ? readYns.get(i) : "N");
                am.setCreateYn(createYns != null && createYns.size() > i ? createYns.get(i) : "N");
                am.setUpdateYn(updateYns != null && updateYns.size() > i ? updateYns.get(i) : "N");
                am.setDeleteYn(deleteYns != null && deleteYns.size() > i ? deleteYns.get(i) : "N");
                am.setApproveYn(approveYns != null && approveYns.size() > i ? approveYns.get(i) : "N");
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

        // 1. DTO 생성 및 요청 파라미터 설정
        AuthorityMenuDTO am = new AuthorityMenuDTO();
        am.setAuthorityId(authorityId);
        am.setMenuId(menuId);
        am.setReadYn(readYn);
        am.setCreateYn(createYn);
        am.setUpdateYn(updateYn);
        am.setDeleteYn(deleteYn);
        am.setApproveYn(approveYn);

        // 2. 💡 세션에서 수정자 ID(updatedId) 설정
        // 수정필요...
        AccountDTO authUser = (AccountDTO) session.getAttribute("authUser"); 
        
        Long updatedId;
        if (authUser != null) {
            updatedId = authUser.getAccountId(); 
        } else {
            //..
            updatedId = 0L; 
        }

        am.setUpdatedId(updatedId); // DTO에 수정자 ID 설정

        // 3. Service 호출
        authorityService.updateAuthorityMenu(am);

        return "redirect:/authority/detail/" + authorityId;
    }
    
    
    // 권한-메뉴 삭제 (단일)
    @PostMapping("/deleteMenu")
    public String deleteAuthorityMenu(@RequestParam Long authorityId, @RequestParam Long menuId) {
        authorityService.deleteAuthorityMenu(authorityId, menuId);
        return "redirect:/authority/detail/" + authorityId;
    }
}
