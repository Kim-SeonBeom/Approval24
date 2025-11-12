<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
    <title>결재 이력</title>
</head>
<body id ="page-top">
<!-- Page Wrapper -->
	<div id="wrapper">
			<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
			<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
				<!-- Main Content -->
			<div id="content">
					<!-- Topbar -->
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
				
						<!-- Begin Page Content -->
				<div class="container-fluid">
				<h1 class="h3 mb-2 text-gray-800">결제 이력</h1>
						
<!-- DataTales Example -->
<div class="card shadow mb-4">
<div class="card-header py-3 d-flex align-items-center justify-content-between">
    					<h2 class="h5 m-0 font-weight-bold text-primary" >결재 이력 조회</h2>
    					</div>

<div class="card-body">
    <!-- 검색 필터 -->
    <form method="get" action="/ApprovalHistory/list" style="text-align: right;">
        <label>결재 상태:</label>
        <select name="approvalStatusCd">
            <option value="">전체</option>
            <c:forEach var="status" items="${statusCodeList}">
                <option value="${status.codeId}"
                    <c:if test="${filterMap.approvalStatusCd == status.codeId}">selected</c:if>>
                    ${status.codeName}
                </option>
            </c:forEach>
        </select>

        <label style="margin-left:30px;">결재 구분:</label>
        <select name="categoryCd">
            <option value="">전체</option>
            <c:forEach var="category" items="${categoryCodeList}">
                <option value="${category.codeId}"
                    <c:if test="${filterMap.categoryCd == category.codeId}">selected</c:if>>
                    ${category.codeName}
                </option>
            </c:forEach>
        </select>

        <button type="submit" class=" btn btn-primary text-white">검색</button>
    </form>

    <hr>

    <!-- 결재 이력 목록 -->
    <table class="table table-bordered"width="100%" cellspacing="0">
        <thead>
            <tr>
                <th>번호</th>
                <th>결재 구분</th>
                <th>결재 상태</th>
                <th>결재자 유형</th>
                <th>처리일자</th>
                <th>의견</th>
                <th>URL</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty historyList}">
                    <c:forEach var="item" items="${historyList}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${item.categoryName}</td>
                            <td>${item.approvalStatusName}</td>
                            <td>${item.approverTypeName}</td>
                            <td>
                                <fmt:formatDate value="${item.processDt}" pattern="yyyy-MM-dd HH:mm" />
                            </td>
                            <td>${item.approvalComment}</td>
                            <td>
                                <c:if test="${not empty item.url}">
                                    <a href="${item.url}" target="_blank">바로가기</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="7">조회된 결재 이력이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
       </div>
        </div>
    
       </div>
				<!-- /.container-fluid -->
    </div>
			<!-- End of Main Content -->
    </div>
		<!-- End of Content Wrapper -->
    
       </div>
   
   	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<!-- footer 영역 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
