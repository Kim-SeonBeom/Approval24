package com.example.approval24.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.example.approval24.domain.BookmarkDTO;
import com.example.approval24.domain.BookmarkDTO.Approver;

@Mapper
public interface BookmarkDAO {
    List<BookmarkDTO.Approver> selectApproversByBookmarkId(@Param("bookmarkId") long bookmarkId);

    List<BookmarkDTO> findByAccountId(@Param("accountId") long accountId);

    BookmarkDTO findById(@Param("bookmarkId") long bookmarkId);

    int insertBookmark(BookmarkDTO bookmarkDTO);

    int updateBookmark(Map<String, Object> params);

    int updateApprover(Map<String, Object> params);

    int insertApprovers(List<BookmarkDTO.Approver> list);

    int deleteApproversByBookmarkId(@Param("bookmarkId") long bookmarkId);
}
