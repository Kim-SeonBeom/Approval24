package com.example.approval24.controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.approval24.domain.MenuDTO;
import com.example.approval24.domain.PageInfoVO;
import com.example.approval24.service.MenuService;

@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;
    
    @GetMapping("")
    public String Defalt(Model model) {
    	model.asMap().remove("logininstName");
        model.asMap().remove("loginuserName");
        model.asMap().remove("logindeptName");
    	return "redirect:/menu/list";
    }

    // 전체 메뉴 목록 조회
    @GetMapping("/list")
    public String listMenus(Model model,
    		@RequestParam Map<String, Object> filterMap, 
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {
		
        int totalCount = menuService.findCountByFilter(filterMap); 
        PageInfoVO pageInfo = new PageInfoVO(page, pageSize, totalCount);
        filterMap.put("startRow", pageInfo.getStartRow());
        filterMap.put("endRow",pageInfo.getEndRow()); 
        
        //filterMap 
        List<MenuDTO> menus = menuService.findfilterMenu(filterMap);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("menus", menus);
        return "A/menuList"; 
    }

    // 메뉴 상세 조회
    @GetMapping("/detail/{menuId}")
    public String menuDetail(@PathVariable Long menuId, Model model) {
        MenuDTO menu = menuService.getMenuById(menuId);
        model.addAttribute("menu", menu);
        return "A/menuDetail"; 
    }

    // 메뉴 등록 폼 이동
    @GetMapping("/create")
    public String createForm(Model model) {
    	List<MenuDTO> parentMenus = menuService.getAllMenus(); 
        model.addAttribute("parentMenus", parentMenus);
        model.addAttribute("menu", new MenuDTO()); 
        return "A/menuForm";
    }

    // 메뉴 등록 처리
    @PostMapping("/create")
    public String createMenu(@ModelAttribute MenuDTO menu) {
        menuService.createMenu(menu);
        return "redirect:/menu/list";
    }

    // 메뉴 수정 폼 이동
    @GetMapping("/edit/{menuId}")
    public String editForm(@PathVariable Long menuId, Model model) {
    	MenuDTO menu = menuService.getMenuById(menuId);
        List<MenuDTO> parentMenus = menuService.getAllMenus();
        model.addAttribute("menu", menu);
        model.addAttribute("parentMenus", parentMenus);
        return "A/menuForm"; 
    }

    // 6️⃣ 메뉴 수정 처리
    @PostMapping("/edit")
    public String updateMenu(@ModelAttribute MenuDTO menu) {
        menuService.updateMenu(menu);
        return "redirect:/menu/list";
    }

    // 7️⃣ 메뉴 삭제 처리
    @PostMapping("/delete/{menuId}")
    public String deleteMenu(@PathVariable Long menuId) {
        menuService.deleteMenu(menuId);
        return "redirect:/menu/list";
    }
}
