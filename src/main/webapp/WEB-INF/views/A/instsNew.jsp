<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>기관 등록 | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">기관 등록</h1>
					</div>

					<!-- 카드 -->
					<div class="card shadow mb-4">

						<!-- 상단 버튼 영역: 등록 -->
						<div class="card-header py-3 d-flex align-items-center">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">작성 항목</h6>
							<div class="ml-auto">
								<button type="submit" class="btn btn-primary btn-sm" id="btnSaveTop">
									<i class="fas fa-save mr-1"></i>등록
								</button>
								<a href="${pageContext.request.contextPath}/admin/insts" class="btn btn-danger btn-sm">취소</a>
							</div>

						</div>


						<div class="card-body">
							<form id="instInsertForm" action="/approval24/admin/insts/new" method="post">
							

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
												<td colspan="3"><input type="text" name="instName" id="instName" class="form-control form-control-sm" placeholder="공지 제목을 입력하세요" required maxlength="200"></td>
											</tr>

											<!-- 작성자 / 등록일 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">대표자명</th>
												<td><input type="text" name="instHeadName" id="instHeadName" class="form-control form-control-sm" placeholder="홍길동" required></td>
												<th>기관 등록일</th>
												<td><input type="date" class="form-control"
													name="createDt"></td>
											</tr>

											<!-- 내용 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold"
													style="vertical-align: middle;">주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text" class="form-control form-postal-code mr-2"
															placeholder="우편번호" name="instPost"
															id="instPost" readonly style="width: 150px;">
						
														<button type="button" class="btn btn-secondary"
															onclick="openDaumPostcode()">주소 검색</button>
													</div> <input type="text" class="form-control mb-2" placeholder="기본 주소"
													name="instAddress" id="instAddress" readonly>
													<input type="text" class="form-control"
													placeholder="상세 주소 (건물명, 동/호수 등)" name="instDetailAddress"
													id="instDetailAddress">
												</td>
											</tr>

											<!-- 연락처 -->
											<tr>
												<th>기관 연락처</th>
												<td colspan="3"><input type="tel" class="form-control"
													name="instPhone" placeholder="010-xxxx-xxxx"></td>
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
// 1. Daum Postcode API 함수 (openDaumPostcode)
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // R: 도로명, J: 지번
            const addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
            
            // 우편번호 (ID: instPost)
            document.getElementById('instPost').value = data.zonecode; 
            
            // 기본 주소 (ID: instAddress)
            document.getElementById('instAddress').value = addr;
            
            // 상세 주소 입력창에 포커스 (ID: instDetailAddress)
            document.getElementById('instDetailAddress').focus();
        }
    }).open();
}

// 2. 폼 제출 로직 (btnSaveTop)
//    - 버튼이 폼 외부에 있으므로, 클릭 시 명시적으로 폼 제출
$(document).ready(function() {
    
    // 폼 외부에 있는 등록 버튼 클릭 시 폼 제출
    $('#btnSaveTop').on('click', function(e) {
        
        const form = document.getElementById('instInsertForm');
        
        if (!form.checkValidity()) {
             // 유효성 검사 실패 시 브라우저가 기본 동작을 수행하고 제출 중단
             return; 
        }
        
        // 폼 제출
        $('#instInsertForm').submit();
    });
});
</script>

</body>
</html>
