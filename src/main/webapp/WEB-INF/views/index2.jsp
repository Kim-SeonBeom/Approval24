<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<!-- index 경로 설정 - 임시 개발용 사용자 정보 -->
<c:remove var="loginUser" scope="session" />
<c:if test="${empty loginUser}">
	<jsp:useBean id="tempUser" class="java.util.HashMap" scope="session" />
	<c:set target="${tempUser}" property="userName" value="이혜성" />
	<c:set target="${tempUser}" property="departmentName" value="민원인" />
	<c:set target="${tempUser}" property="Benefits" value="실업급여" />
	<c:set var="loginUser" value="${tempUser}" scope="session" />
</c:if>

<!-- header 영역 -->
<head>
<title>민원인</title>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

</head>


<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
				<%@ include file="/WEB-INF/views/common/sidebar2.jsp" %>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                    	<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">${loginUser.departmentName}</h1>
                    </div>
                    

                    <!-- Content Row -->
                    <div class="row">

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                신청한 민원</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">5개</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>	
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                처리된 민원</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">2개</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-check fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-danger shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                                반려된 민원</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">1개</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-exclamation-triangle fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pending Requests Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                대기중인 민원</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">2개</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Content Row -->
                    <div class="row">

                        <!-- Content Column -->

                        <div class="col-lg-12 mb-4">

                            <!-- DataTables Example -->
		                    <div class="card shadow mb-4">
		                        <div class="card-header py-3">
		                            <h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
		                        </div>
		                        <div class="card-body">
		                            <div class="table-responsive">
		                                <table class="table table-bordered" id="dataTable_index" width="100%" cellspacing="0">
		                                    
		                                    <tbody>
		                                          <tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
												    <td>[공지] 10월 20일(월) 시스템 정기 점검 안내</td>
												    <td>2025-10-10</td>
												  </tr>
												  <tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
												    <td>[업데이트] 실업급여 신청서 양식이 새롭게 변경되었습니다.</td>
												    <td>2025-10-12</td>
												  </tr>
												  <tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
												    <td>[알림] 홈페이지 접속 지연 현상 해결 및 복구 완료 안내</td>
												    <td>2025-10-13</td>
												  </tr>
												  <tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
												    <td>[공지] 실업급여 관련 상담센터 운영시간 단축 안내 (09:00~17:00)</td>
												    <td>2025-10-14</td>
												  </tr>
												  <tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
													<td>[안내] 11월 공휴일(개천절, 한글날) 고객센터 휴무 일정 공지</td>
													<td>2025-10-15</td>
												  </tr>
		                                    </tbody>
		                                </table>
		                            </div>
		                            <a href="/approval24/notice">공지사항 조회하기 &rarr;</a>
		                        </div>
		                    </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

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
	<!-- footer 영역 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>


</body>
</html>