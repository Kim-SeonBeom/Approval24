<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계정 목록</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f0f0f0; }
        select, input { padding: 4px; margin-right: 10px; }
        .filter { margin-bottom: 15px; }
    </style>
</head>
<body>
    <h2>계정 목록</h2>

    <!-- 검색 필터 -->
    <form method="get" action="list" class="filter" onsubmit="removeEmptyParams(this)">
        <label>로그인 ID: <input type="text" name="loginId" value="${param.loginId}"></label>
        <label>사용자 이름: <input type="text" name="userName" value="${param.userName}"></label>
        <label>부서:
    <select name="deptId">
        <option value="">전체</option>
        <c:forEach var="dept" items="${deptList}">
            <option value="${dept.deptId}" 
                <c:if test="${param.deptId eq dept.deptId}">selected</c:if>>
                ${dept.deptName}
            </option>
        </c:forEach>
    </select>
</label>

<label>계정 상태:
    <select name="accountStatus">
        <option value="">전체</option>
        <c:forEach var="status" items="${statusList}">
            <option value="${status.codeId}" 
                <c:if test="${param.accountStatus eq status.codeId}">selected</c:if>>
                ${status.codeName}
            </option>
        </c:forEach>
    </select>
</label>

        <label>시작일: <input type="date" name="startDate" value="${param.startDate}"></label>
        <label>종료일: <input type="date" name="endDate" value="${param.endDate}"></label>
        <button type="submit">검색</button>
    </form>

    <!-- 계정 목록 테이블 -->
    <table>
        <thead>
            <tr>
                <th>계정 ID</th>
                <th>사용자 이름</th>
                <th>로그인 ID</th>
                <th>부서</th>
                <th>계정 상태</th>
                <th>생성일</th>
                <th>수정일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="acc" items="${accounts}">
                <tr>
                    <td>${acc.accountId}</td>
                    <td>${acc.userName}</td>
                    <td>${acc.loginId}</td>
                    <td>${acc.deptName}</td>
                    <td>${acc.accountStatusName != null ? acc.accountStatusName : ''}</td>
                    <td>${acc.createDt}</td>
                    <td>${acc.updateDt}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty accounts}">
                <tr>
                    <td colspan="7" style="text-align:center;">조회 결과가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <script>
        function removeEmptyParams(form) {
            Array.from(form.elements).forEach(el => {
                if(el.value === '') el.disabled = true;
            });
        }
    </script>
</body>
</html>
