<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>북마크 목록</title>
<style>
    table, th, td { border: 1px solid #ccc; border-collapse: collapse; padding: 8px; text-align: center; }
    a.bookmark-link { text-decoration: none; color: #007bff; font-weight: 500; }
    a.bookmark-link:hover { text-decoration: underline; }
</style>
</head>
<body id="page-top">
<div id="wrapper">

    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">

            <%@ include file="/WEB-INF/views/common/navbar.jsp"%>

            <div class="container-fluid">

                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">북마크 목록</h6>
                        <a href="/approval24/bookmark/create">
                            <button class="btn btn-primary">새 북마크 등록</button>
                        </a>
                    </div>

                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>북마크 이름</th>
                                        <th>결재자 요약</th>
                                        <th>생성일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty bookmarks}">
                                            <c:forEach var="bm" items="${bookmarks}" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>
                                                        <a href="/approval24/bookmark/${bm.bookmarkId}" class="bookmark-link">
                                                            ${bm.bookmarkName}
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty bm.approvers}">
                                                                <c:forEach var="ap" items="${bm.approvers}" varStatus="i">
                                                                    ${ap.approverName}<c:if test="${!i.last}"> → </c:if>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>-</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td><fmt:formatDate value="${bm.createDt}" pattern="MM/dd"/></td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="4">등록된 북마크가 없습니다.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div><!-- /.container-fluid -->
        </div><!-- End of Main Content -->

        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>행정 &copy; 결재24 2025</span>
                </div>
            </div>
        </footer>
    </div><!-- End of Content Wrapper -->
</div><!-- End of Page Wrapper -->

<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
