<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 목록</title>
    <style>
        table, th, td { border: 1px solid black; border-collapse: collapse; padding: 8px; }
        .action-link { margin-left: 10px; }
    </style>
</head>
<body>
    <h1>북마크 목록 🔖</h1>
    <p><a href="/approval24/bookmark/create">새 북마크 등록</a></p>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>북마크 이름</th>
                <th>생성일</th>
                <th>수정일</th>
                <th>삭제여부</th>
                <th>상세 보기</th>
            </tr>
        </thead>
        <tbody>
            <%-- Controller에서 Model에 담아준 'bookmarks' 리스트를 출력합니다. --%>
            <c:forEach var="bm" items="${bookmarks}">
                <tr>
                    <td>${bm.bookmarkId}</td>
                    <td>${bm.bookmarkName}</td>
                    <td>${bm.createDt}</td>
                    <td>${bm.updateDt}</td>
                    <td>${bm.delYn}</td>
                    <td>
                        <%-- 상세 페이지 이동 링크 --%>
                        <a href="/bookmark/${bm.bookmarkId}">상세</a>
                        
                        <%-- 삭제 처리 (실제로는 update로 delYn을 'Y'로 변경) --%>
                        <form action="/bookmark/update" method="post" style="display:inline;" onsubmit="return confirm('정말로 삭제(비활성화)하시겠습니까?');">
                            <input type="hidden" name="bookmarkId" value="${bm.bookmarkId}">
                            <input type="hidden" name="delYn" value="Y">
                            <button type="submit" class="action-link">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <c:if test="${empty bookmarks}">
        <p>저장된 북마크가 없습니다.</p>
    </c:if>
</body>
</html>