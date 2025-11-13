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
					<h1 class="h3 mb-2 text-gray-800">${title }</h1>
					<br>

					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex justify-content-between align-items-center">
							<h6 class="m-0 font-weight-bold text-primary">검색 및 필터링</h6>
							<!-- CHANGED: 폼 외부 버튼이 form을 가리키도록 form 속성 추가 -->
							<button class="btn btn-primary btn-sm" type="submit" form="userFilterForm">검색</button>
						</div>

						<div class="card-body">
							<form id="userFilterForm" action="${pageContext.request.contextPath}/complain/category/${categoryUrl}" method="get">

								<!-- 1. 기간검색 -->
								<div class="form-group row align-items-center mb-3">
									<label class="col-sm-2 col-form-label font-weight-bold text-center">기간검색</label>
									<div class="col-sm-10">
										<div class="form-inline">
											<select class="form-control mr-2" id="dateType" name="dateType" style="width: 120px;">
												<option value="rcptDt" ${filter.dateType == 'rcptDt' ? 'selected' : ''}>신청일</option>
												<option value="deadlineDt" ${filter.dateType == 'deadlineDt' ? 'selected' : ''}>마감일</option>
											</select> <input type="date" class="form-control mr-2" id="startDate" name="startDate" value="${filter.startDate}" style="width: 180px;"> <span class="mx-1">~</span> <input type="date" class="form-control ml-2" id="endDate" name="endDate" value="${filter.endDate}" style="width: 180px;">
										</div>
									</div>
								</div>

								<!-- 2. 상태 -->
								<div class="form-group row align-items-center mb-3">
									<label class="col-sm-2 col-form-label font-weight-bold text-center">처리상태</label>
									<div class="col-sm-10">
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="status" id="status1" value="D001" ${filter.status == 'D001' ? 'checked' : ''}> <label class="form-check-label" for="status1">접수</label>
										</div>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="status" id="status2" value="D002" ${filter.status == 'D002' ? 'checked' : ''}> <label class="form-check-label" for="status2">등록</label>
										</div>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="status" id="status3" value="D003" ${filter.status == 'D003' ? 'checked' : ''}> <label class="form-check-label" for="status3">처리중</label>
										</div>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="status" id="status4" value="D004" ${filter.status == 'D004' ? 'checked' : ''}> <label class="form-check-label" for="status4">취하</label>
										</div>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="status" id="status5" value="D005" ${filter.status == 'D005' ? 'checked' : ''}> <label class="form-check-label" for="status5">반려</label>
										</div>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="status" id="status6" value="D006" ${filter.status == 'D006' ? 'checked' : ''}> <label class="form-check-label" for="status6">승인</label>
										</div>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="status" id="statusAll" value="" ${empty filter.status ? 'checked' : ''}> <label class="form-check-label" for="statusAll">전체</label>
										</div>
									</div>
								</div>

								<!-- 3. 신청자명 -->
								<div class="form-group row align-items-center mb-3">
									<label for="complainUserName" class="col-sm-2 col-form-label font-weight-bold text-center">신청자명</label>
									<div class="col-sm-10">
										<input type="text" class="form-control w-25" id="complainUserName" name="complainUserName" value="${filter.complainUserName}" placeholder="신청자 이름 입력">
									</div>
								</div>

								<!-- 4. 담당자명 -->
								<div class="form-group row align-items-center mb-3">
									<label for="manager" class="col-sm-2 col-form-label font-weight-bold text-center">담당자명</label>
									<div class="col-sm-10">
										<input type="text" class="form-control w-25" id="manager" name="manager" value="${filter.manager}" placeholder="담당자 이름 입력">
									</div>
								</div>

								<input type="hidden" name="page" value="${filter.page}" /> <input type="hidden" name="size" value="${filter.size}" />

							</form>
						</div>
					</div>


					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">민원목록</h6>
						</div>
						<div class="card-body">
							<!-- 빈 상태 안내 -->
							<c:if test="${empty complainList}">
								<div class="text-center text-muted py-4">
									검색 조건을 입력하고 <b>검색</b>을 눌러주세요.
								</div>
							</c:if>

							<c:if test="${not empty complainList}">
								<div class="mb-2 text-left text-muted">
									총 <b> ${totalCount}</b>건
								</div>
								<div class="table-responsive">
									<!-- DataTables ID 제거, 부트스트랩 기본 테이블만 -->
									<table class="table table-bordered table-hover table-sm text-center align-middle">
										<thead class="thead-light">
											<tr>
												<th style="width: 60px;">번호</th>
												<th style="width: 100px;">접수번호</th>
												<th>민원서식</th>
												<th>신청자</th>
												<th>담당자</th>
												<th style="width: 110px;">상태</th>
												<th style="width: 120px;">신청일</th>
												<th style="width: 120px;">마감일</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="item" items="${complainList}" varStatus="status">
												<tr class="clickable-row" data-href="${pageContext.request.contextPath}/complain/category/${categoryUrl}/${item.complainId}" style="cursor: pointer;">
													<td>${(filter.page - 1) * filter.size + status.index + 1}</td>
													<td>${item.complainId}</td>
													<td class="text-left pl-3">${item.categoryName}</td>
													<td>${item.complainuserName}</td>
													<td>${item.userName}</td>
													<td>
														<!-- 상태 뱃지 간단 스타일 --> <c:choose>
															<c:when test="${item.complainStatusCd == 'D001'}">
																<span class="badge badge-info">접수</span>
															</c:when>
															<c:when test="${item.complainStatusCd == 'D002'}">
																<span class="badge badge-success">등록</span>
															</c:when>
															<c:when test="${item.complainStatusCd == 'D003'}">
																<span class="badge badge-secondary">처리중</span>
															</c:when>
															<c:when test="${item.complainStatusCd == 'D004'}">
																<span class="badge badge-warning">취하</span>
															</c:when>
															<c:when test="${item.complainStatusCd == 'D005'}">
																<span class="badge badge-danger">반려</span>
															</c:when>
															<c:when test="${item.complainStatusCd == 'D006'}">
																<span class="badge badge-primary">승인</span>
															</c:when>
															<c:otherwise>
																<span class="badge badge-light">${item.complainStatusCd}</span>
															</c:otherwise>
														</c:choose>
													</td>
													<td>${item.rcptDt}</td>
													<td>${item.deadlineDt}</td>
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
										<li class="page-item ${curr <= 1 ? 'disabled' : ''}"><a class="page-link"
											href="<c:url value='/complain/category/${categoryUrl}'>
                        <c:param name='page' value='${curr-1}'/>
                        <c:param name='size' value='${filter.size}'/>
                        <c:if test='${not empty filter.dateType}'><c:param name='dateType' value='${filter.dateType}'/></c:if>
                        <c:if test='${not empty filter.startDate}'><c:param name='startDate' value='${filter.startDate}'/></c:if>
                        <c:if test='${not empty filter.endDate}'><c:param name='endDate' value='${filter.endDate}'/></c:if>
                        <c:if test='${not empty filter.status}'><c:param name='status' value='${filter.status}'/></c:if>
                        <c:if test='${not empty filter.complainUserName}'><c:param name='complainUserName' value='${filter.complainUserName}'/></c:if>
                        <c:if test='${not empty filter.manager}'><c:param name='manager' value='${filter.manager}'/></c:if>
                    </c:url>">이전</a>
										</li>

										<!-- Pages -->
										<c:forEach begin="1" end="${last}" var="p">
											<li class="page-item ${p == curr ? 'active' : ''}"><a class="page-link"
												href="<c:url value='/complain/category/${categoryUrl}'>
                          <c:param name='page' value='${p}'/>
                          <c:param name='size' value='${filter.size}'/>
                          <c:if test='${not empty filter.dateType}'><c:param name='dateType' value='${filter.dateType}'/></c:if>
                          <c:if test='${not empty filter.startDate}'><c:param name='startDate' value='${filter.startDate}'/></c:if>
                          <c:if test='${not empty filter.endDate}'><c:param name='endDate' value='${filter.endDate}'/></c:if>
                          <c:if test='${not empty filter.status}'><c:param name='status' value='${filter.status}'/></c:if>
                          <c:if test='${not empty filter.complainUserName}'><c:param name='complainUserName' value='${filter.complainUserName}'/></c:if>
                          <c:if test='${not empty filter.manager}'><c:param name='manager' value='${filter.manager}'/></c:if>
                      </c:url>">${p}</a>
											</li>
										</c:forEach>

										<!-- Next -->
										<li class="page-item ${curr >= last ? 'disabled' : ''}"><a class="page-link"
											href="<c:url value='/complain/category/${categoryUrl}'>
                        <c:param name='page' value='${curr+1}'/>
                        <c:param name='size' value='${filter.size}'/>
                        <c:if test='${not empty filter.dateType}'><c:param name='dateType' value='${filter.dateType}'/></c:if>
                        <c:if test='${not empty filter.startDate}'><c:param name='startDate' value='${filter.startDate}'/></c:if>
                        <c:if test='${not empty filter.endDate}'><c:param name='endDate' value='${filter.endDate}'/></c:if>
                        <c:if test='${not empty filter.status}'><c:param name='status' value='${filter.status}'/></c:if>
                        <c:if test='${not empty filter.complainUserName}'><c:param name='complainUserName' value='${filter.complainUserName}'/></c:if>
                        <c:if test='${not empty filter.manager}'><c:param name='manager' value='${filter.manager}'/></c:if>
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
	<script>
		document.addEventListener('click', function(e) {
			const tr = e.target.closest('.clickable-row');
			if (tr && tr.dataset.href) {
				window.location.href = tr.dataset.href;
			}
		});
	</script>

</body>

</html>