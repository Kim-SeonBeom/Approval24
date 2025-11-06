<%@ include file="/WEB-INF/views/common/header.jsp"%>
    <meta charset="UTF-8">
    <title>북마크 목록</title>
    <style>
        table, th, td { border: 1px solid black; border-collapse: collapse; padding: 8px; }
        .action-link { margin-left: 10px; }
    </style>
</head>
<body id="page-top">
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
		
		
		<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">북마크</h1>
					
							<!-- DataTales Example -->
					<div class="card shadow mb-4">
					<div class="card-header py-3 d-flex align-items-center justify-content-between" >
					<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">북마크 목록</h6>
					<p class="m-0"><a href="/approval24/bookmark/create"><button class="btn btn-primary">새 북마크 등록</button></a></p>
					</div>
					
  
    
<div class="card-body">
	<div class="table-responsive">
	    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	        <thead>
	            <tr>
	                <th>ID</th>
	                <th>북마크 이름</th>
	                <th>생성일</th>
	                <th>수정일</th>
	                <th>삭제여부</th>
	                <th>상세 보기</th>
	            </tr>
	        </thead>
	        <tbody>
	            <%-- Controller에서 Model에 담아준 'bookmarks' 리스트를 출력합니다. --%>
	            <c:forEach var="bm" items="${bookmarks}">
	                <tr>
	                    <td>${bm.bookmarkId}</td>
	                    <td>${bm.bookmarkName}</td>
	                    <td>${bm.createDt}</td>
	                    <td>${bm.updateDt}</td>
	                    <td>${bm.delYn}</td>
	                    <td>
	                        <%-- 상세 페이지 이동 링크 --%>
	                        <a href="/bookmark/${bm.bookmarkId}">상세</a>
	                        
	                        <%-- 삭제 처리 (실제로는 update로 delYn을 'Y'로 변경) --%>
	                        <form action="/bookmark/update" method="post" style="display:inline;" onsubmit="return confirm('정말로 삭제(비활성화)하시겠습니까?');">
	                            <input type="hidden" name="bookmarkId" value="${bm.bookmarkId}">
	                            <input type="hidden" name="delYn" value="Y">
	                            <button type="submit" class="action-link">삭제</button>
	                        </form>
	                    </td>
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
</body>
</html>
