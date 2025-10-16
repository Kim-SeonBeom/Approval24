<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
		
		<!-- Sidebar -->
		        	<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
		 <!-- End of Sidebar -->
		 
		 <!-- Content Wrapper -->
		 <div id="content-wrapper" class="d-flex flex-column">
		 
		 <!-- Main Content -->
		 <div id="content">
		 
		  <!-- Topbar -->
		  <%@ include file="/WEB-INF/views/common/navbar.jsp" %>
		  <!-- End of Topbar -->

			<!-- Begin Page Content -->
			<div class="container-fluid">
			
			<!-- Page Heading -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">마이페이지</h1>
             </div>
             
             <!-- 마이페이지 card -->
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">실업급여_정동윤님</h6>
                                 
                                    </div>
                                
                                <!-- 프로필 card -->
                           <div class="card-body">
                           <div class="row align-items-start" >
							<div class="col-lg-6 col-md-4 col-12 d-flex  justify-content-center align-items-center mb-4" >
								<img src="${pageContext.request.contextPath}/resources/assets/img/test_human.png"id="mypageProfileImage" 
								class="rounded-circle me-3"alt="Profile Image Preview" 
								style="width: 300px; height: 400px;">
							</div> 
							<!-- 개인 정보들 -->
						<div class="col-lg-6 col-md-4 col-12 d-flex  justify-content-center align-items-center " style="margin-top:80px;" >
							<div class="w-100">
								<h6 class="text-dark font-weight-bold">직원정보</h6>
							 <table class="table table-bordered" id="dataTable_mypage1" width="100%" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td class="text-dark bg-light  font-weight-bold" style="width: 25%;"  >이름</td>
                                            <td>45세 정동윤</td>
                                        </tr>
                                        <tr>
                                            <td class="text-dark bg-light font-weight-bold " style="width: 25%;" >회사</td>
                                            <td>엑사아이엔티</td>
                                        </tr>
                                        <tr>
                                           <td class="text-dark bg-light font-weight-bold " style="width: 25%;" >부서</td>
                                            <td>진천 SI팀</td>
                                        </tr>
                                        <tr>
                                            <td class="text-dark bg-light  font-weight-bold" style="width: 25%;" >직책</td>
                                            <td>부장</td>
                                        </tr>
                                        <tr>
                                            <td class="text-dark bg-light font-weight-bold" style="width: 25%;" >전화번호</td>
                                            <td>010-2935-9094</td>
                                        </tr>
                                        <tr>
                                       </tbody>
                                      </table>
                                   </div>
                                   </div>
                                      
                                      <!-- 계정 정보 -->
                                   <div class="col-lg-12 col-md-8 col-12 ">
                                      <h6 class="text-dark font-weight-bold">계정정보</h6>
                                      <tbody>
                                      	<table class="table tale-bordered" id="dataTable_mypage2">
                                            <td class="text-dark bg-light font-weight-bold" style="width: 25%;" >담당 업무</td>
                                            <td>고용24 유지보수</td>
                                        </tr>
                                        <tr>
                                            <td class="text-dark bg-light font-weight-bold" style="width: 25%;" >권한</td>
                                            <td>고용24 유지보수 신청</td>
                                        </tr>
                                   </table>
                                   </tbody>
						</div>		
						</div>
                                
                                </div>
                            </div>
                        
                        </div>
                    </div>
		 
		 </div>
	
	</div>
<!-- Logout Modal-->
<%@ include file="/WEB-INF/views/common/logoutModal.jsp" %>
<!-- footer 영역 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>