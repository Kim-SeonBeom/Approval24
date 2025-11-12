<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<body id="page-top">

<div id="wrapper">
	<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

	<div id="content-wrapper" class="d-flex flex-column">
		<div id="content">
			<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

			<div class="container-fluid">
				<h1 class="h3 mb-4 text-gray-800">권한 조회</h1>

				<div class="card mb-4">
					<div class="card-body d-flex align-items-center">
						<label class="mr-2 font-weight-bold">부서 선택</label>
						<select id="deptSelect" class="form-control w-auto mr-3">
							<option value="">-- 부서 선택 --</option>
							<option value="인사팀">인사팀</option>
							<option value="총무팀">총무팀</option>
							<option value="전산팀">전산팀</option>
						</select>
						<button id="searchBtn" class="btn btn-primary btn-sm">조회</button>
					</div>
				</div>

				<div id="resultArea">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">권한 목록</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>권한 이름</th>
											<th>메뉴명</th>
											<th>조회</th>
											<th>수정</th>
											<th>삭제</th>
											<th>관리</th>
										</tr>
									</thead>
									<tbody id="authorityTableBody">
										<tr>
											<td>인사관리권한</td>
											<td>직원 관리</td>
											<td>Y</td>
											<td>Y</td>
											<td>N</td>
											<td><button class="btn btn-sm btn-outline-primary editBtn" data-id="1">수정</button></td>
										</tr>
										<tr>
											<td>급여관리권한</td>
											<td>급여 내역</td>
											<td>Y</td>
											<td>N</td>
											<td>N</td>
											<td><button class="btn btn-sm btn-outline-primary editBtn" data-id="2">수정</button></td>
										</tr>
										<tr>
											<td>자산관리권한</td>
											<td>비품 등록</td>
											<td>Y</td>
											<td>Y</td>
											<td>Y</td>
											<td><button class="btn btn-sm btn-outline-primary editBtn" data-id="3">수정</button></td>
										</tr>
										<tr>
											<td>시설관리권한</td>
											<td>시설 점검</td>
											<td>Y</td>
											<td>Y</td>
											<td>N</td>
											<td><button class="btn btn-sm btn-outline-primary editBtn" data-id="4">수정</button></td>
										</tr>
										<tr>
											<td>시스템관리권한</td>
											<td>서버 설정</td>
											<td>Y</td>
											<td>Y</td>
											<td>Y</td>
											<td><button class="btn btn-sm btn-outline-primary editBtn" data-id="5">수정</button></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>

<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

<script>
window.addEventListener("DOMContentLoaded", function() {

	// 부서 선택과 조회 버튼은 더 이상 기능하지 않습니다.

	// 수정 버튼 클릭 시 페이지 이동만 처리
	document.addEventListener("click", function(e) {
		if (e.target.classList.contains("editBtn")) {
			// **주의:** 실제 프로젝트에서는 data-id 값을 이용해 해당 권한의 상세 페이지로 이동해야 합니다.
			window.location.href = "${pageContext.request.contextPath}/authorityEdit";
		}
	});

    // ⛔ Chart.js 오류를 피하기 위해, 이 페이지에서는 chart-*-demo.js 파일 로드를 막아야 합니다.
    // 이는 footer.jsp에서 해당 스크립트 태그를 주석 처리하거나, 이 페이지에서만 로드되지 않도록 조건문을 설정해야 합니다.
});
</script>
</body>
</html>