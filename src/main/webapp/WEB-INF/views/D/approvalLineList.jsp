<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>결재 이력</title>
</head>
<body id="page-top">
	<div id="wrapper">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid">
					<h1 class="h3 mb-3 text-gray-800">결재 이력</h1>

					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex justify-content-between align-items-center">
							<h6 class="h6 m-0 font-weight-bold text-primary">검색 및 필터링</h6>
							<button type="submit" class="btn btn-primary btn-sm text-white" form="approvalFilterForm">검색</button>
						</div>

						<div class="card-body">
							<form id="approvalFilterForm" method="get" action="/approval24/history/list">

								<div class="form-group row align-items-center mb-3">
									<label class="col-sm-2 col-form-label font-weight-bold text-center">결재 상태</label>
									<div class="col-sm-10">
										<select name="approvalStatusCd" class="form-control w-25">
											<option value="">전체</option>
											<c:forEach var="status" items="${statusCodeList}">
												<c:choose>
													<c:when test="${not empty filterMap.approvalStatusCd && filterMap.approvalStatusCd == status.codeId}">
														<option value="${status.codeId}" selected>${status.codeName}</option>
													</c:when>
													<c:otherwise>
														<option value="${status.codeId}">${status.codeName}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>

								<div class="form-group row align-items-center mb-3">
									<label class="col-sm-2 col-form-label font-weight-bold text-center">민원 구분</label>
									<div class="col-sm-10">
										<select name="categoryCd" class="form-control w-25">
											<option value="">전체</option>
											<c:forEach var="category" items="${categoryList}">
												<c:choose>
													<c:when test="${not empty filterMap.categoryCd && filterMap.categoryCd == category.categoryCd}">
														<option value="${category.categoryCd}" selected>${category.categoryName}</option>
													</c:when>
													<c:otherwise>
														<option value="${category.categoryCd}">${category.categoryName}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>

								<div class="form-group row align-items-center mb-3">
									<label class="col-sm-2 col-form-label font-weight-bold text-center">페이지당</label>
									<div class="col-sm-10">
										<select name="pageSize" class="form-control w-25">
											<option value="5" ${pageInfo.pageSize == 5 ? 'selected' : ''}>5</option>
											<option value="10" ${pageInfo.pageSize == 10 ? 'selected' : ''}>10</option>
											<option value="15" ${pageInfo.pageSize == 15 ? 'selected' : ''}>15</option>
										</select>
									</div>
								</div>

							</form>
						</div>
					</div>

					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">결재목록</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered table-hover table-sm text-center align-middle">
									<thead class="thead-light">
										<tr>
											<th>번호</th>
											<th>민원 접수 번호</th>
											<th>민원 서식 이름</th>
											<th>결재 상태</th>
											<th>결재자 유형</th>
											<th>결재자</th>
											<th>결재 종류</th>
											<th>처리일자</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${not empty historyList}">
												<c:forEach var="item" items="${historyList}" varStatus="status">
													<tr style="cursor: pointer;" <c:if test="${not empty item.url}">
                                                        onclick="window.open('${item.url}','_blank');"
                                                    </c:if>>
														<td>${(pageInfo.page - 1) * pageInfo.pageSize + status.index + 1}</td>
														<td>${item.complainId}</td>
														<td class="text-left pl-3">${item.categoryName}</td>
														<td>${item.approvalStatusName}</td>
														<td>${item.approverTypeName}</td>
														<td>${item.processorName}</td>
														<td>
														<c:if test="${not empty item.approvalTypeName}">
                                                   				 ${item.approvalTypeName}
                                                   		</c:if>
                                                   		<c:if test="${empty item.approvalTypeName}">
                                                   		 - 
                                                   		 </c:if>
                                                   		</td>
														<td><c:if test="${not empty item.processDt}">
																<fmt:formatDate value="${item.processDt}" pattern="yyyy-MM-dd HH:mm" />
															</c:if></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="7">조회된 결재 이력이 없습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>

							<c:if test="${pageInfo.totalPages > 1}">
								<nav aria-label="Page navigation example">
									<ul class="pagination justify-content-center mb-0">

										<c:url var="prevUrl" value="/history/list">
											<c:param name="page" value="${pageInfo.page - 1}" />
											<c:param name="approvalStatusCd" value="${filterMap.approvalStatusCd}" />
											<c:param name="categoryCd" value="${filterMap.categoryCd}" />
											<c:param name="pageSize" value="${pageInfo.pageSize}" />
										</c:url>
										<li class="page-item ${pageInfo.page == 1 ? 'disabled' : ''}"><a class="page-link" href="${prevUrl}">이전</a></li>

										<c:forEach begin="1" end="${pageInfo.totalPages}" var="p">
											<c:url var="pageUrl" value="/history/list">
												<c:param name="page" value="${p}" />
												<c:param name="approvalStatusCd" value="${filterMap.approvalStatusCd}" />
												<c:param name="categoryCd" value="${filterMap.categoryCd}" />
												<c:param name="pageSize" value="${pageInfo.pageSize}" />
											</c:url>
											<li class="page-item ${p == pageInfo.page ? 'active' : ''}"><a class="page-link" href="${pageUrl}">${p}</a></li>
										</c:forEach>

										<c:url var="nextUrl" value="/history/list">
											<c:param name="page" value="${pageInfo.page + 1}" />
											<c:param name="approvalStatusCd" value="${filterMap.approvalStatusCd}" />
											<c:param name="categoryCd" value="${filterMap.categoryCd}" />
											<c:param name="pageSize" value="${pageInfo.pageSize}" />
										</c:url>
										<li class="page-item ${pageInfo.page == pageInfo.totalPages ? 'disabled' : ''}"><a class="page-link" href="${nextUrl}">다음</a></li>
									</ul>
								</nav>
							</c:if>

						</div>
					</div>
				</div>
			</div>

			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>행정 &copy; 결재24 2025</span>
					</div>
				</div>
			</footer>
		</div>
	</div>

	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

</body>
</html>