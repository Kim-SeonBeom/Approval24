package com.example.approval24.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.BookmarkDAO;
import com.example.approval24.domain.BookmarkDTO;
import com.example.approval24.domain.BookmarkDTO.Approver;


@Service
public class BookmarkService {

	@Autowired
    private BookmarkDAO bookmarkDAO;

    // 계정별 전체 북마크 조회
    public List<BookmarkDTO> findByAccountId(Long accountId) {
        return bookmarkDAO.findByAccountId(accountId);
    }

    // 단일 북마크 조회 
    public BookmarkDTO findById(Long bookmarkId) {
        return bookmarkDAO.findById(bookmarkId);
    }

    // 북마크 등록 
    @Transactional
    public int insertBookmark(BookmarkDTO bookmark) {
        if (bookmark == null) {
            throw new IllegalArgumentException("북마크 정보가 null입니다.");
        }

        List<Approver> approvers = bookmark.getApprovers();
        Long accountId = bookmark.getAccountId();

        if (approvers == null || approvers.size() <= 2) {
            throw new IllegalArgumentException("결재선은 최소 3명 이상 지정해야 합니다.");
        }
        
        // 북마크 메인 정보 삽입
        int mainResult = bookmarkDAO.insertBookmark(bookmark);
        
        if (mainResult > 0) {
            Long generatedBookmarkId = bookmark.getBookmarkId();
            Long seqNo = (long) 1;
            
            for (int i = 0; i < approvers.size(); i++) {
                Approver approver = approvers.get(i);
                
                if (approver == null) {
                	throw new IllegalArgumentException("결재선 리스트에 null 객체가 포함되어 있습니다. (순서: " + (i+1) + ")");
                }
                
                approver.setBookmarkId(generatedBookmarkId);
                approver.setSeqNo(seqNo++);
                
                // 결재선 타입 지정
                if (i == 0) {
                    approver.setApproverTypeCd("F002");    // 첫 번째 (기안자/시작)
                    if(accountId.equals(approver.getApproverId())) {
                    	throw new IllegalArgumentException("첫번째는 본인 계정을 등록해야 합니다");
                    }
                } else if (i == (approvers.size() -1)) {
                    approver.setApproverTypeCd("F004");    // 마지막 (최종 결재자)
                } else {
                    approver.setApproverTypeCd("F003");    // 중간 (중간 결재자)
                }
            }
            
            // 결재선 정보 일괄 삽입
            bookmarkDAO.insertApprovers(bookmark.getApprovers()); 
        }

        return mainResult;
    }

// --- 수정/삭제/교체 ---
    
    // 북마크 이름만 수정 
    @Transactional
    public int updateBookmarkName(Long bookmarkId, String newName) {
        if (newName == null || newName.isEmpty()) {
             return 0;
        }
        Map<String, Object> params = new HashMap<>();
        params.put("bookmarkId", bookmarkId);
        params.put("bookmarkName", newName);
        
        return bookmarkDAO.updateBookmark(params);
    }

    // 북마크 논리적 삭제
    @Transactional
    public int deleteBookmark(Long bookmarkId) {
        Map<String, Object> params = new HashMap<>();
        params.put("bookmarkId", bookmarkId);
        params.put("delYn", "Y"); // 논리적 삭제
        
        return bookmarkDAO.updateBookmark(params);
    }

    // 특정 북마크의 결재자 목록 전체 교체 
    @Transactional
    public int replaceApprovers(Long bookmarkId, List<Approver> newApprovers) {
        if (bookmarkId == null) {
            return 0;
        }
        
        Long seqNo = (long) 1;
        bookmarkDAO.deleteApproversByBookmarkId(bookmarkId);
        
        if (newApprovers != null && !newApprovers.isEmpty()) {
            for (Approver approver : newApprovers) {
                approver.setBookmarkId(bookmarkId);
                approver.setSeqNo(seqNo);
            }
            bookmarkDAO.insertApprovers(newApprovers);
        }
        
        Map<String, Object> params = new HashMap<>();
        params.put("bookmarkId", bookmarkId);
        return bookmarkDAO.updateBookmark(params);
    }
    
    /** (선택적) 개별 결재자 속성 수정 - 기존 updateApprover와 동일 
    @Transactional
    public int updateApproverAttribute(Map<String, Object> params) {
        return bookmarkDAO.updateApprover(params);
    }
    */
}
