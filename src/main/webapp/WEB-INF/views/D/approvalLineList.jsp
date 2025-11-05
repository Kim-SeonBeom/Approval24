<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>결재 이력</title>
</head>
<body>
    <h2>결재 이력 조회</h2>

    <!-- 검색 필터 -->
    <form method="get" action="/ApprovalHistory/list">
        <label>결재 상태:</label>
        <select name="approvalStatusCd">
            <option value="">전체</option>
            <c:forEach var="status" items="${statusCodeList}">
                <option value="${status.codeId}"
                    <c:if test="${filterMap.approvalStatusCd == status.codeId}">selected</c:if>>
                    ${status.codeName}
                </option>
            </c:forEach>
        </select>

        <label>결재 구분:</label>
        <select name="categoryCd">
            <option value="">전체</option>
            <c:forEach var="category" items="${categoryCodeList}">
                <option value="${category.codeId}"
                    <c:if test="${filterMap.categoryCd == category.codeId}">selected</c:if>>
                    ${category.codeName}
                </option>
            </c:forEach>
        </select>

        <button type="submit">검색</button>
    </form>

    <hr>

    <!-- 결재 이력 목록 -->
    <table border="1" cellspacing="0" cellpadding="5">
        <thead>
            <tr>
                <th>번호</th>
                <th>결재 구분</th>
                <th>결재 상태</th>
                <th>결재자 유형</th>
                <th>처리일자</th>
                <th>의견</th>
                <th>URL</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty historyList}">
                    <c:forEach var="item" items="${historyList}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${item.categoryName}</td>
                            <td>${item.approvalStatusName}</td>
                            <td>${item.approverTypeName}</td>
                            <td>
                                <fmt:formatDate value="${item.processDt}" pattern="yyyy-MM-dd HH:mm" />
                            </td>
                            <td>${item.approvalComment}</td>
                            <td>
                                <c:if test="${not empty item.url}">
                                    <a href="${item.url}" target="_blank">바로가기</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="7">조회된 결재 이력이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</body>
</html>
