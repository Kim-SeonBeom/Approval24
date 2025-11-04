package com.example.approval24.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.BookmarkDAO;
import com.example.approval24.domain.BookmarkDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookmarkService {

    private final BookmarkDAO bookmarkDAO;

    /** 계정별 전체 북마크 조회 */
    public List<BookmarkDTO> findByAccountId(Long accountId) {
        return bookmarkDAO.findByAccountId(accountId);
    }

    /** 단일 북마크 조회 (상세 결재자 포함) */
    public BookmarkDTO findById(Long bookmarkId) {
        return bookmarkDAO.findById(bookmarkId);
    }

    /** 북마크 등록 (상세 결재자 포함) */
    @Transactional
    public int insertBookmark(BookmarkDTO bookmark) {
        return bookmarkDAO.insertBookmark(bookmark);
    }

    /** 북마크 이름 수정 / 논리삭제 */
    @Transactional
    public int updateBookmark(Map<String, Object> params) {
        return bookmarkDAO.updateBookmark(params);
    }

    /** 특정 북마크 내 결재자 수정 */
    @Transactional
    public int updateApprover(Map<String, Object> params) {
        return bookmarkDAO.updateApprover(params);
    }
}
