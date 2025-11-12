<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>공지사항</title>
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
					<h1 class="h3 mb-2 text-gray-800">공지사항</h1>
					<br>
									<div class="card shadow mb-4">
						<div
							class="card-header py-3 d-flex justify-content-between align-items-center">
							<h6 class="m-0 font-weight-bold text-primary">검색 및 필터링</h6>

							<div>
								<button class="btn btn-primary btn-sm" type="submit"
									form="noticeFilterForm">검색</button>
								
								<c:if test="${logindeptName eq '인사과'}">
								<button class="btn btn-success btn-sm ml-2" type="button"
									onclick="location.href='${pageContext.request.contextPath}/notice/new'">추가</button>
									</c:if>
							</div>
						</div>

						<div class="card-body">
							<form id="noticeFilterForm" action="${pageContext.request.contextPath}/notice" method="get">

								<!-- 제목 -->
								<div class="form-group row align-items-center mb-3">
									<label for="complainUserName"
										class="col-sm-2 col-form-label font-weight-bold text-center">제목</label>
									<div class="col-sm-10">
										<input type="text" class="form-control w-25" id="title"
											name="title" value="${filter.title}"
											placeholder="제목 입력">
									</div>
								</div>

								<div class="form-group row align-items-center mb-3">
									<label class="col-sm-2 col-form-label font-weight-bold text-center">서식별</label>
									<div class="col-sm-10">
										<div class="form-inline">
											<!-- name/id 를 complainCategoryId 로 통일 -->
											<select class="form-control mr-2" id="complainCategoryId" name="complainCategoryId" style="min-width: 220px;">
												<option value="">전체</option>
												<c:forEach var="list" items="${categoryList}">
													<option value="${list.complainCategoryId}" <c:if test="${filter.complainCategoryId == list.complainCategoryId}">selected</c:if>>${list.categoryName}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
								
									<!-- 신청자명 -->
								<div class="form-group row align-items-center mb-3">
									<label for="userName" class="col-sm-2 col-form-label font-weight-bold text-center">등록인명</label>
									<div class="col-sm-10">
										<input type="text" class="form-control w-25" id="userName" name="userName" value="${filter.userName}" placeholder="등록인 이름 입력">
									</div>
								</div>



								<!--  기간검색 -->
								<div class="form-group row align-items-center mb-3">
										<label class="col-sm-2 col-form-label font-weight-bold text-center">등록일</label>
									<div class="col-sm-10">
										<div class="form-inline">
										
												 <input type="date" class="form-control mr-2" id="startDate" name="startDate" value="${filter.startDate}" style="width: 180px;"> <span class="mx-1">~</span> <input type="date" class="form-control ml-2" id="endDate" name="endDate" value="${filter.endDate}" style="width: 180px;">
										</div>
									</div>
								</div>

								<input type="hidden" name="page" value="${filter.page}" /> <input type="hidden" name="size" value="${filter.size}" />
							</form>
						</div>
					</div>

					<!-- 뜨는 목록창 -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">공지목록</h6>
						</div>
						<div class="card-body">

							<c:if test="${empty noticeList}">
								<div class="text-center text-muted py-4">
									검색 조건을 입력하고 <b>검색</b>을 눌러주세요.
								</div>
							</c:if>

							<c:if test="${not empty noticeList}">
								<div class="mb-2 text-left text-muted">
									총 <b> ${totalCount}</b>건
								</div>
								<div class="table-responsive">
									<table
										class="table table-bordered table-hover table-sm text-center align-middle">
										<thead class="thead-light">
											<tr>
												<th style="width: 60px;">번호</th>
												<th >제목</th>
												<th style="width: 450px;">민원서식</th>
												<th style="width: 120px;">등록인</th>
												<th style="width: 200px;">작성일</th>
												<th style="width: 100px;">조회수</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="item" items="${noticeList}"
												varStatus="status">
												<tr class="clickable-row"
													data-href="${pageContext.request.contextPath}/notice/detail/${item.noticeId}"
													style="cursor: pointer;">
													<td>${(filter.page - 1) * filter.size + status.index + 1}</td>
													<td class="text-left">${item.title}</td>
													<td class="text-left">${item.categoryName}</td>
													<td>${item.userName}</td>
													<td>${item.createDt}</td>
													<td>${item.viewCount}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>

								<!-- 페이지네이션은 기존 그대로 사용 -->
								<c:set var="curr" value="${filter.page}" />
								<c:set var="last" value="${totalPages}" />
								<nav aria-label="Page navigation" class="mt-3">
									<ul class="pagination justify-content-center">
										<!-- Prev -->
										<li class="page-item ${curr <= 1 ? 'disabled' : ''}"><a
											class="page-link"
											href="<c:url value='/notice'>
                                <c:param name='page' value='${curr-1}'/>
                                <c:param name='size' value='${filter.size}'/>
                                 <c:if test='${not empty filter.title}'><c:param name='title' value='${filter.title}'/></c:if>
                                <c:if test='${not empty filter.categoryCd}'><c:param name='categoryCd' value='${filter.categoryCd}'/>${filter.categoryName}</c:if>
                                 <c:if test='${not empty filter.createDt}'><c:param name='startDate' value='${filter.createDt}'/></c:if>                   
                                <c:if test='${not empty filter.startDate}'><c:param name='startDate' value='${filter.startDate}'/></c:if>
                                <c:if test='${not empty filter.endDate}'><c:param name='endDate' value='${filter.endDate}'/></c:if>
                                <c:if test='${not empty filter.userName}'><c:param name='userName' value='${filter.userName}'/></c:if>
                              </c:url>">이전</a>
										</li>

										<!-- Pages -->
										<c:forEach begin="1" end="${last}" var="p">
											<li class="page-item ${p == curr ? 'active' : ''}"><a
												class="page-link"
												href="<c:url value='/notice'>
                                   <c:param name='page' value='${p}'/>
                                   <c:param name='size' value='${filter.size}'/>
                                 <c:if test='${not empty filter.title}'><c:param name='title' value='${filter.title}'/></c:if>
               					 <c:if test='${not empty filter.categoryCd}'><c:param name='categoryCd' value='${filter.categoryCd}'/>${filter.categoryName}</c:if>
                                 <c:if test='${not empty filter.createDt}'><c:param name='startDate' value='${filter.createDt}'/></c:if>                   
                                <c:if test='${not empty filter.startDate}'><c:param name='startDate' value='${filter.startDate}'/></c:if>
                                <c:if test='${not empty filter.endDate}'><c:param name='endDate' value='${filter.endDate}'/></c:if>
                                <c:if test='${not empty filter.userName}'><c:param name='userName' value='${filter.userName}'/></c:if>
                                 </c:url>">${p}</a>
											</li>
										</c:forEach>

										<!-- Next -->
										<li class="page-item ${curr >= last ? 'disabled' : ''}"><a
											class="page-link"
											href="<c:url value='/notice'>
                                <c:param name='page' value='${curr+1}'/>
                                <c:param name='size' value='${filter.size}'/>
                                 <c:if test='${not empty filter.title}'><c:param name='title' value='${filter.title}'/></c:if>
                                 <c:if test='${not empty filter.categoryCd}'><c:param name='categoryCd' value='${filter.categoryCd}'/>${filter.categoryName}</c:if>
                                 <c:if test='${not empty filter.createDt}'><c:param name='startDate' value='${filter.createDt}'/></c:if>                   
                                <c:if test='${not empty filter.startDate}'><c:param name='startDate' value='${filter.startDate}'/></c:if>
                                <c:if test='${not empty filter.endDate}'><c:param name='endDate' value='${filter.endDate}'/></c:if>
                                <c:if test='${not empty filter.userName}'><c:param name='userName' value='${filter.userName}'/></c:if>
                              </c:url>">다음</a>
										</li>
									</ul>
								</nav>
							</c:if>
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
						<span>행정 &copy; 결재24 2025</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<!-- footer 영역 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script src="resources/assets/js/demo/chart-bar-demo.js"></script>
	<script>
		$("#noticeWrite").on('click', function() {
			window.location.href="${pageContext.request.contextPath}/notice/new";
		});
		document.addEventListener('click', function(e) {
			const tr = e.target.closest('.clickable-row');
			if (tr && tr.dataset.href) {
				window.location.href = tr.dataset.href;
			}
		});
	</script>


</body>
</html>