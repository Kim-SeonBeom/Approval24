<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<body id="page-top">

<div id="wrapper">
    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="/WEB-INF/views/common/navbar.jsp"%>

            <div class="container-fluid">
                <h1 class="h3 mb-2 text-gray-800">메뉴 상세보기</h1>
                <br>

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">${menu.menuName}</h6>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>부모 메뉴</th>
                                <td>
                                    <%-- 💡 수정: 부모 메뉴 ID 대신 Name 표시 --%>
                                    <c:choose>
                                        <c:when test="${menu.parentMenuName != null}">
                                            ${menu.parentMenuName} (${menu.parentMenuId})
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-secondary">최상위 메뉴</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th>생성일</th>
                                <td>${menu.createDt}</td>
                            </tr>
                            <tr>
                                <th>수정일</th>
                                <td>${menu.updateDt}</td>
                            </tr>
                        </table>

                        <br>
                        <%-- 🚨 경로 수정: 405 에러 방지를 위해 경로 변수 방식 사용 --%>
                        <a href="${pageContext.request.contextPath}/menu/edit/${menu.menuId}" class="btn btn-warning btn-sm">수정</a>
                        
                        <a href="${pageContext.request.contextPath}/menu/list" class="btn btn-secondary btn-sm">목록</a>
                    </div>
                </div>

            </div>
        </div>
        <%@ include file="/WEB-INF/views/common/footer.jsp"%>
    </div>
</div>
</body>
</html>