package com.example.approval24.controller;

import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.DeptService;
import com.example.approval24.service.TotalCodeService;
import com.example.approval24.domain.AccountDTO; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/common")
public class CommonController {

	@Autowired
	private AccountService accountService;
	@Autowired
	private DeptService deptServie;
	@Autowired
	private TotalCodeService codeService;

    //부서 목록
    @GetMapping("/depts")
    public ResponseEntity<List<DeptInstDTO>> getDepartmentList(HttpSession session) {
        Long userId = (Long) session.getAttribute("user");

        if (userId == null) {
            return ResponseEntity.status(401).build(); 
        }
        
        Long instId = accountService.findInstIdByAccountId(userId);
        
        if (instId == null) {
             return ResponseEntity.status(404).build();
        }
        
        List<DeptInstDTO> deptList = deptServie.deptByInst(instId);

        return ResponseEntity.ok(deptList);
    }

    //부서에 속한 계정 목록
    @GetMapping("/accounts")
    public ResponseEntity<List<AccountDTO>> getAccountList(@RequestParam("deptId") String deptIdStr,HttpSession session) {
        
        if (deptIdStr == null || deptIdStr.trim().isEmpty()) {
            return ResponseEntity.badRequest().build(); 
        }
        
        Long userId = (Long) session.getAttribute("user");

        if (userId == null) {
            return ResponseEntity.status(401).build(); 
        }
        
        Long instId = accountService.findInstIdByAccountId(userId);
        
        // instId를 못 찾았을 경우의 예외 처리 로직 (선택적)
        if (instId == null) {
             return ResponseEntity.status(404).build(); 
        }
        
        Long deptId;
        try {
            deptId = Long.valueOf(deptIdStr); 
        } catch (NumberFormatException e) {
            return ResponseEntity.status(400).body(null); 
        }
 
        Map<String, Object> filterMap = new HashMap<>();
        filterMap.put("instId", instId);
        filterMap.put("deptId", deptId);
        filterMap.put("accountStatus", "B0");
        
		List<AccountDTO> accountList = accountService.getAccountsByFilter(filterMap);

        return ResponseEntity.ok(accountList);
    }
    
    //필요한 코드 목록
    @GetMapping("/codes")
    public ResponseEntity<List<TotalCodeDTO>> getCodeList(@RequestParam("groupId") String groupId){
    	if (groupId == null || groupId.trim().isEmpty()) {
            return ResponseEntity.badRequest().build(); 
        }
		List<TotalCodeDTO> codeList = codeService.getTotalCodeByGroupId(groupId);
		return ResponseEntity.ok(codeList);
    }
}