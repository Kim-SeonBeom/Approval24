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
                <h1 class="h3 mb-2 text-gray-800">메뉴 수정</h1>
                <br>

                <div class="card shadow mb-4">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/menu/edit" method="post">
                            <input type="hidden" name="menuId" value="${menu.menuId}" />

                            <div class="form-group">
                                <label for="menuName">메뉴명</label>
                                <input type="text" class="form-control" id="menuName" name="menuName" value="${menu.menuName}" required>
                            </div>

                            <div class="form-group">
                                <label for="menuUrl">URL</label>
                                <input type="text" class="form-control" id="menuUrl" name="menuUrl" value="${menu.menuUrl}">
                            </div>

                            <div class="form-group">
                                <label for="parentMenuId">부모 메뉴 ID</label>
                                <input type="text" class="form-control" id="parentMenuId" name="parentMenuId" value="${menu.parentMenuId}">
                            </div>

                            <div class="form-group">
                                <label for="seq">순서(SEQ)</label>
                                <input type="number" class="form-control" id="seq" name="seq" value="${menu.seq}">
                            </div>

                            <div class="form-group">
                                <label for="popupYn">팝업 여부</label>
                                <select class="form-control" id="popupYn" name="popupYn">
                                    <option value="Y" ${menu.popupYn == 'Y' ? 'selected' : ''}>Y</option>
                                    <option value="N" ${menu.popupYn == 'N' ? 'selected' : ''}>N</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">수정 완료</button>
                            <a href="${pageContext.request.contextPath}/menu/list" class="btn btn-secondary">취소</a>
                        </form>
                    </div>
                </div>

            </div>

        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp"%>
    </div>

</div>

<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

</body>
</html>
