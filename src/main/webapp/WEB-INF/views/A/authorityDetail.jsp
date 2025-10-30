<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>권한 상세 및 메뉴 관리</title>
    <style>
        .permission-table input[type="checkbox"] { transform: scale(1.2); }
    </style>
</head>
<body>
    <h1>권한 상세: ${authority.authorityName} 📋</h1>

    <p>
        <strong>ID:</strong> ${authority.authorityId} <br>
        <strong>권한명:</strong> ${authority.authorityName}
        <%-- <strong>설명:</strong> ${authority.description} <br> --%>
    </p>

    <hr>

    <h2>✅ 할당된 메뉴 목록</h2>
    <table border="1" class="permission-table">
        <thead>
            <tr>
                <th>메뉴 ID</th>
                <th>메뉴명</th>
                <th>조회</th>
                <th>등록</th>
                <th>수정</th>
                <th>삭제</th>
                <th>승인</th>
                <th>업데이트</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="am" items="${authorityMenus}" varStatus="status">
                <c:url var="updateActionUrl" value="/authority/updateMenu"/>
                <c:url var="deleteActionUrl" value="/authority/deleteMenu"/>
                <tr>
                    <td>${am.menuId}</td>
                    <td>${am.menuName}</td>
                    <form action="${updateActionUrl}" method="post" id="updateForm_${am.menuId}" style="display:contents;">
                        <input type="hidden" name="authorityId" value="${authority.authorityId}">
                        <input type="hidden" name="menuId" value="${am.menuId}">
                        <td><input type="checkbox" name="readYn" value="Y" ${am.readYn == 'Y' ? 'checked' : ''}></td>
                        <td><input type="checkbox" name="createYn" value="Y" ${am.createYn == 'Y' ? 'checked' : ''}></td>
                        <td><input type="checkbox" name="updateYn" value="Y" ${am.updateYn == 'Y' ? 'checked' : ''}></td>
                        <td><input type="checkbox" name="deleteYn" value="Y" ${am.deleteYn == 'Y' ? 'checked' : ''}></td>
                        <td><input type="checkbox" name="approveYn" value="Y" ${am.approveYn == 'Y' ? 'checked' : ''}></td>
                        <td><button type="submit">변경</button></td>
                    </form>
                    <td>
                        <form action="${deleteActionUrl}" method="post" style="display:inline;">
                            <input type="hidden" name="authorityId" value="${authority.authorityId}">
                            <input type="hidden" name="menuId" value="${am.menuId}">
                            <input type="submit" value="삭제" onclick="return confirm('${am.menuName} 메뉴를 삭제하시겠습니까?');">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <hr>
    
    <h2>➕ 미할당 메뉴 등록</h2>
    <c:if test="${empty allMenus}">
        <p>새로 할당할 수 있는 메뉴가 없습니다.</p>
    </c:if>
    <c:if test="${not empty allMenus}">
        <form action="<c:url value='/authority/addMenus'/>" method="post">
            <input type="hidden" name="authorityId" value="${authority.authorityId}">
            
            <table border="1" class="permission-table">
                <thead>
                    <tr>
                        <th>선택</th>
                        <th>메뉴 ID</th>
                        <th>메뉴명</th>
                        <th>조회</th>
                        <th>등록</th>
                        <th>수정</th>
                        <th>삭제</th>
                        <th>승인</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="menu" items="${allMenus}" varStatus="status">
                        <tr>
                            <td>
                                <input type="checkbox" name="menuIds" value="${menu.menuId}">
                            </td>
                            <td>${menu.menuId}</td>
                            <td>${menu.menuName}</td>
                            <td><input type="checkbox" name="readYn" value="Y"></td>
                            <td><input type="checkbox" name="createYn" value="Y"></td>
                            <td><input type="checkbox" name="updateYn" value="Y"></td>
                            <td><input type="checkbox" name="deleteYn" value="Y"></td>
                            <td><input type="checkbox" name="approveYn" value="Y"></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <br>
            <button type="submit" onclick="return confirm('선택한 메뉴들을 권한에 할당하시겠습니까?');">선택 메뉴 일괄 등록</button>
        </form>
    </c:if>
    
    <br>
    <button type="button" onclick="location.href='<c:url value="/authority/list"/>'">목록으로</button>
</body>
</html>