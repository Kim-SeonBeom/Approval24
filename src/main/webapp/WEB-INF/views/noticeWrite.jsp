<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>공지사항 글쓰기 | 결재24</title>
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
	min-height: 300px; /* 상세와 동일한 최소 높이 */
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
						<h1 class="h3 mb-0 text-gray-800">공지사항</h1>
					</div>

					<!-- 카드 -->
					<div class="card shadow mb-4">

						<!-- 상단 버튼 영역: 목록 / 저장 -->
						<div class="card-header py-3 d-flex align-items-center">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">공지사항 작성</h6>
							<div class="ml-auto">
								<button type="button" class="btn btn-primary btn-sm" id="btnSaveTop">
									<i class="fas fa-save mr-1"></i>저장
								</button>
								<a href="${pageContext.request.contextPath}/notice" class="btn btn-danger btn-sm">취소</a>
							</div>

						</div>


						<div class="card-body">
							<form id="noticeForm" method="post" action="<c:url value='/approval24/notice/save'/>" enctype="multipart/form-data" novalidate>

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
												<th scope="col" class="text-dark bg-light font-weight-bold">제목</th>
												<td colspan="3"><input type="text" name="title" id="title" class="form-control form-control-sm" placeholder="공지 제목을 입력하세요" required maxlength="200"></td>
											</tr>

											<!-- 작성자 / 등록일 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">작성자</th>
												<td><input type="text" name="source" id="source" class="form-control form-control-sm" value="인사팀_정동윤" required></td>
												<th scope="col" class="text-dark bg-light font-weight-bold">등록일</th>
												<td>
													<!-- 화면 표시용 오늘 날짜, 서버 저장은 서버에서 실제 날짜로 처리 권장 --> <input type="text" class="form-control form-control-sm" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>" readonly>
												</td>
											</tr>

											<!-- 내용 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">내용</th>
												<td colspan="3" class="content-cell"><textarea name="content" id="content" class="form-control" style="min-height: 300px;" placeholder="공지 내용을 입력하세요" required></textarea></td>
											</tr>

											<!-- 첨부 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">첨부파일</th>
												<td colspan="3" class="attach-cell">
													<div id="fileInputs">
														<div class="input-group input-group-sm mb-2">
															<div class="custom-file">
																<input type="file" class="custom-file-input" name="files" id="file0"> <label class="custom-file-label" for="file0">파일을 선택하세요</label>
															</div>
														</div>
													</div>
													<button type="button" class="btn btn-outline-secondary btn-sm" id="btnAddFile">
														<i class="fas fa-plus mr-1"></i>파일 추가
													</button>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</form>


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
/* 커스텀 파일 인풋 라벨 표시 */
$(document).on('change', '.custom-file-input', function () {
	const fileName = $(this).val().split('\\').pop();
	$(this).siblings('.custom-file-label').addClass("selected").text(fileName || '파일을 선택하세요');
});

/* 파일 입력 추가 */
let fileIndex = 1;
$('#btnAddFile').on('click', function () {
	const id = 'file' + (fileIndex++);
	const $row = $(`
		<div class="input-group input-group-sm mb-2">
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="files" id="${id}">
				<label class="custom-file-label" for="${id}">파일을 선택하세요</label>
			</div>
			<div class="input-group-append">
				<button class="btn btn-outline-danger" type="button" title="삭제" data-remove-file>
					<i class="fas fa-times"></i>
				</button>
			</div>
		</div>
	`);
	$('#fileInputs').append($row);
});

/* 추가한 파일 입력 제거 */
$(document).on('click', '[data-remove-file]', function () {
	$(this).closest('.input-group').remove();
});

/* 저장 버튼(상·하단) 공통 처리 */
function submitForm() {
	const $form = $('#noticeForm');
	// 간단 유효성 검사
	const title = $('#title').val().trim();
	const content = $('#content').val().trim();

	if (!title) { alert('제목을 입력하세요.'); $('#title').focus(); return; }
	if (!content) { alert('내용을 입력하세요.'); $('#content').focus(); return; }

	// 중복 제출 방지
	$('[id^=btnSave]').prop('disabled', true);
	$form.trigger('submit');
}
$('#btnSaveTop, #btnSaveBottom').on('click', submitForm);
</script>

</body>
</html>
