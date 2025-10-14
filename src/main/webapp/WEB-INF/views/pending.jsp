<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- header 영역 -->
<head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
</head>
<title>결재 승인</title>
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
				<div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">취업지원급 신청</h1>
                 </div>
                 
                  <!-- DataTables Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex align-items-center">
                        	<h6 class="m-0 font-weight-bold text-primary">접수번호</h6>
    						<h6 class="mt-2 ms-3 ml-4">2058230690</h6>
    					</div>
                        <div class="card-body">
                            <div class="table-responsive">
                            <!-- 접수표 -->
                                <table class="table table-bordered mb-4" id="dataTable_index" width="100%" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td class="text-dark bg-light  font-weight-bold" style="width: 25%;"  >접수일자</td>
                                            <td>2025-10-13</td>
                                        </tr>
                                        <tr>
                                            <td class="text-dark bg-light font-weight-bold " style="width: 25%;" >처리기한</td>
                                            <td>2025-11-22</td>
                                        </tr>
                                        <tr>
                                           <td class="text-dark bg-light font-weight-bold " style="width: 25%;" >민원서식명</td>
                                            <td>취업지원금 신청</td>
                                        </tr>
                                        <tr>
                                            <td class="text-dark bg-light  font-weight-bold" style="width: 25%;" >접수부서</td>
                                            <td>취업지원 민원처리과</td>
                                        </tr>
                                        <tr>
                                            <td class="text-dark bg-light font-weight-bold" style="width: 25%;" >담당자</td>
                                            <td>이혜성</td>
                                        </tr>
                                        <tr>
                                            <td class="text-dark bg-light font-weight-bold" style="width: 25%;" >담당자 전화번호</td>
                                            <td>031-248-8596</td>
                                        </tr>
                                    </tbody>
                                   </table>
                                   
                                   <!-- 결제 내용 표 -->
								<table class="table table-bordered mt-4" id="dataTable_index"
									width="100%" cellspacing="0">
									<tbody>
										<tr>
											<td class="text-dark bg-light font-weight-bold text-center align-middle"
												style="width: 25%;">결제 내용</td>
											<td colspan="1"><textarea class="form-control"
													id="pendingContent" rows="10"
													placeholder="결제 상세 내용을 입력하세요." style="resize: none;">
제출된 취업지원금 신청서와 관련 서류를 검토한 결과, 해당 신청은 취업지원 프로그램의 자격 요건을 모두 충족하며, 지급 대상자로 확인 되었습니다. 승인바랍니다.
                </textarea></td>
										</tr>

										<tr>
											<td class="text-dark bg-gray-400 font-weight-bold text-center"
												style="width: 25%;"><span>첨부파일</span></td>
											<td>
												<i class="fas fa-file-download"></i>
												<a href="[실제 파일 다운로드 경로]">
                    								거지증명서.hwp
                								</a>
											</td>
										</tr>
									</tbody>
								</table>
								
								<!-- 진행내역 -->
								<div class="d-sm-flex align-items-center justify-content-between mb-2	mt-4">
    									<h5 class="h5 mb-0 text-gray-800 mt-4">결재 진행 상태</h5>
								</div>
								<table class="table table-bordered" width="100%" cellspacing="0">

									<thead>
										<tr>
											<th class="bg-light  text-dark text-center"
												style="border-top: 2px solid #28a745;">기안제목</th>
											<th class="bg-light  text-dark text-center"
												style="border-top: 2px solid #28a745;">결재권자</th>
											<th class="bg-light text-dark text-center"
												style="border-top: 2px solid #28a745;">결재결과</th>
											<th class="bg-light  text-dark text-center"
												style="border-top: 2px solid #28a745;">결재일시</th>
											<th class="bg-light text-dark text-center"
												style="border-top: 2px solid #28a745;">결재의견</th>
										</tr>
									</thead>

									<tbody>
										<tr>
											<td>미용업 영업신고 수리</td>
											<td>김OO</td>
											<td>승인</td>
											<td>2025-10-14</td>
											<td></td>
										</tr>
										<tr>
											<td>미용업 영업신고 수리</td>
											<td>김OO</td>
											<td>미처리</td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>

							<div class="text-right mt-4 mb-4">
                    <button type="button" class="btn btn-success btn-lg shadow-sm mr-2" onclick="approvePayment()">
						<i class="fas fa-check-circle"></i> 승인
					</button>
                    <button type="button" class="btn btn-danger btn-lg shadow-sm" onclick="rejectPayment()">
						<i class="fas fa-times-circle"></i> 반려
					</button>
				</div>
				</div>
                        </div>
                    </div>
            </div>
	</div>
	</div>
</body>
</html>