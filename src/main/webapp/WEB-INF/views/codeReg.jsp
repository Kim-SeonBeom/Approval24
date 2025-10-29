<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>공통 코드 등록 | 결재24</title>
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
						<h1 class="h3 text-gray-800 mb-0">공통 코드 등록</h1>
					</div>

					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">신규 등록</h6>
						</div>

						<div class="card-body">
							<form id="codeCreateForm" method="post" action="${pageContext.request.contextPath}/code/create">
								<table class="table table-bordered kv-table">
									<tbody>
										<!-- 그룹코드 -->
										<tr>
											<th>그룹코드 <span class="text-danger">*</span></th>
											<td><input type="text" class="form-control form-control-sm" name="group_id" id="group_id" maxlength="255" required placeholder="예) DEPT, AUTH, APPROVAL, COMPLAIN"> <small class="text-muted">대분류 코드값입니다. (예: DEPT, AUTH, APPROVAL …)</small></td>
										</tr>

										<!-- 상세코드 -->
										<tr>
											<th>상세코드 <span class="text-danger">*</span></th>
											<td><input type="text" class="form-control form-control-sm" name="code_id" id="code_id" maxlength="255" required placeholder="예) D001, A001, S001, C001"> <small class="text-muted">동일 그룹 내에서 유일해야 합니다.</small></td>
										</tr>

										<!-- 코드명 -->
										<tr>
											<th>코드명 <span class="text-danger">*</span></th>
											<td><input type="text" class="form-control form-control-sm" name="code_name" id="code_name" maxlength="255" required placeholder="예) 인사팀 / 관리자 / 승인완료 / 실업급여"></td>
										</tr>

										<!-- 코드상세 -->
										<tr>
											<th>코드상세</th>
											<td><textarea class="form-control form-control-sm" name="code_detail" id="code_detail" rows="3" maxlength="255" placeholder="코드에 대한 추가 설명을 입력하세요."></textarea></td>
										</tr>

										<!-- 정렬순번 -->
										<tr>
											<th>정렬순번</th>
											<td><input type="number" class="form-control form-control-sm" name="sequence" id="sequence" min="0" step="1" placeholder="작을수록 먼저 표시됩니다(예: 1,2,3...)"> <small class="text-muted">드롭다운/목록의 표시 순서에 사용됩니다(선택).</small></td>
										</tr>

										<!-- 사용여부(Y/N) ↔ del_yn(N/Y) -->
										<tr>
											<th>사용여부</th>
											<td><select class="form-control form-control-sm" id="use_yn">
													<option value="Y" selected>사용</option>
													<option value="N">미사용</option>
											</select> <!-- 실제 저장 컬럼 --> <input type="hidden" name="del_yn" id="del_yn" value="N"> <small class="text-muted">화면의 사용여부는 내부적으로 del_yn 컬럼으로 저장됩니다. (사용=del_yn:N / 미사용=del_yn:Y)</small></td>
										</tr>
									</tbody>
								</table>

								<div class="d-flex justify-content-between mt-3">
									<div>
										<button type="button" id="btnSave" class="btn btn-primary btn-sm">
											<i class="fas fa-save mr-1"></i> 저장
										</button>
										<a href="${pageContext.request.contextPath}/totalcode" class="btn btn-danger btn-sm">취소</a>
									</div>
								</div>
							</form>
						</div>
					</div>

				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /#content -->

			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright © 결재24 2025</span>
					</div>
				</div>
			</footer>
		</div>
		<!-- /#content-wrapper -->
	</div>
	<!-- /#wrapper -->

	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>
		// 사용여부(Y/N) -> del_yn(N/Y) 동기화
		function syncDelYn() {
			var useYn = document.getElementById('use_yn').value; // Y or N
			document.getElementById('del_yn').value = (useYn === 'Y') ? 'N'
					: 'Y';
		}
		document.getElementById('use_yn').addEventListener('change', syncDelYn);

		// 저장 전 검증 & 전송
		document.getElementById('btnSave').addEventListener(
				'click',
				function() {
					var gid = document.getElementById('group_id').value.trim();
					var cid = document.getElementById('code_id').value.trim();
					var name = document.getElementById('code_name').value
							.trim();
					if (!gid || !cid || !name) {
						alert('그룹코드, 상세코드, 코드명은 필수입니다.');
						return;
					}
					// del_yn 동기화
					syncDelYn();

					// 정렬순번이 공란이면 name 제거(서버에서 NULL 처리)
					var seqEl = document.getElementById('sequence');
					if (seqEl.value.trim() === '')
						seqEl.removeAttribute('name');

					document.getElementById('codeCreateForm').submit();
				});
	</script>
</body>
</html>