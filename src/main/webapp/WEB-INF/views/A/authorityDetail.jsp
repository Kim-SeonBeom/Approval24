<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>권한 상세 및 메뉴/부서 관리</title>
    <style>
        .permission-table input[type="checkbox"] { transform: scale(1.2); }
        h2 { margin-top: 30px; border-bottom: 2px solid #ccc; padding-bottom: 5px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
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

    <h2>✅ 할당된 메뉴 목록 관리</h2>
    <table class="permission-table">
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
                <th>제거</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="am" items="${authorityMenus}">
                <tr>
                    <td>${am.menuId}</td>
                    <td>${am.menuName}</td>
                    <form action="<c:url value='/authority/updateMenu'/>" method="post" style="display:contents;">
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
                        <form action="<c:url value='/authority/deleteMenu'/>" method="post" style="display:inline;">
                            <input type="hidden" name="authorityId" value="${authority.authorityId}">
                            <input type="hidden" name="menuId" value="${am.menuId}">
                            <input type="submit" value="제거" onclick="return confirm('${am.menuName} 메뉴를 제거하시겠습니까?');">
                        </form>
                    </td>
                </tr>
            </c:forEach>
             <c:if test="${empty authorityMenus}">
                <tr>
                    <td colspan="9" style="text-align: center;">이 권한에 할당된 메뉴가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
    
    <h3>➕ 미할당 메뉴 등록</h3>
    <c:if test="${empty unassignedMenus}">
        <p>새로 할당할 수 있는 메뉴가 없습니다.</p>
    </c:if>
    <c:if test="${not empty unassignedMenus}">
        <form action="<c:url value='/authority/addMenus'/>" method="post">
            <input type="hidden" name="authorityId" value="${authority.authorityId}">
            
            <table class="permission-table">
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
                    <c:forEach var="menu" items="${unassignedMenus}">
                        <tr>
                            <td><input type="checkbox" name="menuIds" value="${menu.menuId}"></td>
                            <td>${menu.menuId}</td>
                            <td>${menu.menuName}</td>
                            <td><input type="checkbox" name="readYn_${menu.menuId}" value="Y"></td>
                            <td><input type="checkbox" name="createYn_${menu.menuId}" value="Y"></td>
                            <td><input type="checkbox" name="updateYn_${menu.menuId}" value="Y"></td>
                            <td><input type="checkbox" name="deleteYn_${menu.menuId}" value="Y"></td>
                            <td><input type="checkbox" name="approveYn_${menu.menuId}" value="Y"></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <br>
            <button type="submit" onclick="return confirm('선택한 메뉴들을 권한에 할당하시겠습니까?');">선택 메뉴 일괄 등록</button>
        </form>
    </c:if>
    
    <hr>
    
    <h2>🏢 할당된 부서 목록 관리</h2>
    <table border="1">
        <thead>
            <tr>
                <th>부서 ID</th>
                <th>부서명</th>
                <th>제거</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="ad" items="${authorityDepartments}">
                <tr>
                    <td>${ad.deptId}</td>
                    <td>${ad.deptName}</td>
                    <td>
                        <form action="<c:url value='/authority/removeDepartment'/>" method="post" style="display:inline;">
                            <input type="hidden" name="authorityId" value="${authority.authorityId}">
                            <input type="hidden" name="deptId" value="${ad.deptId}">
                            <input type="submit" value="제거" onclick="return confirm('${ad.deptName} 부서에서 이 권한을 제거하시겠습니까?');">
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty authorityDepartments}">
                <tr>
                    <td colspan="3" style="text-align: center;">이 권한이 할당된 부서가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <h3>➕ 미할당 부서 등록</h3>
    <c:if test="${empty unassignedDepartments}">
        <p>새로 할당할 수 있는 부서가 없습니다.</p>
    </c:if>
    <c:if test="${not empty unassignedDepartments}">
        <form action="<c:url value='/authority/addDepartments'/>" method="post">
            <input type="hidden" name="authorityId" value="${authority.authorityId}">
            
            <table border="1">
                <thead>
                    <tr>
                        <th>선택</th>
                        <th>부서 ID</th>
                        <th>부서명</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dept" items="${unassignedDepartments}">
                        <tr>
                            <td><input type="checkbox" name="deptIds" value="${dept.deptId}"></td>
                            <td>${dept.deptId}</td>
                            <td>${dept.deptName}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <br>
            <button type="submit" onclick="return confirm('선택한 부서들에 이 권한을 할당하시겠습니까?');">선택 부서 일괄 등록</button>
        </form>
    </c:if>

    <br>
    <button type="button" onclick="location.href='<c:url value="/authority/list"/>'">목록으로</button>
</body>
</html>