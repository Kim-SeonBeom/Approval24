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
					    <div class="alert alert-danger alert-dismissible fade show" role="alert">
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
					
					<div class="card shadow mb-4">
					  <div class="card-header py-3 d-flex justify-content-between align-items-center">
					    <h6 class="m-0 font-weight-bold text-primary">검색 및 필터링</h6>
					    <button class="btn btn-primary btn-sm" type="submit" form="totalCodeFilterForm">검색</button>
					  </div>
					
					  <div class="card-body">
					    <form id="totalCodeFilterForm" action="${pageContext.request.contextPath}/totalcode" method="get">
					      
					      <!-- 1) 삭제여부 -->
					      <div class="form-group row align-items-center mb-3">
					        <label class="col-sm-2 col-form-label font-weight-bold text-center">삭제여부</label>
					        <div class="col-sm-10">
					          <div class="form-check form-check-inline">
					            <input class="form-check-input" type="radio" name="delYn" id="delY" value="Y"
					                   ${filter.delYn == 'Y' ? 'checked' : ''}>
					            <label class="form-check-label" for="delY">Y</label>
					          </div>
					          <div class="form-check form-check-inline">
					            <input class="form-check-input" type="radio" name="delYn" id="delN" value="N"
					                   ${filter.delYn == 'N' ? 'checked' : ''}>
					            <label class="form-check-label" for="delN">N</label>
					          </div>
					          <div class="form-check form-check-inline">
					            <input class="form-check-input" type="radio" name="delYn" id="delAll" value="ALL"
								       ${empty filter.delYn or filter.delYn == 'ALL' ? 'checked' : ''}>
								<label class="form-check-label" for="delAll">전체</label>
					          </div>
					        </div>
					      </div>
					
					      <!-- 2) 코드그룹ID -->
					      <div class="form-group row align-items-center mb-3">
					        <label for="groupId" class="col-sm-2 col-form-label font-weight-bold text-center">코드그룹ID</label>
					        <div class="col-sm-10">
					          <input type="text" class="form-control w-25" id="groupId" name="groupId"
					                 value="${filter.groupId}" placeholder="코드그룹Id 입력">
					        </div>
					      </div>
					
					      <!-- 3) 코드ID -->
					      <div class="form-group row align-items-center mb-3">
					        <label for="codeId" class="col-sm-2 col-form-label font-weight-bold text-center">코드ID</label>
					        <div class="col-sm-10">
					          <input type="text" class="form-control w-25" id="codeId" name="codeId"
					                 value="${filter.codeId}" placeholder="코드ID 입력">
					        </div>
					      </div>
					
					      <!-- 4) 코드명 -->
					      <div class="form-group row align-items-center mb-3">
					        <label for="codeName" class="col-sm-2 col-form-label font-weight-bold text-center">코드명</label>
					        <div class="col-sm-10">
					          <input type="text" class="form-control w-50" id="codeName" name="codeName"
					                 value="${filter.codeName}" placeholder="코드명 입력">
					        </div>
					      </div>
					      
					      <!-- 5) 코드내용 -->
					      <div class="form-group row align-items-center mb-3">
					        <label for="codeDetail" class="col-sm-2 col-form-label font-weight-bold text-center">코드내용</label>
					        <div class="col-sm-10">
					          <input type="text" class="form-control w-50" id="codeDetail" name="codeDetail"
					                 value="${filter.codeDetail}" placeholder="코드내용 입력">
					        </div>
					      </div>
					
					      <!-- 페이징 -->
					      <input type="hidden" name="page" id="page" value="${filter.page}">
					      <input type="hidden" name="size" value="${filter.size}">
					    </form>
					  </div>
					</div>
                    <br>
					
					<!-- 공통코드 테이블 -->
					<div class="card shadow mb-4">
					  <div class="card-header py-3 d-flex align-items-center justify-content-between">
					    <h6 class="m-0 font-weight-bold text-primary">공통코드 목록</h6>
					    <a class="btn btn-primary btn-sm" id="codeCreate"
					       href="${pageContext.request.contextPath}/totalcode/new"
					       style="font-size:1rem; padding:0.25rem 0.75rem;">+ 공통코드 등록</a>
					  </div>
					
					  <div class="card-body">
					    <!-- 빈 상태 안내 -->
					    <c:if test="${empty codeList}">
					      <div class="text-center text-muted py-4">
					        검색 조건을 입력하고 <b>검색</b>을 눌러주세요.
					      </div>
					    </c:if>
					
					    <c:if test="${not empty codeList}">
					      <div class="mb-2 text-left text-muted">
					        총 <b>${totalCount}</b>건
					      </div>
					
					      <div class="table-responsive">
					        <table class="table table-bordered table-hover table-sm text-center align-middle">
					          <thead class="thead-light">
					            <tr>
					              <th style="width:60px;">번호</th>
					              <th>코드그룹ID</th>
					              <th>코드ID</th>
					              <th>코드명</th>
					              <th>코드내용</th>
					              <th style="width:90px;">삭제여부</th>
					            </tr>
					          </thead>
					          <tbody>
					            <c:forEach var="item" items="${codeList}" varStatus="status">
					              <tr class="clickable-row"
					                  data-href="${pageContext.request.contextPath}/totalcode/detail?code_id=${item.codeId}"
					                  style="cursor:pointer;">
					                <td>${(filter.page - 1) * filter.size + status.index + 1}</td>
					                <td>${item.groupId}</td>
					                <td>${item.codeId}</td>
					                <td>${item.codeName}</td>
					                <td>${item.codeDetail}</td>
					                <td>
					                  <c:choose>
					                    <c:when test="${item.delYn == 'Y'}"><span class="badge badge-secondary">삭제</span></c:when>
					                    <c:when test="${item.delYn == 'N'}"><span class="badge badge-success">사용</span></c:when>
					                    <c:otherwise><span class="badge badge-light">${item.delYn}</span></c:otherwise>
					                  </c:choose>
					                </td>
					              </tr>
					            </c:forEach>
					          </tbody>
					        </table>
					      </div>
					
					      <!-- 페이지네이션 -->
					      <c:set var="curr" value="${filter.page}" />
					      <c:set var="last" value="${totalPages}" />
					      <nav aria-label="Page navigation" class="mt-3">
					        <ul class="pagination justify-content-center">
					          <!-- Prev -->
					          <li class="page-item ${curr <= 1 ? 'disabled' : ''}">
					            <a class="page-link"
					               href="<c:url value='/totalcode'>
					                        <c:param name='page' value='${curr-1}'/>
					                        <c:param name='size' value='${filter.size}'/>
					                        <c:if test='${not empty filter.groupId}'><c:param name='groupId' value='${filter.groupId}'/></c:if>
					                        <c:if test='${not empty filter.codeId}'><c:param name='codeId' value='${filter.codeId}'/></c:if>
					                        <c:if test='${not empty filter.codeName}'><c:param name='codeName' value='${filter.codeName}'/></c:if>
					                    	<c:if test='${not empty filter.codeDetail}'><c:param name='codeDetail' value='${filter.codeDetail}'/></c:if>
					                    	<c:if test='${not empty filter.delYn}'><c:param name='delYn' value='${filter.delYn}'/></c:if>
					                    </c:url>">이전</a>
					          </li>
					
					          <!-- Pages -->
					          <c:forEach begin="1" end="${last}" var="p">
					            <li class="page-item ${p == curr ? 'active' : ''}">
					              <a class="page-link"
					                 href="<c:url value='/totalcode'>
					                          <c:param name='page' value='${p}'/>
					                          <c:param name='size' value='${filter.size}'/>
					                          <c:if test='${not empty filter.groupId}'><c:param name='groupId' value='${filter.groupId}'/></c:if>
					                          <c:if test='${not empty filter.codeId}'><c:param name='codeId' value='${filter.codeId}'/></c:if>
					                          <c:if test='${not empty filter.codeName}'><c:param name='codeName' value='${filter.codeName}'/></c:if>
					                      	  <c:if test='${not empty filter.codeDetail}'><c:param name='codeDetail' value='${filter.codeDetail}'/></c:if>
					                      	  <c:if test='${not empty filter.delYn}'><c:param name='delYn' value='${filter.delYn}'/></c:if>
					                      </c:url>">${p}</a>
					            </li>
					          </c:forEach>
					
					          <!-- Next -->
					          <li class="page-item ${curr >= last ? 'disabled' : ''}">
					            <a class="page-link"
					               href="<c:url value='/totalcode'>
					                        <c:param name='page' value='${curr+1}'/>
					                        <c:param name='size' value='${filter.size}'/>
					                        <c:if test='${not empty filter.groupId}'><c:param name='groupId' value='${filter.groupId}'/></c:if>
					                        <c:if test='${not empty filter.codeId}'><c:param name='codeId' value='${filter.codeId}'/></c:if>
					                        <c:if test='${not empty filter.codeName}'><c:param name='codeName' value='${filter.codeName}'/></c:if>
					                        <c:if test='${not empty filter.codeDetail}'><c:param name='codeDetail' value='${filter.codeDetail}'/></c:if>
					                    	<c:if test='${not empty filter.delYn}'><c:param name='delYn' value='${filter.delYn}'/></c:if>
					                    </c:url>">다음</a>
					          </li>
					        </ul>
					      </nav>
					    </c:if>
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

  
	// 테이블 행 클릭 시 상세로 이동
	document.addEventListener('click', function (e) {
	  const tr = e.target.closest('.clickable-row');
	  if (tr && tr.dataset.href) {
	    location.href = tr.dataset.href;
	  }
	});
 </script>

</body>

</html>