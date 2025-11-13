<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <style>
        .sortable { cursor: pointer; }
        .sort-icon { margin-left: 5px; }
    </style>
    <title>권한 목록</title>
</head>
<body id="page-top">

<div id="wrapper">

    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">

            <%@ include file="/WEB-INF/views/common/navbar.jsp"%>
            <div class="container-fluid">
                <h1 class="h3 mb-2 text-gray-800">권한 관리</h1>
                <br>

                <div class="card shadow mb-4">
					  <div class="card-header py-3 d-flex justify-content-between align-items-center">
					    <h6 class="m-0 font-weight-bold text-primary">검색 및 필터링</h6>
					    <button class="btn btn-primary btn-sm" type="submit" form="AuthorityFilterForm">검색</button>
					  </div>
					
					  <div class="card-body">
					    <form id="AuthorityFilterForm" action="${pageContext.request.contextPath}/authority/list" method="get">
					      
					      <!-- 1) 생성/수정일 검색 -->
					      <div class="form-group row align-items-center mb-3">
					        <label class="col-sm-2 col-form-label font-weight-bold text-center">생성/수정일</label>
					        <div class="col-sm-10">
					          <div class="form-inline" >
					            <select class="form-control mr-2" id="dateType" name="dateType" style="width:130px;">
					              <option value="createDt" ${filter.dateType == 'createDt' ? 'selected' : ''}>등록일</option>
					              <option value="updateDt" ${filter.dateType == 'updateDt' ? 'selected' : ''}>수정일</option>
					            </select>
					            <input type="date" class="form-control mr-2 ml-3" id="createDt" name="createDtStr"
								       value="<fmt:formatDate value='${filter.createDt}' pattern='yyyy-MM-dd'/>" style="width:180px;">
								       <span class="mx-1">~</span>
								<input type="date" class="form-control ml-2" id="updateDt" name="updateDtStr"
								       value="<fmt:formatDate value='${filter.updateDt}' pattern='yyyy-MM-dd'/>" style="width:180px;">

					          </div>
					        </div>
					      </div>
					
					      <!-- 2) 삭제여부 -->
					      <div class="form-group row align-items-center mb-3">
					        <label class="col-sm-2 col-form-label font-weight-bold text-center">삭제여부</label>
					        <div class="col-sm-10">
					          <div class="form-check form-check-inline">
					            <input class="form-check-input" type="radio" name="delYn" id="delY" value="Y"
					                   ${filter.delYn == 'Y' ? 'checked' : ''}>
					            <label class="form-check-label" for="delY">삭제</label>
					          </div>
					          <div class="form-check form-check-inline">
					            <input class="form-check-input" type="radio" name="delYn" id="delN" value="N"
					                   ${filter.delYn == 'N' ? 'checked' : ''}>
					            <label class="form-check-label" for="delN">사용</label>
					          </div>
					          <div class="form-check form-check-inline">
					            <input class="form-check-input" type="radio" name="delYn" id="delAll" value=""
					                   ${empty filter.delYn ? 'checked' : ''}>
					            <label class="form-check-label" for="delAll">전체</label>
					          </div>
					        </div>
					      </div>
					      
					      
					      <!-- 시스템권한 -->
							<div class="form-group row align-items-center mb-3">
							  <label class="col-sm-2 col-form-label font-weight-bold text-center">시스템권한</label>
							  <div class="col-sm-10">
							    <div class="form-check form-check-inline">
							      <input class="form-check-input" type="radio" name="isSystem" id="isSystemY" value="Y"
							             ${filter.isSystem == 'Y' ? 'checked' : ''}>
							      <label class="form-check-label" for="isSystemY">시스템</label>
							    </div>
							    <div class="form-check form-check-inline">
							      <input class="form-check-input" type="radio" name="isSystem" id="isSystemN" value="N"
							             ${filter.isSystem == 'N' ? 'checked' : ''}>
							      <label class="form-check-label" for="isSystemN">일반사용자</label>
							    </div>
							    <div class="form-check form-check-inline">
							      <input class="form-check-input" type="radio" name="isSystem" id="isSystemAll" value=""
							             ${empty filter.isSystem ? 'checked' : ''}>
							      <label class="form-check-label" for="isSystemAll">전체</label>
							    </div>
							  </div>
							</div>

					
					      <!-- 3) 권한명 -->
					      <div class="form-group row align-items-center mb-3">
					        <label for="authorityName" class="col-sm-2 col-form-label font-weight-bold text-center">권한명</label>
					        <div class="col-sm-10">
					          <input type="text" class="form-control w-25" id="authorityName" name="authorityName"
					                 value="${filter.authorityName}" placeholder="권한명 입력">
					        </div>
					      </div>
					
					      <!-- 페이징 -->
					      <input type="hidden" name="page" id="page" value="${filter.page}">
					      <input type="hidden" name="size" value="${filter.size}">
					    </form>
					  </div>
					</div>
				
				<!-- 권한 테이블 -->
                <div class="card shadow mb-4">
					  <div class="card-header py-3 d-flex align-items-center justify-content-between">
					    <h6 class="m-0 font-weight-bold text-primary">전체 권한 목록</h6>
					    <a class="btn btn-primary btn-sm" id="authorityCreate"
					       href="${pageContext.request.contextPath}/authority/create"
					       style="font-size:1rem; padding:0.25rem 0.75rem;">+ 권한 등록</a>
					  </div>
					
					  <div class="card-body">
					    <!-- 빈 상태 안내 -->
					    <c:if test="${empty authorityList}">
					      <div class="text-center text-muted py-4">
					        검색 조건을 입력하고 <b>검색</b>을 눌러주세요.
					      </div>
					    </c:if>
					
					    <c:if test="${not empty authorityList}">
					      <div class="mb-2 text-left text-muted">
					        총 <b>${totalCount}</b>건
					      </div>
					
					      <div class="table-responsive">
					        <table class="table table-bordered table-hover table-sm text-center align-middle">
					          <thead class="thead-light">
					            <tr>
					              <th style="width:60px;">번호</th>
					              <th>권한명</th>
					              <th style="width:120px;">생성일</th>
					              <th style="width:120px;">수정일</th>
					              <th>시스템권한</th>
					              <th style="width:90px;">삭제여부</th>
					              <th>관리</th>
					            </tr>
					          </thead>
					          <tbody>
					            <c:forEach var="item" items="${authorityList}" varStatus="status">
					              <tr class="clickable-row"
					                  data-href="${pageContext.request.contextPath}/authority/detail/${item.authorityId}"
					                  style="cursor:pointer;">
					                <td>${(filter.page - 1) * filter.size + status.index + 1}</td>
					                <td class="text-left pl-3">${item.authorityName}</td>
					                <td><fmt:formatDate value="${item.createDt}" pattern="yyyy-MM-dd"/></td>
					                <td><fmt:formatDate value="${item.updateDt}" pattern="yyyy-MM-dd"/></td>
					                <td>${item.isSystem}</td>
					                <td>
					                  <c:choose>
					                    <c:when test="${item.delYn == 'Y'}"><span class="badge badge-secondary">삭제</span></c:when>
					                    <c:when test="${item.delYn == 'N'}"><span class="badge badge-success">사용</span></c:when>
					                    <c:otherwise><span class="badge badge-light">${item.delYn}</span></c:otherwise>
					                  </c:choose>
					                </td>
					                <td>
									  <a class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/authority/edit/${item.authorityId}">수정</a>
									  <form action="${pageContext.request.contextPath}/authority/delete/${item.authorityId}"
									        method="post" style="display:inline"
									        onsubmit="return confirm('정말로 권한 [${item.authorityName}]을(를) 삭제하시겠습니까?');">
									    <button type="submit" class="btn btn-sm btn-danger">삭제</button>
									  </form>
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
					               href="<c:url value='/authority/list'>
					                        <c:param name='page' value='${curr-1}'/>
					                        <c:param name='size' value='${filter.size}'/>
					                        <c:if test='${not empty filter.dateType}'><c:param name='dateType' value='${filter.dateType}'/></c:if>
					                        <c:if test='${not empty filter.createDt}'><c:param name='createDtStr' value='${filter.createDt}'/></c:if>
					                        <c:if test='${not empty filter.updateDt}'><c:param name='updateDtStr' value='${filter.updateDt}'/></c:if>
					                        <c:if test='${not empty filter.delYn}'><c:param name='delYn' value='${filter.delYn}'/></c:if>
					                        <c:if test='${not empty filter.authorityName}'><c:param name='authorityName' value='${filter.authorityName}'/></c:if>
					                        <c:if test='${not empty filter.isSystem}'><c:param name='isSystem' value='${filter.isSystem}'/></c:if>
					                    </c:url>">이전</a>
					          </li>
					
					          <!-- Pages -->
					          <c:forEach begin="1" end="${last}" var="p">
					            <li class="page-item ${p == curr ? 'active' : ''}">
					              <a class="page-link"
					                 href="<c:url value='/authority/list'>
					                        <c:param name='page' value='${curr-1}'/>
					                        <c:param name='size' value='${filter.size}'/>
					                        <c:if test='${not empty filter.dateType}'><c:param name='dateType' value='${filter.dateType}'/></c:if>
					                        <c:if test='${not empty filter.createDt}'><c:param name='createDtStr' value='${filter.createDt}'/></c:if>
					                        <c:if test='${not empty filter.updateDt}'><c:param name='updateDtStr' value='${filter.updateDt}'/></c:if>
					                        <c:if test='${not empty filter.delYn}'><c:param name='delYn' value='${filter.delYn}'/></c:if>
					                        <c:if test='${not empty filter.authorityName}'><c:param name='authorityName' value='${filter.authorityName}'/></c:if>
					                        <c:if test='${not empty filter.isSystem}'><c:param name='isSystem' value='${filter.isSystem}'/></c:if>
					                      </c:url>">${p}</a>
					            </li>
					          </c:forEach>
					
					          <!-- Next -->
					          <li class="page-item ${curr >= last ? 'disabled' : ''}">
					            <a class="page-link"
					               href="<c:url value='/authority/list'>
					                       <c:param name='page' value='${curr-1}'/>
					                        <c:param name='size' value='${filter.size}'/>
					                        <c:if test='${not empty filter.dateType}'><c:param name='dateType' value='${filter.dateType}'/></c:if>
					                        <c:if test='${not empty filter.createDt}'><c:param name='createDtStr' value='${filter.createDt}'/></c:if>
					                        <c:if test='${not empty filter.updateDt}'><c:param name='updateDtStr' value='${filter.updateDt}'/></c:if>
					                        <c:if test='${not empty filter.delYn}'><c:param name='delYn' value='${filter.delYn}'/></c:if>
					                        <c:if test='${not empty filter.authorityName}'><c:param name='authorityName' value='${filter.authorityName}'/></c:if>
					                        <c:if test='${not empty filter.isSystem}'><c:param name='isSystem' value='${filter.isSystem}'/></c:if>
					                    </c:url>">다음</a>
					          </li>
					        </ul>
					      </nav>
					    </c:if>
					  </div>
					</div>

            </div>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp"%>
    </div>
