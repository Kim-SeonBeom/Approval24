<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

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
					<h1 class="h3 mb-2 text-gray-800">공통코드 목록</h1>
					<br>
					<%-- 컨트롤러에서 전달받은 삭제 메시지 표시 --%>
					<c:if test="${not empty delMessage}">
					    <div class="alert alert-info alert-dismissible fade show" role="alert">
					        ${delMessage}
					        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					        </button>
					    </div>
					</c:if>
					<c:if test="${not empty insertMessage}">
					    <div class="alert alert-info alert-dismissible fade show" role="alert">
					        ${insertMessage}
					        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					        </button>
					    </div>
					</c:if>
					
					<!-- 코드 테이블 조건 -->
					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">공통코드 테이블</h6>
							<!-- 그룹 선택 -->
	                        <div class="ml-4">
	                           <select id="groupFilter" class="custom-select custom-select-sm form-control form-control-sm" style="min-width: 160px;">
	                              <option value="">전체 그룹</option>
	                              <!-- 옵션은 JS에서 테이블 데이터를 읽어 자동 생성 -->
	                           </select>
	                        </div>
							<button class="btn btn-primary btn-sm" id="codeCreate" style="font-size: 1rem; padding: 0.25rem 0.75rem;">+ 코드 등록</button>
						</div>
						
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" style="width:100%" cellspacing="0">
									<thead>
										<tr>
											<th>코드그룹ID</th>
											<th>코드ID</th>
											<th>코드명</th>
											<th>코드내용</th>
											<th>삭제여부</th>
										</tr>
									</thead>
									<tbody>
									  <c:forEach var="code" items="${getAllTotalCodeList}">
									    <tr class="clickable-row"
									        data-href="/approval24/admin/totalcode/detail?code_id=${code.codeId}"
									        style="cursor:pointer;">
									      <td>${code.groupId}</td>
									      <td>${code.codeId}</td>
									      <td>${code.codeName}</td>
									      <td>${code.codeDetail}</td>
									      <td>${code.delYn}</td>
									    </tr>
									  </c:forEach>
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
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<!-- footer 영역 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	
<script>
	$("#codeCreate").on('click', function() {
		window.location.href="${pageContext.request.contextPath}/admin/totalcode/new";
	});

  
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

       // URL 파라미터로 기본 그룹 지정 가능 (?group=CODE 같은 형태)
       var params = new URLSearchParams(location.search);
       var defaultGroup = params.get('group');
       if (defaultGroup && groups.includes(defaultGroup)) {
          $select.val(defaultGroup).trigger('change');
       }
    });
 </script>

</body>

</html>