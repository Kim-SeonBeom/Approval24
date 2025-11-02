package com.example.approval24.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.domain.UserDTO;
import com.example.approval24.service.TotalCodeService;
import com.example.approval24.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;
    
    @Autowired
    TotalCodeService codeService;

    // 사용자 목록 조회 
    @GetMapping("/list")
    public String listUsers(@ModelAttribute("filter") UserDTO filter, Model model) {
        List<UserDTO> users = userService.getUsers(filter);
        List<TotalCodeDTO> codes = codeService.getTotalCodeByGroupId("A0");
        
        model.addAttribute("users", users);   
        model.addAttribute("codes",codes);
        return "B/userList"; 
    }

    //사용자 상세 조회 
    @GetMapping("/detail/{userResidentNo}")
    public String detailUser(@PathVariable String userResidentNo, Model model, RedirectAttributes rttr) {
        UserDTO user = userService.getUserDetailByResidentNo(userResidentNo);
        if (user == null) {
            rttr.addFlashAttribute("errorMessage", "존재하지 않거나 삭제된 사용자입니다.");
            return "redirect:/user/list"; 
        }
        model.addAttribute("user", user);
        return "B/userDetail"; 
    }
    
    //사용자 등록
    @GetMapping("/create")
    public String createUserForm(Model model) {
        model.addAttribute("user", new UserDTO());
        List<TotalCodeDTO> codes = codeService.getTotalCodeByGroupId("A0");
        model.addAttribute("codes",codes);
        return "B/userForm";
    }

    //사용자 등록/재활성화
    @PostMapping("/create")
    public String registerUser(@ModelAttribute("user") UserDTO user, RedirectAttributes rttr, HttpSession session) {
        try {
            Long currentUserId = (Long)session.getAttribute("user");
            if(currentUserId == null) return "redirect:/login";
            user.setCreateId(currentUserId); 
            
            int result = userService.registerUser(user);

            if (result > 0) {
                rttr.addFlashAttribute("successMessage", "사용자가 성공적으로 등록되었습니다.");
            } else {
                rttr.addFlashAttribute("errorMessage", "사용자 등록에 실패했습니다.");
            }
        } catch (IllegalArgumentException e) {
            rttr.addFlashAttribute("errorMessage", e.getMessage()); 
            return "redirect:/user/create";
        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", "처리 중 예상치 못한 오류가 발생했습니다.");
        }

        return "redirect:/user/list";
    }
    
    // 사용자 수정
    @GetMapping("/edit/{userResidentNo}")
    public String editUserForm(@PathVariable String userResidentNo, Model model, RedirectAttributes rttr) {
        
        UserDTO user = userService.getUserDetailByResidentNo(userResidentNo);
        
        if (user == null) {
            rttr.addFlashAttribute("errorMessage", "존재하지 않거나 삭제된 사용자입니다.");
            return "redirect:/user/list"; 
        }

        List<TotalCodeDTO> codes = codeService.getTotalCodeByGroupId("A0");

        model.addAttribute("user", user); 
        model.addAttribute("codes", codes);
        
        return "B/userForm"; 
    }

    @PostMapping("/edit")
    public String updateUser(@ModelAttribute("user") UserDTO user, RedirectAttributes rttr,HttpSession session) {
        
        if (user.getUserNo() == null) {
            rttr.addFlashAttribute("errorMessage", "사용자 번호(PK)가 누락되어 수정할 수 없습니다.");
            return "redirect:/user/list";
        }
        
        try {
            Long currentUserId = (Long)session.getAttribute("user");
            if(currentUserId == null) return "redirect:/login";
            user.setUpdateId(currentUserId); 
            
            user.setDelYn("N"); 

            int result = userService.updateUserInfo(user);

            if (result > 0) {
                rttr.addFlashAttribute("successMessage", "사용자 정보가 성공적으로 수정되었습니다.");
                return "redirect:/user/detail/" + user.getUserResidentNo(); 
            } else {
                rttr.addFlashAttribute("errorMessage", "수정에 실패했습니다. 대상이 존재하지 않을 수 있습니다.");
            }
        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", "수정 처리 중 예상치 못한 오류가 발생했습니다.");
        }

        return "redirect:/user/list";
    }
    
    // 사용자 논리 삭제
    @PostMapping("/delete/{userNo}")
    public String deleteUser(@PathVariable Long userNo, RedirectAttributes rttr,HttpSession session) {
        try {
        	Long currentUserId = (Long)session.getAttribute("user");
            if(currentUserId == null) return "redirect:/login";
            
            int result = userService.deactivateUser(userNo,currentUserId);

            if (result > 0) {
                rttr.addFlashAttribute("successMessage", "사용자가 논리 삭제되었습니다.");
            } else {
                rttr.addFlashAttribute("errorMessage", "사용자 삭제에 실패했습니다. 대상이 존재하지 않습니다.");
            }
        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", "삭제 처리 중 오류가 발생했습니다.");
        }
        
        return "redirect:/user/list";
    }
}