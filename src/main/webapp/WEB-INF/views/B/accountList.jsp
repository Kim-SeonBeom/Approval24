<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정 목록</title>
<style>
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
    th { background-color: #f4f4f4; }
    form { margin-bottom: 20px; }
</style>
</head>
<body>

<h2>계정 목록</h2>

<!-- 필터 폼 -->
<form method="get" action="${pageContext.request.contextPath}/account/list">
    기관ID: <input type="text" name="instId" value="${param.instId}" required />
    로그인ID: <input type="text" name="loginId" value="${param.loginId}" />
    사용자명: <input type="text" name="userName" value="${param.userName}" />
    부서: <input type="text" name="deptId" value="${param.deptId}" />
    상태: 
    <select name="accountStatus">
        <option value="">전체</option>
        <c:forEach var="code" items="${statusCodes}">
            <option value="${code.codeId}" <c:if test="${param.accountStatus == code.codeId}">selected</c:if>>
                ${code.codeName}
            </option>
        </c:forEach>
    </select>
    <input type="submit" value="검색" />
</form>

<!-- 계정 테이블 -->
<table>
    <thead>
        <tr>
            <th>계정ID</th>
            <th>사용자명</th>
            <th>부서</th>
            <th>로그인ID</th>
            <th>상태</th>
            <th>생성일</th>
            <th>수정일</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="acc" items="${accounts}">
            <tr>
                <td>${acc.accountId}</td>
                <td>${acc.userName}</td>
                <td>${acc.deptName}</td>
                <td>${acc.loginId}</td>
                <td>${acc.accountStatusName}</td>
                <td>${acc.createDt}</td>
                <td>${acc.updateDt}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty accounts}">
            <tr>
                <td colspan="7" style="text-align:center;">조회된 계정이 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>

</body>
</html>
