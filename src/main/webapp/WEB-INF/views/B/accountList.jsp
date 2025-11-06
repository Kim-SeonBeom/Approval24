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
    </style>
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
					<h1 class="h3 mb-2 text-gray-800">계정관리</h1>

		<!-- DataTales Example -->
<div class="card shadow mb-4">
<div class="card-header py-3 d-flex align-items-center justify-content-between">
    					<h2 class="h5 m-0 font-weight-bold text-primary" >계정 목록</h2>
    					</div>
   <div class="card-body">
    <!-- 검색 필터 -->
    <form method="get" action="list" class="filter" onsubmit="removeEmptyParams(this)">
        <label>로그인 ID: <input type="text" name="loginId" value="${param.loginId}"></label>
        <label>사용자 이름: <input type="text" name="userName" value="${param.userName}"></label>
        <br>
        <label>부서:
    <select name="deptId">
        <option value="">전체</option>
        <c:forEach var="dept" items="${deptList}">
            <option value="${dept.deptId}" 
                <c:if test="${param.deptId eq dept.deptId}">selected</c:if>>
                ${dept.deptName}
            </option>
        </c:forEach>
    </select>
</label>

<label>계정 상태:
    <select name="accountStatus">
        <option value="">전체</option>
        <c:forEach var="status" items="${statusList}">
            <option value="${status.codeId}" 
                <c:if test="${param.accountStatus eq status.codeId}">selected</c:if>>
                ${status.codeName}
            </option>
        </c:forEach>
    </select>
</label>

        <label>시작일: <input type="date" name="startDate" value="${param.startDate}"></label>
        <label>종료일: <input type="date" name="endDate" value="${param.endDate}"></label>
        <button type="submit" class=" btn btn-primary text-white">검색</button>
    </form>

    <!-- 계정 목록 테이블 -->
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
            <c:forEach var="acc" items="${accounts}">
                <tr>
                    <td>${acc.accountId}</td>
                    <td>${acc.userName}</td>
                    <td>${acc.loginId}</td>
                    <td>${acc.deptName}</td>
                    <td>${acc.accountStatusName != null ? acc.accountStatusName : ''}</td>
                    <td><fmt:formatDate value="${acc.createDt}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${acc.updateDt}" pattern="yyyy-MM-dd"/></td>
                </tr>
            </c:forEach>
            <c:if test="${empty accounts}">
                <tr>
                    <td colspan="7" style="text-align:center;">조회 결과가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
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
						<span>행정 &copy; 결재24 2025</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->
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

    <script>
        function removeEmptyParams(form) {
            Array.from(form.elements).forEach(el => {
                if(el.value === '') el.disabled = true;
            });
        }
    </script>
</body>
</html>
