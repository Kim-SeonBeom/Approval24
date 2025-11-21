<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <title>메뉴목록</title>
    <style>
        /* 라디오 버튼 인라인 정렬 */
        .radio-group label {
            margin-right: 15px;
        }
        /* 인라인 스타일 제거 및 통일 */
        .btn-create {
            font-size: 1rem; 
            padding: 0.25rem 0.75rem;
        }
        /* 부서 목록 스타일: 레이블을 굵게, 중앙 정렬 */
        .filter-label {
            font-weight: bold;
            text-align: center;
        }
        /* 입력 필드 크기 제한 (날짜 및 일반 입력란) */
        .input-w-25 {
            width: 25% !important; /* 입력 필드 너비 25%로 제한 */
            display: inline-block;
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

                <h1 class="h3 mb-2 text-gray-800">메뉴 관리</h1>
                <br>

                <%-- ✅ 알림 메시지 표시 영역 (변경 없음) --%>
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
                        <div>
                            <button class="btn btn-primary btn-sm" type="submit" form="searchForm">검색</button>
                            <button class="btn btn-secondary btn-sm" type="button" onclick="location.href='${pageContext.request.contextPath}/menu/list'">초기화</button>
                        </div>
                    </div>

                    <div class="card-body">
                        <form id="searchForm" action="${pageContext.request.contextPath}/menu/list" method="get">
                            
                            <div class="form-group row align-items-center mb-3">
                                <label for="menuName" class="col-sm-2 col-form-label filter-label">메뉴명</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control form-control-sm input-w-25" id="menuName" name="menuName" value="${filterMap.menuName}">
                                </div>
                            </div>
                            
                            <div class="form-group row align-items-center mb-3">
                                <label for="parentMenuName" class="col-sm-2 col-form-label filter-label">상위 메뉴 이름</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control form-control-sm input-w-25" id="parentMenuName" name="parentMenuName" value="${filterMap.parentMenuName}">
                                </div>
                            </div>
                            
                            <div class="form-group row align-items-center mb-3">
                                <label class="col-sm-2 col-form-label filter-label">사용 여부</label>
                                <div class="col-sm-10">
                                    <div class="radio-group form-inline">
                                        <input type="radio" id="delYnAll" name="delYn" value="ALL" <c:if test="${empty filterMap.delYn or filterMap.delYn eq 'ALL'}">checked</c:if>>
                                        <label for="delYnAll" class="small mr-3">전체</label>
                                        <input type="radio" id="delYnN" name="delYn" value="N" <c:if test="${filterMap.delYn eq 'N'}">checked</c:if>>
                                        <label for="delYnN" class="small mr-3">사용</label>
                                        <input type="radio" id="delYnY" name="delYn" value="Y" <c:if test="${filterMap.delYn eq 'Y'}">checked</c:if>>
                                        <label for="delYnY" class="small">미사용</label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group row align-items-center mb-3">
                                <label class="col-sm-2 col-form-label filter-label">팝업 여부</label>
                                <div class="col-sm-10">
                                    <div class="radio-group form-inline">
                                        <input type="radio" id="popupYnAll" name="popupYn" value="ALL" <c:if test="${empty filterMap.popupYn or filterMap.popupYn eq 'ALL'}">checked</c:if>>
                                        <label for="popupYnAll" class="small mr-3">전체</label>
                                        <input type="radio" id="popupYnY" name="popupYn" value="Y" <c:if test="${filterMap.popupYn eq 'Y'}">checked</c:if>>
                                        <label for="popupYnY" class="small mr-3">팝업</label>
                                        <input type="radio" id="popupYnN" name="popupYn" value="N" <c:if test="${filterMap.popupYn eq 'N'}">checked</c:if>>
                                        <label for="popupYnN" class="small">일반</label>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row align-items-center mb-3">
                                <label class="col-sm-2 col-form-label filter-label">등록일 기간</label>
                                <div class="col-sm-10">
                                    <div class="input-group input-group-sm input-w-25"> 
                                        <input type="date" class="form-control form-control-sm" name="createDtStart" value="${filterMap.createDtStart}">
                                        <span class="input-group-text">~</span>
                                        <input type="date" class="form-control form-control-sm" name="createDtEnd" value="${filterMap.createDtEnd}">
                                    </div>
                                </div>
                            </div>
                            
                            <input type="hidden" name="pageSize" value="${pageInfo.pageSize}" />
                            <input type="hidden" name="page" id="page" value="${pageInfo.page}">
                        </form>
                    </div>
                </div>
                <br>
                
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">전체 메뉴 목록</h6>
                        <a class="btn btn-primary btn-sm btn-create" id="menuCreate"
                            href="${pageContext.request.contextPath}/menu/create">
                            + 메뉴 등록
                        </a>
                    </div>
                    
                    <div class="card-body">
                        <c:if test="${empty menus}">
                             <div class="text-center text-muted py-4">
                                검색 조건을 입력하고 <b>검색</b>을 눌러주세요.
                            </div>
                        </c:if>

                        <c:if test="${not empty menus}">
                            <div class="mb-2 text-left text-muted">
                                총 <b>${pageInfo.totalCount}</b>건
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-sm text-center align-middle">
                                    <thead class="thead-light">
                                        <tr>
                                            <th class="text-center">번호</th>
                                            <th class="text-center">관리번호</th>
                                            <th class="text-center">메뉴명</th>
                                            <th class="text-center">URL</th>
                                            <th class="text-center">상위 메뉴 이름</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="menu" items="${menus}" varStatus="status">
                                            <tr class="clickable-row" data-href="${pageContext.request.contextPath}/menu/detail/${menu.menuId}" style="cursor: pointer;">
                                                <td>${pageInfo.startRow + status.index}</td> 
                                                <td width="100px">${menu.menuId}</td>
                                                <td class="text-left pl-3">${empty menu.menuName ? '-' : menu.menuName}</td>
                                                <td class="text-left pl-3">${empty menu.menuUrl ? '-' : menu.menuUrl}</td>
                                                <td>${empty menu.parentMenuName ? '-' : menu.parentMenuName}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-center">
                                <ul class="pagination">
                                    <c:url var="baseUrl" value="/menu/list" >
                                        <c:forEach var="entry" items="${filterMap}">
                                            <c:if test="${entry.key ne 'page' and entry.key ne 'pageSize' and not empty entry.value and entry.key ne 'startRow' and entry.key ne 'endRow'}">
                                                <c:param name="${entry.key}" value="${entry.value}" />
                                            </c:if>
                                        </c:forEach>
                                        <c:param name="pageSize" value="${pageInfo.pageSize}" />
                                    </c:url>

                                    <c:if test="${pageInfo.startPage > 1}">
                                        <li class="page-item">
                                            <a href="${baseUrl}&page=${pageInfo.startPage - 1}" class="page-link">«</a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="pageNum">
                                        <li class="page-item <c:if test='${pageInfo.page eq pageNum}'>active</c:if>">
                                            <a href="${baseUrl}&page=${pageNum}" class="page-link">${pageNum}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${pageInfo.endPage < pageInfo.totalPages}">
                                        <li class="page-item">
                                            <a href="${baseUrl}&page=${pageInfo.endPage + 1}" class="page-link">»</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                </div>

            </div>
            </div>
        <%@ include file="/WEB-INF/views/common/footer.jsp"%>

        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>행정 &copy; 결재24 2025</span>
                </div>
            </div>
        </footer>

    </div>
    </div>
<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

<script>
    // 메뉴 등록 버튼 이벤트
    $("#menuCreate").on('click', function(e) {
        // <a> 태그의 기본 동작을 막고 href로 이동
        e.preventDefault();
        window.location.href=$(this).attr('href');
    });

    // 테이블 행 클릭 이벤트 (메뉴 상세 페이지 이동)
    document.addEventListener('click', function(e) {
        const tr = e.target.closest('.clickable-row');
        if (tr && tr.dataset.href) {
            window.location.href = tr.dataset.href;
        }
    });
</script>

</body>
</html>