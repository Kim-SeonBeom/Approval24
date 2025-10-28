<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>부서관리 | 결재24</title>
<style>
/* 표 기반(딱딱한) 상세 레이아웃 */
.kv-table th {
	width: 140px;
	background: #f8f9fc;
	vertical-align: middle;
}

.kv-table td {
	background: #fff;
}

.kv-table .content-cell {
	white-space: pre-wrap;
	line-height: 1.6;
	min-height: 300px;
}

.kv-table .attach-cell ul {
	margin: 0;
	padding-left: 1rem;
}

.kv-table .attach-cell li+li {
	margin-top: .25rem;
}
</style>
</head>
<body id="page-top">

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

					<!-- 상단 제목/버튼 -->
					<div class="d-sm-flex align-items-center justify-content-between mb-3">
						<h1 class="h3 mb-0 text-gray-800">부서등록</h1>
					</div>

					<!-- 상세 카드 -->
					<div class="card shadow mb-4">

						<div class="d-flex justify-content-between mt-3 mx-4">
							<a href="${pageContext.request.contextPath}/division" class="btn btn-light btn-sm"> <i class="fas fa-list mr-1"></i>목록
							</a>
							<div>
								<c:if test="${loginUser.departmentName eq '어드민'}">
									<a href="<c:url value='/approval24/disvision/edit'><c:param name='deptId' value='${department.deptId}'/></c:url>" class="btn btn-primary btn-sm">
									 <i class="fas fa-edit mr-1"></i>수정
									</a>
									<button type="button" class="btn btn-danger btn-sm" id="btnDeleteFooter">
										<i class="fas fa-trash-alt mr-1"></i>삭제
									</button>
								</c:if>
							</div>

						</div>

						<div class="card-body">

							<!-- 표 기반 상세 -->
							<div class="table-responsive">
								<table class="table table-bordered table-sm kv-table">
									<colgroup>
										<col style="width: 18%;">
										<col style="width: 32%;">
										<col style="width: 18%;">
										<col style="width: 32%;">
									</colgroup>
									<tbody>
										<!-- 제목 -->
										<tr>
											<th scope="col" class="text-dark bg-light  font-weight-bold">부서 아이디</th>
											<td colspan="3"><strong class="text-gray-900"> <c:out value="${department.deptId}" default="HI001" /></td>
										</tr>

										<!-- (선택) 최소 메타: 필요 없으면 이 두 행 삭제해도 됩니다 -->
										<tr>
											<th scope="col" class="text-dark bg-light  font-weight-bold">기관명</th>
											<td colspan="3"><c:out value="${institution.instName}" default="오티아이" />오티아이</td>
										</tr>
										<tr>
											<th scope="col" class="text-dark bg-light  font-weight-bold">부서명</th>
											<td colspan="3"><c:out value="${department.deptName}" default="-" />인사관리과</td>
										</tr>

										<!-- 내용 -->
										<tr>
											<th scope="col" class="text-dark bg-light  font-weight-bold">전화번호</th>
											<td colspan="3" ><c:out value="${department.deptPhone}" default="-" />031-120-5126</td>

										</tr>

										<!-- 첨부 -->
										<tr>
											<th scope="col" class="text-dark bg-light  font-weight-bold">마지막 수정일</th>
											<td  >
												<c:choose>
													<c:when test="${department.updateDt == null}">
														<c:out value="${department.createDt}" default="-" />
													</c:when>
													<c:otherwise>
														<c:out value="${department.updateDt}" default="-" />
													</c:otherwise>
												</c:choose>2025-10-27</td>
											
											<th scope="col" class="text-dark bg-light  font-weight-bold">마지막 수정자</th>
											<td  >
											<c:choose>
    											<c:when test="${department.updateId == null}">
    												<c:out value="${department.createId}" default="-" />
    											</c:when>
   												<c:otherwise>
   													<c:out value="${department.updateId}" default="-" />
   												</c:otherwise>
   											</c:choose>이혜성</td>
										</tr>
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
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2020</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

	<!-- Logout Modal -->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<!-- footer 영역 (JS) -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>
		// 삭제 (상단/하단 버튼 공통 처리)
		function doDelete() {
			if (confirm('이 공지사항을 삭제하시겠습니까?')) {
				$
						.post('<c:url value="/approval24/notice/delete"/>', {
							noticeId : '${notice.noticeId}'
						})
						.done(
								function() {
									alert('삭제되었습니다.');
									window.location
											.assign('${pageContext.request.contextPath}/notice');
								}).fail(function() {
							alert('삭제 중 오류가 발생했습니다.');
						});
			}
		}
		$('#btnDelete, #btnDeleteFooter').on('click', doDelete);
	</script>

</body>
</html>