<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>대결자 등록 | 결재24</title>
<style>
/* 표 기반(딱딱한) 작성 레이아웃 */
.kv-table th {
	width: 140px;
	background: #f8f9fc;
	vertical-align: middle;
}

.kv-table td {
	background: #fff;
}
/* 상세와 동일한 룩앤필 유지 */
.kv-table .content-cell {
	white-space: pre-wrap;
	line-height: 1.6;
	min-height: 300px;
}
/* 파일 리스트 UI 정리 */
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
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid">

					<!-- 상단 제목/버튼 -->
					<div class="d-sm-flex align-items-center justify-content-between mb-3">
						<h1 class="h3 mb-0 text-gray-800">대결자 등록</h1>
					</div>

					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">작성 항목</h6>
							<div class="ml-auto">
								<!-- 폼 밖에 있지만 JS로 제출 -->
								<button type="button" class="btn btn-primary btn-sm" id="btnSaveTop">
									<i class="fas fa-save mr-1"></i>등록
								</button>
								<a href="${pageContext.request.contextPath}/delegate" class="btn btn-danger btn-sm">취소</a>
							</div>
						</div>

						<div class="card-body">
							<!-- 등록 폼 -->
							<form id="deptInsertForm" action="/approval24/delegate/new" method="post">
								<div class="table-responsive">
									<table class="table table-bordered table-sm kv-table">
										<colgroup>
											<col style="width: 18%;">
											<col style="width: 32%;">
											<col style="width: 18%;">
											<col style="width: 32%;">
										</colgroup>
										<tbody>


											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">대결자</th>
												<td><select id="delegateId" name="delegateId" class="form-control" required>
														<option value="">-- 선택 --</option>
														<c:forEach var="acc" items="${accountList}">
															<c:if test="${acc.accountId ne null and acc.userName ne null}">
																<option value="${acc.accountId}">${acc.userNo} | ${acc.userName}</option>
															</c:if>
														</c:forEach>
												</select></td>
												<th>사유</th>
												<td><input type="text" name="proxyComment" id="proxyComment" class="form-control form-control-sm" placeholder="대결자 지정사유를 입력하세요" required maxlength="200" /></td>

											</tr>

											<!--등록일-->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">시작일</th>
												<td><input type="date" name="startDt" class="form-control" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>" /></td>
												<th>종료일</th>
												<td><input type="date" name="endDt" class="form-control" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>" /></td>
											</tr>


										</tbody>
									</table>
								</div>
							</form>
						</div>
					</div>

				</div>
			</div>

		</div>
	</div>

	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>
		// 등록 버튼 클릭 시 폼 제출
		$(document).ready(function() {
			$('#btnSaveTop').on('click', function() {
				const form = document.getElementById('deptInsertForm');
				if (!form.checkValidity())
					return;
				$('#deptInsertForm').submit();
			});
		});
	</script>

</body>
</html>
