<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <%@ include file="/WEB-INF/views/common/navbar.jsp"%>
            <!-- End of Topbar -->

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <h1 class="h3 mb-2 text-gray-800">메뉴 관리</h1>
                <br>

                <!-- DataTales Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">전체 메뉴 목록</h6>
                        <button class="btn btn-primary btn-sm" id="menuCreate" style="font-size: 1rem; padding: 0.25rem 0.75rem;">+ 메뉴 등록</button>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>메뉴ID</th>
                                        <th>메뉴명</th>
                                        <th>URL</th>
                                        <th>부모메뉴ID</th>
                                        <th>SEQ</th>
                                        <th>관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="menu" items="${menus}">
                                        <tr>
                                            <td>${menu.menuId}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/menu/detail/${menu.menuId}">
                                                    ${menu.menuName}
                                                </a>
                                            </td>
                                            <td>${menu.menuUrl}</td>
                                            <td>${menu.parentMenuId}</td>
                                            <td>${menu.seq}</td>
                                            <td>
                                                <a class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/menu/edit/${menu.menuId}">수정</a>
                                                <form action="${pageContext.request.contextPath}/menu/delete/${menu.menuId}" method="post" style="display:inline">
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
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->

        <!-- Footer -->
        <%@ include file="/WEB-INF/views/common/footer.jsp"%>
        <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

<!-- Logout Modal-->
<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

<script>
    // 메뉴 등록 버튼 클릭 시 이동
    $("#menuCreate").on('click', function() {
        window.location.href='${pageContext.request.contextPath}/menu/create';
    });
</script>

</body>
</html>
