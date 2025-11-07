<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
    <meta charset="UTF-8">
    <title>계정 목록</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f0f0f0; }
        select, input { padding: 4px; margin-right: 10px; }
        .filter { margin-bottom: 15px; }
        .pagination { display: flex; padding-left: 0; list-style: none; border-radius: .25rem; }
        .page-item.active .page-link { z-index: 3; color: #fff; background-color: #007bff; border-color: #007bff; }
        .page-link { position: relative; display: block; padding: .5rem .75rem; margin-left: -1px; line-height: 1.25; color: #007bff; background-color: #fff; border: 1px solid #dee2e6; }
    </style>
</head>
<body id ="page-top">
<div id="wrapper">
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		
		<div id="content-wrapper" class="d-flex flex-column">
		
			<div id="content">
			<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
				
			<div class="container-fluid">
					<h1 class="h3 mb-2 text-gray-800">계정관리</h1>

		<div class="card shadow mb-4">
<div class="card-header py-3 d-flex align-items-center justify-content-between">
    					<h2 class="h5 m-0 font-weight-bold text-primary" >계정 목록</h2>
    					</div>
    <div class="card-body">
    <form id="searchForm" method="get" action="list" class="filter" onsubmit="removeEmptyParams(this)">
    	
    	<!--  항목 수 조절하고 싶으면 주석 제거
    	<label>항목 수:
            <select name="pageSize" onchange="this.form.submit()">
                <option value="5" <c:if test="${pageInfo.pageSize eq 5}">selected</c:if>>5개</option>
                <option value="10" <c:if test="${pageInfo.pageSize eq 10}">selected</c:if>>10개</option>
                <option value="15" <c:if test="${pageInfo.pageSize eq 15}">selected</c:if>>15개</option>
            </select>
        </label>
        <input type="hidden" name="page" value="1">
        -->
        
        <label>로그인 ID: <input type="text" name="loginId" value="${param.loginId}"></label>
        <label>사용자 이름: <input type="text" name="userName" value="${param.userName}"></label>
        <br>
        
        <%-- 🌟 기관 ID가 1(관리자)이거나 Model에 없으면 기관 선택 필터 표시 --%>
        <c:if test="${empty instId or instId eq 1}">
        <label>기관:
            <select name="instId" id="instIdSelect">
                <option value="">전체</option>
            </select>
        </label>
        </c:if>
        
        <label>부서:
    <select name="deptId" id="deptIdSelect">
        <option value="">전체</option>
    </select>
</label>

<label>계정 상태:
    <select name="accountStatus" id="accountStatusSelect">
        <option value="">전체</option>
    </select>
</label>

        <label>시작일: <input type="date" name="startDate" value="${param.startDate}"></label>
        <label>종료일: <input type="date" name="endDate" value="${param.endDate}"></label>
        <button type="submit" class=" btn btn-primary text-white">검색</button>
        
        <%-- 페이징을 위해 현재 페이지 및 페이지 크기를 숨겨서 전달 --%>
        <input type="hidden" name="page" value="${pageInfo.page}">
        <input type="hidden" name="pageSize" value="${pageInfo.pageSize}">
    </form>

    <table class="table table-bordered"width="100%" cellspacing="0">
        <thead>
            <tr>
			<th style="width: 10%;">계정 ID</th>
            <th style="width: 15%;">사용자 이름</th>
            <th style="width: 15%;">로그인 ID</th>
            <th style="width: 10%;">부서</th>
            <th style="width: 15%;">계정 상태</th>
            <th style="width: 15%;">생성일</th>
            <th style="width: 20%;">수정일</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty accounts}">
                    <c:forEach var="acc" items="${accounts}">
                        <tr>
                            <td>
                                <%-- 🌟 계정 상세 페이지 링크 --%>
                                <a href="detail?targetAccountId=${acc.accountId}">${acc.accountId}</a>
                            </td>
                            <td>${acc.userName}</td>
                            <td>${acc.loginId}</td>
                            <td>${acc.deptName}</td>
                            <td>${acc.accountStatusName != null ? acc.accountStatusName : ''}</td>
                            <td><fmt:formatDate value="${acc.createDt}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${acc.updateDt}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="7" style="text-align:center;">조회 결과가 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
    <%-- 🌟 페이지네이션 UI (pageInfoVO 사용) --%>
    <div class="row">
        <div class="col-sm-12 col-md-7">
            <div class="dataTables_paginate paging_simple_numbers">
                <ul class="pagination justify-content-center">
                    
                    <%-- 이전 블록 버튼 (startPage가 1보다 클 경우) --%>
                    <c:if test="${pageInfo.startPage > 1}">
                        <li class="paginate_button page-item previous">
                            <a href="list?page=${pageInfo.startPage - 1}&pageSize=${pageInfo.pageSize}&${param.queryString}" class="page-link">«</a>
                        </li>
                    </c:if>

                    <%-- 페이지 번호 버튼 (startPage부터 endPage까지) --%>
                    <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="pageNum">
                        <li class="paginate_button page-item <c:if test='${pageInfo.page eq pageNum}'>active</c:if>">
                            <a href="list?page=${pageNum}&pageSize=${pageInfo.pageSize}&${param.queryString}" class="page-link">${pageNum}</a>
                        </li>
                    </c:forEach>

                    <%-- 다음 블록 버튼 (endPage가 totalPages보다 작을 경우) --%>
                    <c:if test="${pageInfo.endPage < pageInfo.totalPages}">
                        <li class="paginate_button page-item next">
                            <a href="list?page=${pageInfo.endPage + 1}&pageSize=${pageInfo.pageSize}&${param.queryString}" class="page-link">»</a>
                        </li>
                    </c:if>
                    
                </ul>
            </div>
        </div>
    </div>
    <%-- 🌟 페이지네이션 UI 끝 --%>
    
    </div>
    </div>
    
    </div>
				</div>
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>행정 &copy; 결재24 2025</span>
					</div>
				</div>
			</footer>
			</div>
		</div>
    
    	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

    <script>
        // 폼 제출 시 비어있는 파라미터 제거 (기존 유지)
        function removeEmptyParams(form) {
            Array.from(form.elements).forEach(el => {
                // page, pageSize는 항상 포함되어야 하므로 제외
                if(el.value === '' && el.name !== 'page' && el.name !== 'pageSize') { 
                    el.disabled = true;
                }
            });
        }
        
        // 🌟 AJAX 통신을 위한 함수 정의
        document.addEventListener('DOMContentLoaded', function() {
            
            const searchForm = document.getElementById('searchForm');
            
            // Controller에서 전달받지 못하고 JSP에서 파싱해야 하는 경우를 대비한 쿼리 스트링 헬퍼
            const queryString = getQueryString(searchForm);
            
            // 쿼리 스트링을 page 버튼에 전달하기 위해 JSTL 변수 설정 (Controller에서 처리하는 것이 가장 좋음)
            // 임시로 param.queryString을 사용할 수 있도록 JS에서 링크를 조정하는 헬퍼 함수
            document.querySelectorAll('.pagination a').forEach(link => {
                if (link.href.indexOf('&${param.queryString}') > -1) {
                    link.href = link.href.replace('&${param.queryString}', '&' + queryString);
                }
            });

            function getQueryString(form) {
                const params = [];
                Array.from(form.elements).forEach(el => {
                    // page, pageSize 제외
                    if(el.name && el.value !== '' && el.name !== 'page' && el.name !== 'pageSize') {
                        params.push(el.name + '=' + encodeURIComponent(el.value));
                    }
                });
                return params.join('&');
            }


            function fetchAndPopulateSelect(url, selectElementId, valueProperty, nameProperty, selectedValue) {
                const selectElement = document.getElementById(selectElementId);
                if (!selectElement) return;

                // 기존 옵션 (전체)를 제외하고 모두 비우기
                Array.from(selectElement.options).forEach((option, index) => {
                    if (index > 0) selectElement.removeChild(option);
                });

                fetch(url)
                    .then(response => {
                        if (response.status === 401) {
                            alert('로그인이 필요합니다.');
                            window.location.href = '/login';
                            return;
                        }
                        if (!response.ok) {
                            throw new Error(`API 호출 실패: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(data => {
                        data.forEach(item => {
                            const option = document.createElement('option');
                            option.value = item[valueProperty];
                            option.textContent = item[nameProperty];
                            
                            // 현재 URL 파라미터와 값이 일치하면 selected 설정
                            if (selectedValue && String(selectedValue) === String(item[valueProperty])) {
                                option.selected = true;
                            }
                            selectElement.appendChild(option);
                        });
                    })
                    .catch(error => {
                        console.error(`데이터 로드 중 오류 발생 (${url}):`, error);
                    });
            }
            
            // 🌟 A. 기관 목록 로드 (instIdSelect가 존재할 때만)
            const instIdSelect = document.getElementById('instIdSelect');
            if (instIdSelect) {
                const instIdParam = new URLSearchParams(window.location.search).get('instId');
                fetchAndPopulateSelect('/approval24/api/common/institutions', 'instIdSelect', 'instId', 'instName', instIdParam);
            }
            
            // 🌟 B. 부서 목록 로드
            const deptIdParam = new URLSearchParams(window.location.search).get('deptId');
            fetchAndPopulateSelect('/approval24/api/common/depts', 'deptIdSelect', 'deptId', 'deptName', deptIdParam);
            
            // 🌟 C. 계정 상태 코드 로드
            const statusParam = new URLSearchParams(window.location.search).get('accountStatus');
            fetchAndPopulateSelect('/approval24/api/common/codes?groupId=B0', 'accountStatusSelect', 'codeId', 'codeName', statusParam);

        });
    </script>
</body>
</html>