</div>

<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

<script>
    $(document).ready(function() {
        var contextPath = "${pageContext.request.contextPath}";


        // 💡 1. 부서 드롭다운 변경 시 자동 필터링 (submit 버튼 누르는 것을 대체)
        $("#deptFilter").on('change', function() {
            $("#AuthorityFilterForm").submit();
        });
        
        // 💡 2. 테이블 헤더 클릭 시 정렬 기능
        $(".sortable").on('click', function() {
            var newSortField = $(this).data('field');
            var currentSortField = $('input[name="sortField"]').val();
            var currentSortOrder = $('input[name="sortOrder"]').val();
            var newSortOrder = 'ASC';

            // 현재 필드를 다시 클릭한 경우, 정렬 순서를 반전
            if (newSortField === currentSortField) {
                newSortOrder = (currentSortOrder === 'ASC') ? 'DESC' : 'ASC';
            }

            // 숨겨진 필드 값 업데이트
            $('input[name="sortField"]').val(newSortField);
            $('input[name="sortOrder"]').val(newSortOrder);
            
            // 폼 제출
            $("#AuthorityFilterForm").submit();
        });
    });
    
    $(document).on('click', '.clickable-row', function() {
    	  var href = $(this).data('href');
    	  if (href) window.location.href = href;
    	});

</script>

</body>
</html>