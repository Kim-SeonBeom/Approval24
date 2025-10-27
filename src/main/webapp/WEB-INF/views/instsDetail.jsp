<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>기관 생성 | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">기관 상세</h1>
					</div>

					<!-- 카드 -->
					<div class="card shadow mb-4">

						<!-- 상단 버튼 영역: 목록 / 저장 -->
						<div class="card-header py-3 d-flex align-items-center">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">상세 내용</h6>
							<div class="ml-auto">
								<button type="button" class="btn btn-primary btn-sm" id="btnSaveTop">
									<i class="fas fa-save mr-1"></i>수정
								</button>
								<button type="button" class="btn btn-danger btn-sm" id="btnDeleteTop">
									삭제
								</button>
								
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
												<th scope="col" class="text-dark bg-light font-weight-bold">기관명</th>
												<td colspan="3"><input type="text" name="inst_name" id="inst_name" class="form-control form-control-sm" value="${instsDTO.inst_name}" readonly required maxlength="200"></td>
											</tr>

											<!-- 작성자 / 등록일 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">대표자명</th>
												<td><input type="text" name="inst_head_name" id="inst_head_name" class="form-control form-control-sm" value="${instsDTO.inst_head_name}" readonly required></td>
												<th>기관 등록일</th>
												<td><input type="date" class="form-control" value="${instsDTO.create_dt}" readonly
													name="create_dt"></td>
											</tr>

											<!-- 내용 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold"
													style="vertical-align: middle;">주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text" class="form-control form-postal-code mr-2"
															placeholder="우편번호" name="complainuser_post"
															id="complainuser_post" readonly style="width: 150px;">
						
														<button type="button" class="btn btn-secondary"
															onclick="openDaumPostcode()">주소 검색</button>
													</div> <input type="text" class="form-control mb-2" placeholder="기본 주소"
													name="inst_address" id="inst_address" readonly>
													<input type="text" class="form-control" value="${instsDTO.inst_detail_address}" readonly
													placeholder="상세 주소 (건물명, 동/호수 등)" name="inst_detail_address"
													id="inst_detail_address">
												</td>
											</tr>

											<!-- 전화번호 -->
											<tr>
												<th>기관 연락처</th>
												<td colspan="3"><input type="tel" class="form-control" value="${instsDTO.inst_phone}" readonly
													name="inst_phone"></td>
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
