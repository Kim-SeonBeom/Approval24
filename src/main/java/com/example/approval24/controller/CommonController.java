package com.example.approval24.controller;

import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.InstDTO;
import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.domain.UserDTO;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.BookmarkService;
import com.example.approval24.service.DeptService;
import com.example.approval24.service.TotalCodeService;
import com.example.approval24.service.UserService;
import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.BookmarkDTO;

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
	@Autowired
	private BookmarkService bookmarkService;
	
	// 기관 전체 목록
	@GetMapping("/insts")
	public ResponseEntity<List<InstDTO>> getInstitutions(){
		return ResponseEntity.ok(deptServie.getAllInst());
	}

    //기관에 대한 부서 목록
    @GetMapping("/depts")
    public ResponseEntity<List<DeptInstDTO>> getDepartmentList(HttpSession session) {
        Long userId = (Long) session.getAttribute("user");

        System.out.println(userId);
        if (userId == null) {
            return ResponseEntity.status(401).build(); 
        }
        
        Long instId = accountService.findInstIdByAccountId(userId);
        
        System.out.println(instId);
        
        if (instId == null) {
             return ResponseEntity.status(404).build();
        }
        
        List<DeptInstDTO> deptList = deptServie.deptByInst(instId);

        return ResponseEntity.ok(deptList);
    }

    //부서에 속한 계정 목록
    @GetMapping("/accounts")
    public ResponseEntity<List<AccountDTO>> getAccountList(@RequestParam(value = "deptId", required = false) String deptIdStr,
    		HttpSession session) {
        
        Long userId = (Long) session.getAttribute("user");
        if (userId == null) {
            return ResponseEntity.status(401).build(); 
        }
        
        Long instId = accountService.findInstIdByAccountId(userId);
        if (instId == null) {
            return ResponseEntity.status(404).build(); 
        }
        
        Long deptId = null;
        
        if (deptIdStr == null || deptIdStr.trim().isEmpty()) {   
            try {
                deptId = accountService.findDeptIdByAccountId(userId);
            } catch (Exception e) {
                return ResponseEntity.status(500).build(); 
            }
            
            if (deptId == null) {
                 return ResponseEntity.status(400).body(null); 
            }
            
        } else {
            try {
                deptId = Long.valueOf(deptIdStr); 
            } catch (NumberFormatException e) {
                return ResponseEntity.status(400).body(null); 
            }
        }
        
        Map<String, Object> filterMap = new HashMap<>();
        filterMap.put("instId", instId);
        filterMap.put("deptId", deptId); 
        filterMap.put("accountStatus", "B002"); 
        
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
    
    @GetMapping("/bookmark/list")
    public ResponseEntity<List<BookmarkDTO>> getBookmarkList(HttpSession session) {
        

		Long userId = (Long) session.getAttribute("user");
        if (userId == null) {
            return ResponseEntity.status(401).build(); 
        }
        
        List<BookmarkDTO> bookmarkList = bookmarkService.findByAccountId(userId);
        
        return ResponseEntity.ok(bookmarkList);
    }
}