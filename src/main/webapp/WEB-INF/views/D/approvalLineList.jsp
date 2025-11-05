<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 결재 이력 목록</title>
    </head>
<body>

<div class="container">
    <h2>📋 내 결재 이력 목록</h2>

    <div class="filter-form">
        <form action="${pageContext.request.contextPath}/ApprovalHistory/list" method="get">
            <input type="hidden" name="accountId" value="${sessionScope.user}">
            
            <label for="startDate">처리 시작일:</label>
            <input type="date" id="startDate" name="startDate" value="${filterMap.startDate}">
            
            <label for="endDate">처리 종료일:</label>
            <input type="date" id="endDate" name="endDate" value="${filterMap.endDate}">
            
            <label for="categoryCd">민원 서식:</label>
            <select id="categoryCd" name="categoryCd"> 
                <option value="">전체</option>
                <c:forEach var="code" items="${categoryCodeList}">
                    <option value="${code.codeId}" 
                            <c:if test="${filterMap.categoryCd eq code.codeId}">selected</c:if>>
                        ${code.codeName}
                    </option>
                </c:forEach>
            </select>
            
            <label for="statusCd">승인 상태:</label>
            <select id="statusCd" name="approvalStatusCd">
                <option value="">전체</option>
                <c:forEach var="code" items="${statusCodeList}">
                    <option value="${code.codeId}" 
                            <c:if test="${filterMap.approvalStatusCd eq code.codeId}">selected</c:if>>
                        ${code.codeName}
                    </option>
                </c:forEach>
            </select>
            
            <button type="submit">검색</button>
        </form>
    </div>

    <table>
        </table>
    
    </div>
</body>
</html>