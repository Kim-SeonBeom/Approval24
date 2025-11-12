package com.example.approval24.controller;

import com.example.approval24.domain.AccountDTO;
import com.example.approval24.domain.BookmarkDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.service.BookmarkService;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.DeptService;
import lombok.RequiredArgsConstructor;
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
@RequiredArgsConstructor
public class BookmarkController {

    private final BookmarkService bookmarkService;
    private final AccountService accountService;
    private final DeptService deptService;

    /** 북마크 목록 페이지 */
    @GetMapping("/list")
    public String list(Model model,HttpSession session) {
        Long id = (Long) session.getAttribute("user");
        List<BookmarkDTO> bookmarks = bookmarkService.findByAccountId(id);
        model.addAttribute("bookmarks", bookmarks);
        return "D/bookMarkList"; 
    }

    /** 북마크 상세 (결재자 목록 포함) */
    @GetMapping("/{bookmarkId}")
    public String detail(@PathVariable Long bookmarkId, HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("user");
        Long instId = accountService.findInstIdByAccountId(userId);

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

    /** 북마크 등록 페이지 이동 */
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


    /** 북마크 이름 수정 또는 논리적 삭제 처리 */
    @PostMapping("/update")
    public String update(@RequestParam Map<String, Object> params) {
        Long bookmarkId = Long.parseLong(params.get("bookmarkId").toString());
        
        // 1. 논리적 삭제 처리 (delYn 파라미터가 있을 경우)
        if (params.containsKey("delYn") && "Y".equalsIgnoreCase((String) params.get("delYn"))) {
            bookmarkService.deleteBookmark(bookmarkId);
            return "redirect:/bookmark/list";
        }
        
        // 2. 이름 수정 처리 (bookmarkName 파라미터가 있을 경우)
        if (params.containsKey("bookmarkName") && !((String) params.get("bookmarkName")).isEmpty()) {
            String newName = (String) params.get("bookmarkName");
            bookmarkService.updateBookmarkName(bookmarkId, newName);
            return "redirect:/bookmark/" + bookmarkId; 
        }
        
        return "redirect:/bookmark/list";
    }

   
    
    /** 특정 북마크 내 결재자 목록 전체 교체 처리 (기존 updateApprover 대체) */
    @PostMapping("/approver/replace") // 엔드포인트 이름을 명확하게 변경 권장 (기존 /approver/update 유지도 가능)
    public String replaceApprovers(@ModelAttribute BookmarkDTO bookmark, Model model) {
        // 클라이언트에서 BookmarkDTO 형태로 데이터(bookmarkId, approvers 리스트)를 전송한다고 가정
        Long bookmarkId = bookmark.getBookmarkId();
        
        if (bookmarkId == null) {
             model.addAttribute("error","북마크 ID가 누락되었습니다.");
             return "common/errorPage";
        }

        try {
            bookmarkService.replaceApprovers(bookmarkId, bookmark.getApprovers());
           
            return "redirect:/bookmark/" + bookmarkId;
            
        } catch (Exception e) {
            // DB 오류 등이 발생한 경우 에러 페이지 처리
            model.addAttribute("error", "결재자 목록 교체 중 오류 발생: " + e.getMessage());
            return "common/errorPage";
        }
    }

}
