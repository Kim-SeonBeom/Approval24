<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>공통 코드 상세 | 결재24</title>
<style>
.kv-table th {
	width: 160px;
	background: #f8f9fc;
	color: #4e73df;
	vertical-align: middle;
}

.kv-table td {
	background: #fff;
}

.badge-use {
	background: #1cc88a;
} /* 사용 */
.badge-stop {
	background: #e74a3b;
} /* 미사용 */
</style>
</head>

<body id="page-top">

	<div id="wrapper">
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid">
					<!-- Page Heading -->
					<div class="d-flex align-items-center justify-content-between mb-2">
						<h1 class="h3 text-gray-800 mb-0">공통 코드 상세</h1>

					</div>

					<!-- Detail Card -->
					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">${code.group_id}/${code.code_id}</h6>
							<span> <c:choose>
									<c:when test="${code.del_yn == 'N'}">
										<span class="badge badge-use">사용</span>
									</c:when>
									<c:otherwise>
										<span class="badge badge-stop">미사용</span>
									</c:otherwise>
								</c:choose>
							</span>
						</div>

						<div class="card-body">
							<table class="table table-bordered kv-table">
								<tbody>
									<tr>
										<th>그룹코드</th>
										<td>${code.group_id}</td>
									</tr>
									<tr>
										<th>상세코드</th>
										<td>${code.code_id}</td>
									</tr>
									<tr>
										<th>코드명</th>
										<td>${code.code_name}</td>
									</tr>
									<tr>
										<th>코드상세</th>
										<td class="content-cell"><c:out value="${empty code.code_detail ? '-' : code.code_detail}" /></td>
									</tr>
									<tr>
										<th>정렬순번</th>
										<td><c:choose>
												<c:when test="${empty code.sequence}">-</c:when>
												<c:otherwise>${code.sequence}</c:otherwise>
											</c:choose></td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td><c:choose>
												<c:when test="${code.del_yn == 'N'}">Y</c:when>
												<c:otherwise>N </c:otherwise>
											</c:choose></td>
									</tr>

									<!-- 프로젝트에 생성/수정 메타 컬럼이 있을 경우 표시 (없으면 자동으로 숨김) -->

									<tr>
										<th>생성일시</th>
										<td><c:out value="${empty code.created_at ? '-' : code.created_at}" /></td>
									</tr>
									<tr>
										<th>수정일시</th>
										<td><c:out value="${empty code.updated_at ? '-' : code.updated_at}" /></td>
									</tr>

								</tbody>
							</table>

							<!-- Bottom Actions -->
							<div class="d-flex justify-content-between mt-3">
								<a href="${pageContext.request.contextPath}/totalcode" class="btn btn-light btn-sm"> <i class="fas fa-list mr-1"></i> 목록
								</a>
								<div>

									<a href="${pageContext.request.contextPath}/code/edit?group_id=${code.group_id}&code_id=${code.code_id}" class="btn btn-primary btn-sm"> <i class="fas fa-edit mr-1"></i> 수정
									</a>
									<button type="button" class="btn btn-danger btn-sm" id="btnDeleteBottom" data-group="${code.group_id}" data-code="${code.code_id}">
										<i class="fas fa-trash-alt mr-1"></i> 삭제
									</button>

								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /#content -->

		</div>
		<!-- /#content-wrapper -->
	</div>
	<!-- /#wrapper -->

	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>
  function doDelete(groupId, codeId){
    if(!confirm('삭제하시겠습니까?\n(미사용 처리로 전환하는 것을 권장합니다)')) return;
    // 실제 정책에 맞게: 물리삭제 / 논리삭제(del_yn='Y') 엔드포인트 선택
    // 아래는 논리삭제 예시
    const url = '${pageContext.request.contextPath}/code/delete';
    const form = document.createElement('form');
    form.method = 'post';
    form.action = url;

    const g = document.createElement('input'); g.type='hidden'; g.name='group_id'; g.value=groupId; form.appendChild(g);
    const c = document.createElement('input'); c.type='hidden'; c.name='code_id';  c.value=codeId;  form.appendChild(c);

    document.body.appendChild(form);
    form.submit();
  }

  document.getElementById('btnDeleteTop')?.addEventListener('click', function(){
    doDelete(this.dataset.group, this.dataset.code);
  });
  document.getElementById('btnDeleteBottom')?.addEventListener('click', function(){
    doDelete(this.dataset.group, this.dataset.code);
  });
</script>

</body>
</html>
