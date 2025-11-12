package com.example.approval24.controller.active;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.ui.Model;

import com.example.approval24.dao.InstDAO;
import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.InstDTO;
import com.example.approval24.service.AccountService;

@ControllerAdvice
public class UserInfoControllerAdvice {

    @Autowired
    private AccountService accountService;
    
    @Autowired
    private InstDAO instDAO;

    @ModelAttribute
    public void addLoginUserInfo(HttpSession session, Model model) {
        Object userObj = session.getAttribute("user");
        if (userObj == null) return;

        Long userId;
        try {
            userId = Long.valueOf(String.valueOf(userObj));
        } catch (NumberFormatException e) {
            return;
        }

        Map<String, Object> filterMap = new HashMap<>();
        filterMap.put("accountId", userId);

        List<AccountDTO> dtoList = accountService.getAccountsByFilter(filterMap);
        if (dtoList == null || dtoList.isEmpty()) return;

        AccountDTO userInfo = dtoList.get(0);
        if (!userId.equals(userInfo.getAccountId())) return;

        InstDTO instDTO = instDAO.getInstById(userInfo.getInstId());
        if (instDTO != null) {
            model.addAttribute("logininstName", instDTO.getInstName());
        }
        model.addAttribute("loginuserName", userInfo.getUserName());
        model.addAttribute("logindeptName", userInfo.getDeptName());
    }

}
