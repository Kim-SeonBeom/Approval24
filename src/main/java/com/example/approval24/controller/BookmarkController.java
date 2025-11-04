package com.example.approval24.controller;

import com.example.approval24.domain.BookmarkDTO;
import com.example.approval24.service.BookmarkService;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.DeptService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
        return "C/bookMarkList"; 
    }

    /** 북마크 상세 (결재자 목록 포함) */
    @GetMapping("/{bookmarkId}")
    public String detail(@PathVariable Long bookmarkId, Model model) {
        // TODO: bookmarkService.findById(bookmarkId)
        // + accountService / deptService 로 이름·부서 정보 조합
        // model.addAttribute("bookmark", bookmark);
        return "bookmark/detail";
    }

    /** 북마크 등록 페이지 이동 */
    @GetMapping("/new")
    public String createForm(Model model) {
        // TODO: deptService / accountService 통해 부서·계정 목록 미리 로드
        // model.addAttribute("depts", ...);
        // model.addAttribute("accounts", ...);
        return "bookmark/form";
    }

    /** 북마크 등록 처리 */
    @PostMapping("/new")
    public String create(@ModelAttribute BookmarkDTO bookmark) {
        // TODO: bookmarkService.insertBookmark(bookmark);
        // return "redirect:/bookmark/list?accountId=" + bookmark.getAccountId();
        return null;
    }

    /** 북마크 수정 (이름 변경 or 논리삭제) */
    @PostMapping("/update")
    public String update(@RequestParam Map<String, Object> params) {
        // TODO: bookmarkService.updateBookmark(params);
        // return "redirect:/bookmark/list?accountId=" + params.get("accountId");
        return null;
    }

    /** 특정 북마크 내 결재자 수정 */
    @PostMapping("/approver/update")
    public String updateApprover(@RequestParam Map<String, Object> params) {
        // TODO: bookmarkService.updateApprover(params);
        // return "redirect:/bookmark/" + params.get("bookmarkId");
        return null;
    }
}
