<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- header 영역 -->
<head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
</head>
<title>신청서</title>
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
	
	<!-- sidebar -->
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
			
				<!-- 페이지 서식 -->
				<!-- Page Heading -->
				
                 
                  <!-- DataTables Example -->
                    <div class="card shadow mb-4">
                    <div class="d-sm-flex align-items-center justify-content-center mt-4">
                        <h1 class="h3 mb-0 text-gray-800">신청서</h1>
                 </div>
                        <div class="card-body">
                            <div class="table-responsive">
                            <!-- 접수표 -->
                                <table class="table table-bordered mb-4" id="dataTable_index" width="100%" cellspacing="0">
	                                <colgroup>
	                                	<col style="width: 18%;">
	                                	<col style="width: 32%;">
	                                	<col style="width: 18%;">
	                                	<col style="width: 32%;">
	                                </colgroup>
                                    <tbody>
                                        <tr>
                                            <th  class="text-dark bg-light  font-weight-bold">접수번호</th>
                                            <td colspan="3">1202501369</td>
                                        </tr>
                                        <tr>
                                            <th scope="col" class="text-dark bg-light font-weight-bold "  >접수부서</th>
                                            <td  colspan="3">취업지원과</td>
                                        </tr>
                                        <tr>
                                           <th scope="col" class="text-dark bg-light font-weight-bold "  >민원서식</th>
                                            <td  colspan="3">취업지원금 신청</td>
                                        </tr>
                                        <tr>
                                            <th  scope="col"  class="text-dark bg-light  font-weight-bold"  >담장자</th>
                                            <td colspan="3" >이수빈</td>
                                        </tr>
										 <tr>
                                            <th  scope="col"  class="text-dark bg-light font-weight-bold"  >담당자 전화번호</th>
                                            <td colspan="3" >031-248-8596</td>
                                        </tr>
                                        <tr>
                                            <th   scope="col" class="text-dark bg-light font-weight-bold" >접수일</th>
                                            <td >2025-10-16</td>
                                            <th   scope="col"  class="text-dark bg-light font-weight-bold"  >마감일</th>
                                            <td>2025-10-17</td>
                                        </tr>
                                    </tbody>
                                   </table>
                                   
                                   <!-- 결제 내용 표 -->
								<table class="table table-bordered mt-4" id="dataTable_index"
									width="100%" cellspacing="0">
									<colgroup>
                                	<col style="width: 18%;">
                                	<col style="width: 82%;">
                                </colgroup>
									<tbody>
									<tr>
											<td colspan="2" class="text-dark bg-light font-weight-bold text-center align-middle"
												style="width: 25%;">결제 내용</td>
									</tr>
										<tr>
											<td colspan="2"><textarea class="form-control"
													id="pendingContent" rows="10"
													placeholder="결제 상세 내용을 입력하세요." style="resize: none;">
제출된 취업지원금 신청서와 관련 서류를 검토한 결과, 해당 신청은 취업지원 프로그램의 자격 요건을 모두 충족하며, 지급 대상자로 확인 되었습니다. 승인바랍니다.
                </textarea></td>
										</tr>

										<tr>
											<th scope="col" class="text-dark bg-gray-400 font-weight-bold text-center"
												style="width: 25%;"><span>첨부파일</span></th>
											<td>
												<i class="fas fa-file-download"></i>
												<a href="[실제 파일 다운로드 경로]">
                    								취업지원증명서.hwp
                								</a>
											</td>
										</tr>
									</tbody>
								</table>
								
								<!-- 진행내역 -->
								


								<div class="text-right mt-4 mb-4">
                    <button type="button" class="btn btn-primary btn-lg shadow-sm mr-2"  data-toggle="modal" data-target="#applicationModal" >
						<i class="fas fa-check-circle"></i> 승인
					</button>
					<button type="button" class="btn btn-primary btn-lg shadow-sm mr-2"  data-toggle="modal" data-target="#applicationModal" >
						<i class="fas fa-check-circle"></i> 반려
					</button>
				</div>
				</div>
                        </div>
                    </div>
            </div>
	</div>
	</div>
    
   <!-- 결재 모달 들어갈곳 -->
   
<!-- Logout Modal-->
<%@ include file="/WEB-INF/views/common/logoutModal.jsp" %>
<!-- footer 영역 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>