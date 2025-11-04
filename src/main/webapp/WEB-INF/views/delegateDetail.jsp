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
					<br>
					<c:if test="${not empty insertMsg}">
						<div class="alert alert-info alert-dismissible fade show" role="alert">
							${insertMsg}
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
					</c:if>

					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">상세 내용</h6>
							<div class="ml-auto">
								<button type="button" class="btn btn-primary btn-sm" id="btnUpdateTop">
									<i class="fas fa-edit mr-1"></i>수정
								</button>
								<button type="button" class="btn btn-danger btn-sm ml-2" id="btnDeleteTop">
									<i class="fas fas-trash-alt mr-1"></i>삭제
								</button>

							</div>

						</div>

						<div class="card-body">
							<form id="submitForm" action="/approval24/delegate/${detail.seqNo}" method="post">
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
														<option value="<c:out value='${detail.delegateId}'/>">${detail.delegateId} | ${detail.delegateUserName}</option>
														<c:forEach var="acc" items="${accountList}">
															<c:if test="${acc.accountId ne null and acc.userName ne null}">
																<option value="${acc.accountId}">${acc.userNo}|${acc.userName}</option>
															</c:if>
														</c:forEach>
												</select></td>
												<th>사유</th>
												<td><input type="text" name="proxyComment" id="proxyComment" class="form-control form-control-sm" placeholder="대결자 지정사유를 입력하세요" required value="<c:out value='${detail.proxyComment}'/>" /></td>

											</tr>

											<!--등록일-->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">시작일</th>
												<td><input type="date" class="form-control" name="startDt" value="${detail.startDt}" /></td>
												<th>종료일</th>
												<td><input type="date" class="form-control" name="endDt" class="form-control" value="${detail.endDt}" /></td>
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
		$(document)
				.ready(
						function() {
							const $updateForm = $('#submitForm');
							const updateActionUrl = $updateForm.attr('action');
							const deleteActionUrl = '/approval24/delegate/${detail.seqNo}/delete';

							const $textInputs = $updateForm
									.find('input:not([type=button]):not([type=hidden]):not([type=checkbox]):not([type=radio]):not([type=file]), textarea');
							const $choiceInputs = $updateForm
									.find('select, input[type=checkbox], input[type=radio], input[type=file]');
							const $addressButton = $('#btnSearchAddress');

							function setEditMode(isEdit) {

								$textInputs.prop('readonly', !isEdit);
								$choiceInputs.prop('disabled', !isEdit);

								const $btn = $('#btnUpdateTop');
								if (isEdit) {
									$btn
											.html(
													'<i class="fas fa-save mr-1"></i>저장')
											.removeClass('btn-primary')
											.addClass('btn-success');
								} else {
									$btn
											.html(
													'<i class="fas fa-edit mr-1"></i>수정')
											.removeClass('btn-success')
											.addClass('btn-primary');
								}
							}

							// 2) 초기 상태
							setEditMode(false);

							// 3) 수정/저장 토글
							$('#btnUpdateTop').on(
									'click',
									function() {
										const isReadOnlyNow = $textInputs
												.first().prop('readonly'); // 현재 읽기전용이면 수정모드로
										if (isReadOnlyNow) {
											// 수정 모드 진입
											setEditMode(true);
										} else {
											// 저장
											if (confirm('수정된 내용을 저장하시겠습니까?')) {
												$choiceInputs.prop('disabled',
														false);
												if ($addressButton.length)
													$addressButton.prop(
															'disabled', false);

												$updateForm.attr('action',
														updateActionUrl);
												$updateForm.submit();
											}
										}
									});

							// 4) 삭제
							$('#btnDeleteTop').on(
									'click',
									function() {
										if (confirm('대결자 지정을 삭제하시겠습니까?')) {
											$textInputs.prop('readonly', true);
											$choiceInputs
													.prop('disabled', true);

											$updateForm.attr('action',
													deleteActionUrl);
											$updateForm.submit();
										}
									});
						});

		//2. 폼 제출 로직 (btnUpdateTop)
		//- 버튼이 폼 외부에 있으므로, 클릭 시 명시적으로 폼 제출
		$(document).ready(function() {

			// 폼 외부에 있는 등록 버튼 클릭 시 폼 제출
			$('#btnUpdateTop').on('click', function(e) {

				if (!form.checkValidity()) {
					// 유효성 검사 실패 시 브라우저가 기본 동작을 수행하고 제출 중단
					return;
				}

				// 폼 제출
				$('#').submit();
			});
		});
	</script>

</body>
</html>
