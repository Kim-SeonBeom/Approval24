<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<body id="page-top">

<div id="wrapper">

    <!-- Sidebar -->
    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
    <!-- End of Sidebar -->

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">

            <!-- Topbar -->
            <%@ include file="/WEB-INF/views/common/navbar.jsp"%>
            <!-- End of Topbar -->

            <div class="container-fluid">
                <h1 class="h3 mb-2 text-gray-800">권한 관리</h1>
                <br>

                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">전체 권한 목록</h6>
                        <button class="btn btn-primary btn-sm" id="authorityCreate" style="font-size: 1rem; padding: 0.25rem 0.75rem;">+ 권한 등록</button>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>권한ID</th>
                                        <th>권한명</th>
                                        <th>생성일</th>
                                        <th>수정일</th>
                                        <th>시스템권한</th>
                                        <th>관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="auth" items="${authorities != null ? authorities : emptyList}">
                                        <tr>
                                            <td>${auth.authorityId}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/authority/detail/${auth.authorityId}">
                                                    ${auth.authorityName}
                                                </a>
                                            </td>
                                            <td>${auth.createDt}</td>
                                            <td>${auth.updateDt}</td>
                                            <td>${auth.isSystem}</td>
                                            <td>
                                                <a class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/authority/edit/${auth.authorityId}">수정</a>
                                                <form action="${pageContext.request.contextPath}/authority/delete/${auth.authorityId}" method="post" style="display:inline">
                                                    <button type="submit" class="btn btn-sm btn-danger">삭제</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp"%>
    </div>
</div>

<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

<script>
    $("#authorityCreate").on('click', function() {
        window.location.href="${pageContext.request.contextPath}/authority/create";
    });
</script>

</body>
</html>
