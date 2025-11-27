package com.example.approval24.controller;

import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.BookmarkDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.service.BookmarkService;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.DeptService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/bookmark")
public class BookmarkController {

	@Autowired
    private BookmarkService bookmarkService;
	
	@Autowired
    private AccountService accountService;
	
	@Autowired
    private DeptService deptService;
    
    @GetMapping("")
    public String Defalt(Model model) {
    	model.asMap().remove("logininstName");
        model.asMap().remove("loginuserName");
        model.asMap().remove("logindeptName");
    	return "redirect:/bookmark/list";
    }

    // 북마크 목록 페이지 
    @GetMapping("/list")
    public String list(Model model,HttpSession session) {
        Long id = (Long) session.getAttribute("user");
        List<BookmarkDTO> bookmarks = bookmarkService.findByAccountId(id);
        model.addAttribute("bookmarks", bookmarks);
        return "D/bookMarkList"; 
    }

    // 북마크 상세 (결재자 목록 포함)
    @GetMapping("/{bookmarkId}")
    public String detail(@PathVariable Long bookmarkId, HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("user");
        Long instId = accountService.findInstIdByAccountId(userId);
        List<DeptInstDTO> depts= deptService.deptByInst(instId);
        model.addAttribute("depts", depts);

        BookmarkDTO bookmark = bookmarkService.findById(bookmarkId);

        for (BookmarkDTO.Approver appr : bookmark.getApprovers()) {
            Long approverId = appr.getApproverId();
            Map<String, Object> filter = new HashMap<>();
            filter.put("accountId", approverId);
            filter.put("instId", instId);
            filter.put("accountStatus", "B002");

            List<AccountDTO> accounts = accountService.getAccountsByFilter(filter);
            if (!accounts.isEmpty()) {
                AccountDTO acc = accounts.get(0);
                appr.setApproverName(acc.getUserName());
                appr.setDeptName(acc.getDeptName());
            }
        }
        model.addAttribute("bookmark", bookmark);
        return "D/bookMarkDetail";
    }

    // 북마크 등록
    @GetMapping("/create")
    public String createForm(Model model,HttpSession session) {
        Long userId = (Long) session.getAttribute("user");
        Long instId = accountService.findInstIdByAccountId(userId);
    	List<DeptInstDTO> depts= deptService.deptByInst(instId);
        model.addAttribute("depts", depts);
        return "D/bookMarkForm";
    }

    //부서 선택 시 계정 목록
    @PostMapping("/accounts")
    @ResponseBody
    public List<AccountDTO> getAccountsByDept(
            @RequestParam("deptId") Long deptId,
            HttpSession session) {

        Long userId = (Long) session.getAttribute("user");
        Long instId = accountService.findInstIdByAccountId(userId);

        Map<String, Object> filter = new HashMap<>();
        filter.put("instId", instId);
        filter.put("deptId", deptId);
        filter.put("accountStatus", "B002");
        return accountService.getAccountsByFilter(filter);
    }    
    
    
    @PostMapping("/create")
    public String create(@ModelAttribute BookmarkDTO bookmark, HttpSession session, RedirectAttributes redirectAttrs) {
        Long userId = (Long) session.getAttribute("user");
        if (userId == null) {
            redirectAttrs.addFlashAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        bookmark.setAccountId(userId);

        try {
            bookmarkService.insertBookmark(bookmark);
        } catch (IllegalArgumentException e) {
            redirectAttrs.addFlashAttribute("errorMsg", e.getMessage());
            return "redirect:/bookmark/create"; 
        }

        return "redirect:/bookmark/list";
    }

 
    @PostMapping("/update")
    @ResponseBody 
    public Map<String, Object> updateBookmark(@RequestBody BookmarkDTO bookmark, HttpSession session) {

        Map<String, Object> response = new HashMap<>();
        Long bookmarkId = bookmark.getBookmarkId();

        if (bookmarkId == null) {
            response.put("result", "FAIL");
            response.put("message", "북마크 ID가 누락되었습니다.");
            return response;
        }

        Long userId = (Long) session.getAttribute("user");
        if (userId != null) {
            bookmark.setAccountId(userId);
        }
        
        try {
            // 삭제 요청 처리
            if ("Y".equalsIgnoreCase(bookmark.getDelYn())) {
                bookmarkService.deleteBookmark(bookmarkId);
                response.put("result", "SUCCESS");
                response.put("message", "북마크가 성공적으로 삭제되었습니다.");
                return response;
            }

            // 결재선 최소 인원 검증 (수정 요청일 경우만)
            if (bookmark.getApprovers() == null || bookmark.getApprovers().size() < 3) {
                response.put("result", "FAIL");
                response.put("message", "결재선은 최소 3명 이상 지정해야 합니다.");
                return response;
            }
            
            // 이름 수정 및/또는 결재선 교체 통합 서비스 호출
            int result = bookmarkService.updateBookmark(bookmark);

            if (result > 0) {
                response.put("result", "SUCCESS");
                response.put("message", "북마크가 성공적으로 수정되었습니다.");
                // 리다이렉트는 클라이언트(JSP)에서 처리하도록 메시지만 반환
                return response;
            } else {
                response.put("result", "FAIL");
                response.put("message", "북마크 정보를 수정할 수 없습니다. 변경 사항을 확인해 주세요.");
                return response;
            }

        } catch (Exception e) {
            
            response.put("result", "FAIL");
            response.put("message", "북마크 수정 중 시스템 오류 발생: " + e.getMessage());
            return response;
        }
    }
}
