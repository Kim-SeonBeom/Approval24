<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <title>북마크 목록 | 결재24</title>
</head>

<body id="page-top">
    <c:set var="ctx" value="${pageContext.request.contextPath}" />

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
                    <div class="d-sm-flex align-items-center justify-content-between mb-3">
                        <h1 class="h3 mb-0 text-gray-800">북마크 목록</h1>
                    </div>
                    <br>


                    <!-- 알림 (필요 시 플래시 메시지 사용) -->
                    <c:if test="${not empty insertMessage}">
                        <div class="alert alert-info alert-dismissible fade show" role="alert">
                            ${insertMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    <c:if test="${not empty delMessage}">
                        <div class="alert alert-info alert-dismissible fade show" role="alert">
                            ${delMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <!-- 북마크 테이블 -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex align-items-center">
						    <h6 class="m-0 font-weight-bold text-primary">북마크 테이블</h6>
						    <a href="${ctx}/bookmark/create" class="btn btn-primary btn-sm ml-auto">
						        <i class="fas fa-plus mr-1"></i> 새 북마크 등록
						    </a>
						</div>

                        <div class="card-body">
                            <div class="table-responsive">
                                <!-- DataTables 사용 시 id="dataTable" 그대로 사용 -->
                                <table class="table table-bordered" id="dataTable" style="width:100%" cellspacing="0">
								    <thead>
								        <tr>
								            <th>ID</th>
								            <th>북마크 이름</th>
								            <th>생성일</th>
								            <th>수정일</th>
								            <th>삭제여부</th>
								            <th>상세 / 삭제</th>
								        </tr>
								    </thead>
								    <tbody>
								        <%-- Controller에서 Model에 담아준 'bookmarks' 리스트 출력 --%>
								        <c:forEach var="bm" items="${bookmarks}">
								            <tr>
								                <td><c:out value="${bm.bookmarkId}"/></td>
								                <td><c:out value="${bm.bookmarkName}"/></td>
								                <td><c:out value="${bm.createDt}"/></td>
								                <td><c:out value="${bm.updateDt}"/></td>
								                <td><c:out value="${bm.delYn}"/></td>
								                <td>
								                    <!-- 상세 페이지 이동 -->
								                    <a href="${ctx}/bookmark/${bm.bookmarkId}" class="btn btn-link btn-sm p-0 mr-2">
								                        상세
								                    </a>
								
								                    <!-- 삭제 처리 (실제로는 delYn = 'Y'로 업데이트) -->
								                    <form action="${ctx}/bookmark/update" method="post"
								                          style="display:inline;"
								                          onsubmit="return confirm('정말로 삭제(비활성화)하시겠습니까?');">
								                        <input type="hidden" name="bookmarkId" value="${bm.bookmarkId}">
								                        <input type="hidden" name="delYn" value="Y">
								                        <button type="submit" class="btn btn-danger btn-sm">
								                            삭제
								                        </button>
								                    </form>
								                </td>
								            </tr>
								        </c:forEach>
								    </tbody>
								</table>
                                <c:if test="${empty bookmarks}">
                                    <p class="text-muted mb-0">저장된 북마크가 없습니다.</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; 결재24</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->
        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

    <!-- footer (JS) -->
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
