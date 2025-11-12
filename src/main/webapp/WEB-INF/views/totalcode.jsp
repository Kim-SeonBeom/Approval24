<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>공통 코드 관리 | 결재24</title>
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
					<h1 class="h3 mb-2 text-gray-800">공통 코드 관리</h1>
					<p class="mb-4 text-secondary">시스템 전역에서 사용하는 코드 정보를 등록·관리합니다.</p>

					<!-- DataTable -->
					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center justify-content-between">
							<div class="d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">공통 코드 목록</h6>
								<!-- 그룹 선택 -->
								<div class="ml-3">
									<select id="groupFilter" class="custom-select custom-select-sm form-control form-control-sm" style="min-width: 160px;">
										<option value="">전체 그룹</option>
										<!-- 옵션은 JS에서 테이블 데이터를 읽어 자동 생성 -->
									</select>
								</div>
							</div>

							<button class="btn btn-primary btn-sm" id="btnAddCode">
								<i class="fas fa-plus mr-1"></i> 신규 등록
							</button>
						</div>
						

						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>그룹코드</th>
											<th>상세코드</th>
											<th>코드명</th>
											<th>코드상세</th>
											<th>등록일</th>
											<th>사용여부</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>DEPT</td>
											<td>D001</td>
											<td>인사팀</td>
											<td>인사 및 채용 관련 부서</td>
											<td>2025-10-01</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>DEPT</td>
											<td>D002</td>
											<td>총무팀</td>
											<td>예산 및 자산 관리 부서</td>
											<td>2025-10-01</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>DEPT</td>
											<td>D003</td>
											<td>고객지원팀</td>
											<td>민원 응대 및 고객 서비스 담당</td>
											<td>2025-10-02</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>AUTH</td>
											<td>A001</td>
											<td>관리자</td>
											<td>시스템 전체 접근 권한 보유</td>
											<td>2025-10-02</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>AUTH</td>
											<td>A002</td>
											<td>검토자</td>
											<td>결재문서 검토 가능</td>
											<td>2025-10-02</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>AUTH</td>
											<td>A003</td>
											<td>승인자</td>
											<td>결재문서 승인 가능</td>
											<td>2025-10-03</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>AUTH</td>
											<td>A004</td>
											<td>일반사용자</td>
											<td>민원/결재 등록만 가능</td>
											<td>2025-10-03</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>APPROVAL</td>
											<td>S001</td>
											<td>기안</td>
											<td>결재 상신 전 상태</td>
											<td>2025-10-04</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>APPROVAL</td>
											<td>S002</td>
											<td>검토중</td>
											<td>중간 검토 단계</td>
											<td>2025-10-04</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>APPROVAL</td>
											<td>S003</td>
											<td>승인완료</td>
											<td>모든 결재 절차 완료</td>
											<td>2025-10-04</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>COMPLAIN</td>
											<td>C001</td>
											<td>실업급여</td>
											<td>실업급여 관련 민원 코드</td>
											<td>2025-10-05</td>
											<td>Y</td>
											<td></td>
										</tr>
										<tr>
											<td>COMPLAIN</td>
											<td>C002</td>
											<td>출산휴가</td>
											<td>출산휴가 및 육아휴직 관련 코드</td>
											<td>2025-10-05</td>
											<td>Y</td>
											<td></td>
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


		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<!-- footer -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script>
	
		//그룹별 보기 스크립트
		$(function() {
			// 기존 데모 스크립트가 있으면 중복 초기화되지 않도록 확인
			var table = $.fn.dataTable.isDataTable('#dataTable') ? $(
					'#dataTable').DataTable() : $('#dataTable').DataTable({
			// 필요시 옵션 (페이지 길이, 언어 등) 추가
			// pageLength: 10,
			// searching: true,
			// order: []  // 초기 정렬 없애고 싶으면 주석 해제
			});

			// 1열(0-index) = 그룹코드 컬럼
			var groupCol = table.column(0);
			var $select = $('#groupFilter');

			// 현재 테이블 데이터에서 고유 그룹코드 추출하여 옵션 자동 생성
			// (Ajax가 아니라 서버 렌더 테이블일 때 유용)
			var groups = groupCol.data().unique().sort().toArray();
			groups.forEach(function(g) {
				if (!g || typeof g !== 'string')
					return;
				$select.append('<option value="' + g + '">' + g + '</option>');
			});

			// 셀렉트 변경 시 해당 그룹만 정규식 완전일치로 필터
			$select
					.on('change',
							function() {
								var val = $(this).val();
								// 정규식 특수문자 이스케이프
								var esc = $.fn.dataTable.util.escapeRegex(val);
								groupCol.search(val ? '^' + esc + '$' : '',
										true, false).draw();
							});

			// URL 파라미터로 기본 그룹 지정 가능 (?group=DEPT 같은 형태)
			var params = new URLSearchParams(location.search);
			var defaultGroup = params.get('group');
			if (defaultGroup && groups.includes(defaultGroup)) {
				$select.val(defaultGroup).trigger('change');
			}
		});
	</script>

</body>
</html>
