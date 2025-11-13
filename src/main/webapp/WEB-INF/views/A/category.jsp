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
					<h1 class="h3 mb-2 text-gray-800">민원서식 목록</h1>
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
					
					<div class="card shadow mb-4">
					  <div class="card-header py-3 d-flex justify-content-between align-items-center">
					    <h6 class="m-0 font-weight-bold text-primary">검색 및 필터링</h6>
					    <button class="btn btn-primary btn-sm" type="submit" form="categoryFilterForm">검색</button>
					  </div>
					
					  <div class="card-body">
					    <form id="categoryFilterForm" action="${pageContext.request.contextPath}/category" method="get">
					      
					      <!-- 1) 등록/수정일 검색 -->
					      <div class="form-group row align-items-center mb-3">
					        <label class="col-sm-2 col-form-label font-weight-bold text-center">등록/수정일</label>
					        <div class="col-sm-10">
					          <div class="form-inline">
					            <select class="form-control mr-2" id="dateType" name="dateType" style="width:120px;">
					              <option value="createDt" ${filter.dateType == 'createDt' ? 'selected' : ''}>등록일</option>
					              <option value="updateDt" ${filter.dateType == 'updateDt' ? 'selected' : ''}>수정일</option>
					            </select>
					            <input type="date" class="form-control mr-2" id="createDt" name="createDt"
					                   value="${filter.createDt}" style="width:180px;">
					            <span class="mx-1">~</span>
					            <input type="date" class="form-control ml-2" id="updateDt" name="updateDt"
					                   value="${filter.updateDt}" style="width:180px;">
					          </div>
					        </div>
					      </div>
					      
					      <!-- 2) 처리 소요일(due_dt) 기간 -->
						  <div class="form-group row align-items-center mb-3">
						    <label class="col-sm-2 col-form-label font-weight-bold text-center">처리 소요일</label>
						    <div class="col-sm-10">
						      <div class="form-inline">
						        <input type="number" class="form-control mr-2" name="dueStart" value="${filter.dueStart}" placeholder="숫자만 입력" style="width:180px;">
						        <span class="mx-1">~</span>
						        <input type="number" class="form-control ml-2" name="dueEnd" value="${filter.dueEnd}" placeholder="숫자만 입력" style="width:180px;">
						      </div>
						    </div>
						  </div>
						  
					      <!-- 3) 삭제여부 -->
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
					            <input class="form-check-input" type="radio" name="delYn" id="delAll" value=""
					                   ${empty filter.delYn ? 'checked' : ''}>
					            <label class="form-check-label" for="delAll">전체</label>
					          </div>
					        </div>
					      </div>
					
					      <!-- 4) 민원서식명(공통코드에서 codeName) -->
					      <div class="form-group row align-items-center mb-3">
					        <label for="codeName" class="col-sm-2 col-form-label font-weight-bold text-center">민원서식명</label>
					        <div class="col-sm-10">
					          <input type="text" class="form-control w-25" id="codeName" name="codeName"
					                 value="${filter.codeName}" placeholder="민원서식명 입력">
					        </div>
					      </div>
					
					      <!-- 5) 유형코드 -->
					      <div class="form-group row align-items-center mb-3">
					        <label for="codeId" class="col-sm-2 col-form-label font-weight-bold text-center">유형코드명</label>
					        <div class="col-sm-10">
					          <input type="text" class="form-control w-25" id="codeId" name="codeId"
					                 value="${filter.codeId}" placeholder="유형코드 입력">
					        </div>
					      </div>
					
					      <!-- 6) 민원서식 URL -->
					      <div class="form-group row align-items-center mb-3">
					        <label for="categoryUrl" class="col-sm-2 col-form-label font-weight-bold text-center">민원서식 URL</label>
					        <div class="col-sm-10">
					          <input type="text" class="form-control w-50" id="categoryUrl" name="categoryUrl"
					                 value="${filter.categoryUrl}" placeholder="민원서식 URL 입력">
					        </div>
					      </div>
					
					      <!-- 페이징 -->
					      <input type="hidden" name="page" id="page" value="${filter.page}">
					      <input type="hidden" name="size" value="${filter.size}">
					    </form>
					  </div>
					</div>
                    <br>
					
					<!-- 민원서식 테이블 -->
					<div class="card shadow mb-4">
					  <div class="card-header py-3 d-flex align-items-center justify-content-between">
					    <h6 class="m-0 font-weight-bold text-primary">민원서식 목록</h6>
					    <a class="btn btn-primary btn-sm" id="categoryCreate"
					       href="${pageContext.request.contextPath}/category/new"
					       style="font-size:1rem; padding:0.25rem 0.75rem;">+ 민원서식 등록</a>
					  </div>
					
					  <div class="card-body">
					    <!-- 빈 상태 안내 -->
					    <c:if test="${empty categoryList}">
					      <div class="text-center text-muted py-4">
					        검색 조건을 입력하고 <b>검색</b>을 눌러주세요.
					      </div>
					    </c:if>
					
					    <c:if test="${not empty categoryList}">
					      <div class="mb-2 text-left text-muted">
					        총 <b>${totalCount}</b>건
					      </div>
					
					      <div class="table-responsive">
					        <table class="table table-bordered table-hover table-sm text-center align-middle">
					          <thead class="thead-light">
					            <tr>
					              <th style="width:60px;">번호</th>
					              <th>민원서식명</th>
					              <th>유형코드</th>
					              <th>처리 소요일</th>
					              <th style="width:140px;">민원서식 URL</th>
					              <th style="width:120px;">등록일</th>
					              <th style="width:120px;">수정일</th>
					              <th style="width:90px;">삭제여부</th>
					            </tr>
					          </thead>
					          <tbody>
					            <c:forEach var="item" items="${categoryList}" varStatus="status">
					              <tr class="clickable-row"
					                  data-href="${pageContext.request.contextPath}/category/detail?complain_category_id=${item.complainCategoryId}"
					                  style="cursor:pointer;">
					                <td>${(filter.page - 1) * filter.size + status.index + 1}</td>
					                <td class="text-left pl-3">${item.codeName}</td>
					                <td>${item.codeId}</td>
					                <td>${item.dueDt}</td>
					                <td>${item.categoryUrl}</td>
					                <td>${item.createDt}</td>
					                <td>${item.updateDt}</td>
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
					               href="<c:url value='/category'>
					                        <c:param name='page' value='${curr-1}'/>
					                        <c:param name='size' value='${filter.size}'/>
					                        <c:if test='${not empty filter.dateType}'><c:param name='dateType' value='${filter.dateType}'/></c:if>
					                        <c:if test='${not empty filter.createDt}'><c:param name='createDt' value='${filter.createDt}'/></c:if>
					                        <c:if test='${not empty filter.updateDt}'><c:param name='updateDt' value='${filter.updateDt}'/></c:if>
					                        <c:if test='${not empty filter.dueDt}'><c:param name='dueDt' value='${filter.dueDt}'/></c:if>
					                        <c:if test='${not empty filter.delYn}'><c:param name='delYn' value='${filter.delYn}'/></c:if>
					                        <c:if test='${not empty filter.codeName}'><c:param name='codeName' value='${filter.codeName}'/></c:if>
					                        <c:if test='${not empty filter.codeId}'><c:param name='codeId' value='${filter.codeId}'/></c:if>
					                        <c:if test='${not empty filter.categoryUrl}'><c:param name='categoryUrl' value='${filter.categoryUrl}'/></c:if>
					                    </c:url>">이전</a>
					          </li>
					
					          <!-- Pages -->
					          <c:forEach begin="1" end="${last}" var="p">
					            <li class="page-item ${p == curr ? 'active' : ''}">
					              <a class="page-link"
					                 href="<c:url value='category'>
					                          <c:param name='page' value='${p}'/>
					                          <c:param name='size' value='${filter.size}'/>
					                          <c:if test='${not empty filter.dateType}'><c:param name='dateType' value='${filter.dateType}'/></c:if>
						                      <c:if test='${not empty filter.createDt}'><c:param name='createDt' value='${filter.createDt}'/></c:if>
						                      <c:if test='${not empty filter.updateDt}'><c:param name='updateDt' value='${filter.updateDt}'/></c:if>
						                      <c:if test='${not empty filter.dueDt}'><c:param name='dueDt' value='${filter.dueDt}'/></c:if>
						                      <c:if test='${not empty filter.delYn}'><c:param name='delYn' value='${filter.delYn}'/></c:if>
						                      <c:if test='${not empty filter.codeName}'><c:param name='codeName' value='${filter.codeName}'/></c:if>
						                      <c:if test='${not empty filter.codeId}'><c:param name='codeId' value='${filter.codeId}'/></c:if>
						                      <c:if test='${not empty filter.categoryUrl}'><c:param name='categoryUrl' value='${filter.categoryUrl}'/></c:if>
					                      </c:url>">${p}</a>
					            </li>
					          </c:forEach>
					
					          <!-- Next -->
					          <li class="page-item ${curr >= last ? 'disabled' : ''}">
					            <a class="page-link"
					               href="<c:url value='/insts'>
					                        <c:param name='page' value='${curr+1}'/>
					                        <c:param name='size' value='${filter.size}'/>
					                        <c:if test='${not empty filter.dateType}'><c:param name='dateType' value='${filter.dateType}'/></c:if>
					                        <c:if test='${not empty filter.createDt}'><c:param name='createDt' value='${filter.createDt}'/></c:if>
					                        <c:if test='${not empty filter.updateDt}'><c:param name='updateDt' value='${filter.updateDt}'/></c:if>
					                        <c:if test='${not empty filter.dueDt}'><c:param name='dueDt' value='${filter.dueDt}'/></c:if>
					                        <c:if test='${not empty filter.delYn}'><c:param name='delYn' value='${filter.delYn}'/></c:if>
					                        <c:if test='${not empty filter.codeName}'><c:param name='codeName' value='${filter.codeName}'/></c:if>
					                        <c:if test='${not empty filter.codeId}'><c:param name='codeId' value='${filter.codeId}'/></c:if>
					                        <c:if test='${not empty filter.categoryUrl}'><c:param name='categoryUrl' value='${filter.categoryUrl}'/></c:if>
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
	$("#categoryCreate").on('click', function() {
		window.location.href="${pageContext.request.contextPath}/admin/category/new";
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