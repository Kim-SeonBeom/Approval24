<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <style>
        .pagination { display: flex; padding-left: 0; list-style: none; border-radius: .25rem; }
        .page-item.active .page-link { z-index: 3; color: #fff; background-color: #007bff; border-color: #007bff; }
        .page-link { position: relative; display: block; padding: .5rem .75rem; margin-left: -1px; line-height: 1.25; color: #007bff; background-color: #fff; border: 1px solid #dee2e6; }
    </style>
</head>
<body id="page-top">

<div id="wrapper">
    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="/WEB-INF/views/common/navbar.jsp"%>

            <div class="container-fluid">
                <h1 class="h3 mb-2 text-gray-800">사용자 관리</h1>
                <br>

                <!-- 🔍 검색 영역 -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">검색 및 필터링</h6>
                    </div>
                    <div class="card-body">
                        <form id="userFilterForm" action="${pageContext.request.contextPath}/user/list" method="get" onsubmit="removeEmptyParams(this)">
                            <div class="form-row align-items-end">
                                
                                <div class="col-md-1 mb-3">
                                    <label for="pageSizeSelect">항목 수</label>
                                    <select class="custom-select" id="pageSizeSelect" name="pageSize" onchange="submitPageSize(this)">
                                        <option value="5" <c:if test="${pageInfo.pageSize eq 5}">selected</c:if>>5개</option>
                                        <option value="10" <c:if test="${pageInfo.pageSize eq 10}">selected</c:if>>10개</option>
                                        <option value="15" <c:if test="${pageInfo.pageSize eq 15}">selected</c:if>>15개</option>
                                        <option value="20" <c:if test="${pageInfo.pageSize eq 20}">selected</c:if>>20개</option>
                                    </select>
                                </div>
                                
                                <c:if test="${not empty loggedInInstId and loggedInInstId == 1}">
                                    <div class="col-md-2 mb-3">
                                        <label for="instIdSelect">기관</label>
                                        <select class="custom-select" id="instIdSelect" name="instId">
                                            <option value="">-- 전체 기관 --</option>
                                        </select>
                                    </div>
                                </c:if>

                                <div class="col-md-2 mb-3">
                                    <label for="userNameFilter">사용자 이름</label>
                                    <input type="text" class="form-control" id="userNameFilter" name="userName" 
                                           value="${params.userName}" placeholder="이름 입력">
                                </div>
                                
                                <div class="col-md-2 mb-3">
                                    <label for="userEmailFilter">이메일</label>
                                    <input type="email" class="form-control" id="userEmailFilter" name="userEmail" 
                                           value="${params.userEmail}" placeholder="이메일 입력">
                                </div>

                                <div class="col-md-2 mb-3">
                                    <label for="userPositionCdFilter">직급</label>
                                    <select class="custom-select" id="userPositionCdFilter" name="userPositionCd">
                                        <option value="">-- 전체 직급 --</option>
                                        <c:forEach var="pos" items="${codes}"> 
                                            <option value="${pos.codeId}" ${params.userPositionCd eq pos.codeId ? 'selected' : ''}>
                                                ${pos.codeName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="col-md-1 mb-3">
                                    <label for="delYnFilter">삭제 여부</label>
                                    <select class="custom-select" id="delYnFilter" name="delYn">
                                        <option value="">-- 전체 --</option>
                                        <option value="N" ${params.delYn eq 'N' ? 'selected' : ''}>활성 (N)</option>
                                        <option value="Y" ${params.delYn eq 'Y' ? 'selected' : ''}>삭제됨 (Y)</option>
                                    </select>
                                </div>

                                <div class="col-md-1 mb-3">
                                    <button class="btn btn-primary btn-block" type="submit">검색</button>
                                </div>
                                
                                <input type="hidden" name="page" id="currentPageInput" value="1">
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- 👤 사용자 목록 -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">사용자 목록 (${pageInfo.totalCount}명)</h6>
                        <a href="${pageContext.request.contextPath}/user/create" class="btn btn-primary btn-sm" style="font-size: 1rem; padding: 0.25rem 0.75rem;">+ 사용자 등록</a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-sm text-center align-middle">
							  <thead class="thead-light">
							    <tr>
							      <th>번호</th>
							      <th>이름</th>
							      <th>직급</th>
							      <th>이메일</th>
							      <th>전화번호</th>
							      <th>등록일</th>
							    </tr>
							  </thead>
							  <tbody>
							    <c:choose>
							      <c:when test="${not empty users}">
							        <c:forEach var="user" items="${users}" varStatus="status">
							          <tr class="clickable-row"
							              data-href="${pageContext.request.contextPath}/user/detail/${user.userNo}"
							              style="cursor:pointer;">
							            <td>${pageInfo.startRow + status.index}</td>
							            <td><c:out value="${user.userName}" /></td>
							            <td><c:out value="${user.userPositionName}" /></td>
							            <td class="text-left pl-3"><c:out value="${user.userEmail}" /></td>
							            <td><c:out value="${user.userPhone}" /></td>
							            <td><fmt:formatDate value="${user.createDt}" pattern="yyyy-MM-dd"/></td>
							          </tr>
							        </c:forEach>
							      </c:when>
							      <c:otherwise>
							        <tr><td colspan="6" class="text-center text-muted">조회된 사용자 정보가 없습니다.</td></tr>
							      </c:otherwise>
							    </c:choose>
							  </tbody>
							</table>

                        </div>
                        
                        <!-- 📄 페이지네이션 -->
                        <div class="d-flex justify-content-center">
                            <ul class="pagination">
                                <c:url var="baseUrl" value="/user/list" />
                                
                                <!-- 이전 블록 -->
                                <c:if test="${pageInfo.startPage > 1}">
                                    <li class="page-item">
                                        <a href="${baseUrl}?page=${pageInfo.startPage - 1}&pageSize=${pageInfo.pageSize}" class="page-link" aria-label="Previous Block">
                                            <span aria-hidden="true">«</span>
                                        </a>
                                    </li>
                                </c:if>

                                <!-- 페이지 번호 -->
                                <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="pageNum">
                                    <li class="page-item <c:if test='${pageInfo.page eq pageNum}'>active</c:if>">
                                        <a href="${baseUrl}?page=${pageNum}&pageSize=${pageInfo.pageSize}" class="page-link">${pageNum}</a>
                                    </li>
                                </c:forEach>

                                <!-- 다음 블록 -->
                                <c:if test="${pageInfo.endPage < pageInfo.totalPages}">
                                    <li class="page-item">
                                        <a href="${baseUrl}?page=${pageInfo.endPage + 1}&pageSize=${pageInfo.pageSize}" class="page-link" aria-label="Next Block">
                                            <span aria-hidden="true">»</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
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
    function removeEmptyParams(form) {
        document.getElementById('currentPageInput').value = 1;
        Array.from(form.elements).forEach(el => {
            if (el.name && el.value === '' && el.name !== 'page' && el.name !== 'pageSize') {
                el.disabled = true;
            }
        });
        return true;
    }

    function submitPageSize(selectElement) {
        document.getElementById('currentPageInput').value = 1;
        selectElement.form.submit();
    }

    // AJAX 기관 목록 로드
    document.addEventListener('DOMContentLoaded', function() {
        const instIdSelect = document.getElementById('instIdSelect');
        if (instIdSelect) {
            const url = '${pageContext.request.contextPath}/api/common/insts';
            const currentInstId = '${params.instId}';
            
            fetch(url)
                .then(response => {
                    if (!response.ok) throw new Error('기관 목록 로드 실패');
                    return response.json();
                })
                .then(data => {
                    data.forEach(item => {
                        const option = document.createElement('option');
                        option.value = item.instId;
                        option.textContent = item.instName;
                        if (String(currentInstId) === String(item.instId)) {
                            option.selected = true;
                        }
                        instIdSelect.appendChild(option); // ✅ 모든 옵션 추가
                    });
                })
                .catch(error => console.error('기관 목록 로드 오류:', error));
        }
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
