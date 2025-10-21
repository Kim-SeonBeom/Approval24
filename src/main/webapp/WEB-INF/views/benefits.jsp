<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- header 영역 -->
<head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
</head>
<title>실업급여 인정 신청</title>
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
	
	<!-- sidebar -->
	<%@ include file="/WEB-INF/views/common/sidebar2.jsp" %>
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
                        <h1 class="h3 mb-0 text-gray-800">실업급여인정 신청</h1>
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
                                    <colgroup>
	                                	<col style="width: 18%;">
	                                	<col style="width: 32%;">
	                                	<col style="width: 18%;">
	                                	<col style="width: 32%;">
	                                </colgroup>
                                    <tbody>
                                    <!-- 신청자 이름 -->
                                        <tr >
                                            <th scope="col" class="text-dark bg-light  font-weight-bold"  style="vertical-align: middle;" >신청인</th>
                                            <td>
                                                <input type="text" class="form-control" id="applicantName" name="applicantName" placeholder="신청자 이름">
											</td>
									<!-- 주민등록번호 -->
											<th scope="col" class="text-dark bg-light  font-weight-bold"  style="vertical-align: middle;" >주민등록번호</th>
                                            <td>
                                                <input type="text"  id="jumin_front" maxlength="6" inputmode="numeric" pattern="[0-9]*" placeholder="생년월일 6자리" style="width: 40%; display: inline-block;">
                                                <span class="mx-1">-</span>
                                                <input type="text"  id="jumin_back" maxlength="7" inputmode="numeric" pattern="[0-9]*" placeholder="뒤 7자리" style="width: 50%; display: inline-block;">
											</td>
                                        </tr>
                                        
                                    <!-- 주소 -->
                                        <tr>
                                        	<th scope="col" class="text-dark bg-light font-weight-bold" style="vertical-align: middle;">주소</th>
                                        	<td colspan="3">
                                        	<div class="d-flex mb-2">
                                        		<input type="text" class="form-control form-postal-code mr-2" placeholder="우편번호" name="postalCode"  id="postalCode"readonly style="width: 150px;">
                                        		
                                        		<button type="button" class="btn btn-secondary" onclick="openDaumPostcode()">주소 검색</button>
                                        	</div>
                                        	
                                        	<input type="text" class="form-control mb-2" placeholder="기본 주소" name="addr1" id="addr1" readonly>
                                        	<input type="text" class="form-control" placeholder="상세 주소 (건물명, 동/호수 등)" name="addr2"id="addr2">
                                        	</td>
                                        </tr> 
                                        
                                   <!-- 날짜지정 -->
                                        <tr >
                                            <th scope="col" class="text-dark bg-light  font-weight-bold"  style="vertical-align: middle;" >실업인정일</th>
                                            <td>
                                                <input type="date" class="form-control" id="applicantName" name="applicantName" placeholder="실업인정일">
											</td>

											<th scope="col" class="text-dark bg-light  font-weight-bold"  style="vertical-align: middle;" >실업인정대상기간</th>
                                            <td class="form-control">
                                                <input type="date"  class ="mr-4"id="jumin_front" placeholder="시작일"> ~ 
                                                <input type="date"  class ="ml-4" id="jumin_back" placeholder="마감일">
											</td>
                                        </tr>
                                        
                                        <!-- 지급계좌 -->
                                        <tr >
                                            <th scope="col" class="text-dark bg-light  font-weight-bold"  style="vertical-align: middle;" >은행명</th>
                                            <td>
                                                <input type="text" class="form-control" id="applicantName" name="applicantName" placeholder="은행명">
											</td>
											<th scope="col" class="text-dark bg-light  font-weight-bold"  style="vertical-align: middle;" >예금주</th>
                                            <td class="form-control">
                                              <input type="text" class="form-control" id="applicantName" name="applicantName" placeholder="예금주">
											</td>
                                        </tr>
                                        <tr >
                                            <th scope="col" class="text-dark bg-light  font-weight-bold"  style="vertical-align: middle;" >계좌번호</th>
                                            <td colspan="3">
                                                <input type="text" class="form-control" id="applicantName" name="applicantName" placeholder="계좌번호">
											</td>
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
                    								취업지원증명서.hwp
                								</a>
											</td>
										</tr>
									</tbody>
								</table>
								
								<!-- 실업인정 유형 -->
								<table class="table table-bordered mt-4" id="lostadmit_index"
									width="100%" cellspacing="0">
									 <colgroup>
	                                	<col style="width: 9%;">
	                                	<col style="width: 16%;">
	                                	<col style="width: 9%;">
	                                	<col style="width: 16%;">
	                                	<col style="width: 9%;">
	                                	<col style="width: 16%;">
	                                	<col style="width: 9%;">
	                                	<col style="width: 16%;">
	                                </colgroup>
									<tbody>
										<tr>
										<!-- 칼럼 선택 -->
											<th  colspan="2" class="text-dark bg-light font-weight-bold text-center align-middle">실업인정 내역</th>	
											<td colspan="6">
											<label>
											<input type="radio" name="payment_method" value="change">실업인정일 변경</label>
											<label>
											<input class="ml-4" type="radio" name="payment_method" value="certification">증명서에따른 실업인정</label>
											<label>
											<input class="ml-4" type="radio" name="payment_method"  value="provisional">잠정실업인정</label>
											<label>
											<input class="ml-4" type="radio" name="payment_method"value="termination">해고효력을 다투는 자의 실업인정</label><br>
											<label>
											<input type="radio" name="payment_method" value="sickness">상병급여 청구와 병행</label>
											<label>
											<input class="ml-4" type="radio" name="payment_method"  value="heir">유족의 청구에 따른 실업인정</label>
											</td>
										</tr>
										
										<!-- 지급사항 -->
										<tr>
											<th scope="col" class="text-dark bg-gray-400 font-weight-bold text-center  align-middle"><span>지급사항</span></th>
											<td class="text-dark font-weight-bold  align-middle">처리</td>
											<th scope="col" class="text-dark font-weight-bold text-center  align-middle"><span>실업인정일수</span></th>
											<td>
											<input type="number" class="form-control" id="lostAgreeDate" name="lostAgreeDate" placeholder="실업인정일수"></td>
											<th scope="col" class="text-dark font-weight-bold text-center"><span>구직급여산출명세	</span></th>
											<td>
											<input type="text" class="form-control" id="lostAgreeDate" name="lostAgreeDate" placeholder="구직급여산출명세"></td>
											<th scope="col" class="text-dark font-weight-bold text-center  align-middle"><span>지급액</span></th>
											<td>
											<input type="number" class="form-control" id="lostAgreeDate" name="lostAgreeDate" placeholder="지급액"></td>
										</tr>
									</tbody>
								</table>
								
								

							<div class="text-right mt-4 mb-4">
                    <button type="button" class="btn btn-success btn-lg shadow-sm mr-2"  data-toggle="modal" data-target="#approveModal" >
						<i class="fas fa-check-circle"></i> 신청
					</button>
				</div>
				</div>
                        </div>
                    </div>
            </div>
	</div>
	</div>
    
   <div class="modal fade" id="rejectModal" tabindex="-1" role="dialog" aria-labelledby="rejectModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="rejectModalLabel">반려 사유</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                     <textarea class="form-control" id="rejectComment" rows="4" placeholder="반려 사유를 입력하세요.(필수)" required></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                     <button type="button" class="btn btn-danger" onclick="confirmReject()">반려 확인</button> 
                </div>
            </div>
        </div>
    </div>	
    
    <div class="modal fade" id="approveModal" tabindex="-1" role="dialog" aria-labelledby="approveModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="approveModalLabel">승인 코멘트</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <textarea class="form-control" id="approveComment" rows="4" placeholder="승인 코멘트를 입력하세요. (선택)" ></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" onclick="confirmApprove()">승인 확인</button> 
                </div>
            </div>
        </div>
    </div>	
<!-- Logout Modal-->
<%@ include file="/WEB-INF/views/common/logoutModal.jsp" %>
<!-- footer 영역 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<!-- 다음 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 주소 설정
function openDaumPostcode(){
	new daum.Postcode({
		oncomplete: function(data){
			// 도로명
			var roadAddr = data.roadAddress;
			// 지번
			var jibunAddr = data.jibunAddress;
			// 우편번호
			var extraRoadAddr='';
			
			if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				extraRoadAddr += data.bname;
			}
			
			if(data.bname !== '' && data.apartment === 'Y'){
				extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}
			
			if(extraRoadAddr !== ''){
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}
			
			document.getElementById('postalCode').value = data.zonecode;
			document.getElementById("addr1").value = roadAddr;
			
			document.getElementById("addr2").focus();
		}
			
	}).open();
	
}


</script>
</html>