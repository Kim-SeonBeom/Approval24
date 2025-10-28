<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서관리</title>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- sidebar -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
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
                        <h1 class="h3 mb-0 text-gray-800">부서관리</h1>
                	</div>
                	<div class="card shadow mb-4">
                		<div class="card-header py-3 d-flex align-items-center justify-content-between">
                			<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">부서관리 목록</h6>
                			<!-- 글쓰기 버튼 안보이게 -->
							<c:if test="${loginUser.departmentName eq '어드민'}">
								<button class="btn btn-primary btn-sm" id="noticeWrite" style="font-size: 1rem; padding: 0.25rem 0.75rem;">부서등록</button>
							</c:if>
                		</div>
                		<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<tbody>
										<tr class="clickable-row sorting text-dark font-weight-bold"  style="cursor: pointer;">
											<td>부서 ID</td>
											<td>기관</td>
											<td>부서명</td>
											<td>전화번호</td>
											<td>마지막 수정일</td>
											<td>수정자</td>
										</tr>
										<tr class="clickable-row sorting " data-href="/approval24/division/detail" style="cursor: pointer;">
											<td>HI2025</td>
											<td>오티아이</td>
											<td>인사관리과</td>
											<td>031-249-2595</td>
											<td>2025-10-12</td>
											<td>412</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
                	</div>
				
				
				</div>
				<!-- Begin Page Content end -->
			
			</div>
			<!-- Main Content end-->
		
		</div>
		<!-- Content Wrapper end -->
	</div>

<!-- Logout Modal-->
<%@ include file="/WEB-INF/views/common/logoutModal.jsp" %>
<!-- footer 영역 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>