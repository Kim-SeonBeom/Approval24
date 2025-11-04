package com.example.approval24.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.example.approval24.domain.BookmarkDTO;

@Mapper
public interface BookmarkDAO {

    // 계정별 전체 북마크 조회
    List<BookmarkDTO> findByAccountId(@Param("accountId") Long accountId);

    // 단일 북마크 조회 (상세 결재자 포함)
    BookmarkDTO findById(@Param("bookmarkId") Long bookmarkId);

    // 북마크 등록 (상세 결재자 리스트 포함)
    int insertBookmark(BookmarkDTO bookmark);

    // 북마크 이름 수정 / 삭제
    int updateBookmark(@Param("params") Map<String, Object> params);

    // 특정 북마크 내 결재자 수정
    int updateApprover(@Param("params") Map<String, Object> params);
}
