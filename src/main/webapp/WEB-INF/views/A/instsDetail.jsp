<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<%-- 외부 JSP 파일 포함: header.jsp, footer.jsp, navbar.jsp, sidebar.jsp, logoutModal.jsp 등은 프로젝트 구조에 맞게 위치해야 합니다. --%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>기관 상세 | 결재24</title>
<style>
/* 표 기반(딱딱한) 작성 레이아웃 */
.kv-table th {
	width: 140px;
	background: #f8f9fc;
	vertical-align: middle;
}

.kv-table td {
	background: #fff;
}

/* 상세와 동일한 룩앤필 유지 */
.kv-table .content-cell {
	white-space: pre-wrap;
	line-height: 1.6;
	min-height: 300px; /* 상세와 동일한 최소 높이 */
}

/* 파일 리스트 UI 정리 */
.kv-table .attach-cell ul {
	margin: 0;
	padding-left: 1rem;
}

.kv-table .attach-cell li+li {
	margin-top: .25rem;
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

					<div class="d-sm-flex align-items-center justify-content-between mb-3">
						<h1 class="h3 mb-0 text-gray-800">기관 상세</h1>
					</div>
					
					<%-- 컨트롤러에서 전달받은 수정메시지 표시 --%>
					<c:if test="${not empty updMessage}">
					    <div class="alert alert-info alert-dismissible fade show" role="alert">
					        ${updMessage}
					        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					        </button>
					    </div>
					</c:if>

					<div class="card shadow mb-4">

						<div class="card-header py-3 d-flex align-items-center">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">상세 내용</h6>
							<div class="ml-auto">
								<button type="button" class="btn btn-primary btn-sm" id="btnUpdateTop">
									<i class="fas fa-edit mr-1"></i>수정
								</button>
								<button type="button" class="btn btn-danger btn-sm ml-2" id="btnDeleteTop">
								    <i class="fas fas-trash-alt mr-1"></i>삭제
								</button>
								
							</div>

						</div>


						<div class="card-body">
						
							<form id="instUpdateForm" action="/approval24/admin/insts/update" method="post">
                                
                                <input type="hidden" name="instId" value="${inst.instId}" id="instIdValue">
                                
                                
								<div class="table-responsive">
									<table class="table table-bordered table-sm kv-table">
										<colgroup>
											<col style="width: 18%;">
											<col style="width: 32%;">
											<col style="width: 18%;">
											<col style="width: 32%;">
										</colgroup>
										<tbody>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">기관명</th>
												<td colspan="3"><input type="text" name="instName" id="instName" class="form-control form-control-sm" value="${inst.instName}" required maxlength="200"></td>
											</tr>

											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">대표자명</th>
												<td><input type="text" name="instHeadName" id="instHeadName" class="form-control form-control-sm" value="${inst.instHeadName}" required></td>
												<th>기관 등록일</th>
												<td>
                                                    <%-- 날짜 형식 변경 (DTO에서 String 타입으로 변환되거나, DTO에 @DateTimeFormat이 적용되어야 함) --%>
                                                    <input type="date" class="form-control form-control-sm" value="${inst.createDt}" name="createDt">
                                                </td>
											</tr>

											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold"
													style="vertical-align: middle;">주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text" class="form-control form-postal-code mr-2"
															placeholder="우편번호" name="instPost"
															id="instPost" value="${inst.instPost}" style="width: 150px;">
						
														<button type="button" class="btn btn-secondary btn-sm"
															onclick="openDaumPostcode()">주소 검색</button>
													</div> 
													<input type="text" class="form-control mb-2" placeholder="기본 주소" 
													name="instAddress" id="instAddress" value ="${inst.instAddress}">
													<input type="text" class="form-control" value="${inst.instDetailAddress}"
													placeholder="상세 주소 (건물명, 동/호수 등)" name="instDetailAddress"
													id="instDetailAddress">
												</td>
											</tr>

											<tr>
												<th>기관 연락처</th>
												<td colspan="3"><input type="tel" class="form-control form-control-sm" value="${inst.instPhone}"
													name="instPhone"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</form>


						</div>
					</div>

				</div>
				</div>
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2020</span>
					</div>
				</div>
			</footer>
			</div>
		</div>
	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
$(document).ready(function() {
    
    // 폼 객체 및 URL 정의
    const $updateForm = $('#instUpdateForm');
    const updateActionUrl = $updateForm.attr('action'); // 초기 action: "/approval24/admin/insts/update"
    const deleteActionUrl = '/approval24/admin/insts/delete'; // 삭제 URL
    
    // 폼 내의 모든 입력 필드 (type=button, type=hidden 제외)
    const $updatableInputs = $updateForm.find(':input').not(':button, :hidden');
    const $addressButton = $('#btnSearchAddress'); // 주소 검색 버튼
    
    // 1. 초기 상태 설정
    
    // 폼 입력 필드를 기본적으로 readonly 설정
    $updatableInputs.prop('readonly', true);
    
    // 주소 검색 버튼 비활성화
    $addressButton.prop('disabled', true);
    
    // 2. 수정/저장 버튼 로직 (btnUpdateTop)
    $('#btnUpdateTop').on('click', function () {
        const $btn = $(this);
        const isReadonly = $updatableInputs.first().prop('readonly');

        if (isReadonly) {
            $updatableInputs.prop('readonly', false);
            $updatableInputs.prop('disabled', false); // disabled 상태 해제 (삭제 로직이 걸었을 경우 대비)
            $addressButton.prop('disabled', false); 

            $btn.html('<i class="fas fa-save mr-1"></i>저장');
            $btn.removeClass('btn-primary').addClass('btn-success');
            
        } else {

            if (confirm('수정된 내용을 저장하시겠습니까?')) {
                // **폼 action을 항상 UPDATE URL로 재설정 후 제출합니다. (삭제 로직이 action을 변경했을 수 있기 때문)
                $updateForm.attr('action', updateActionUrl);
                $updateForm.submit();
            }
        }
    });

    // 3. 삭제 버튼 로직 (btnDeleteTop)
    $('#btnDeleteTop').on('click', function() {
        
        if (confirm('정말로 이 기관을 삭제하시겠습니까? 삭제된 데이터는 복구되지 않습니다.')) {
            
            // **instId를 제외한 모든 입력 필드를 비활성화 (삭제에는 instId만 필요하며, 불필요한 필드 전송 방지)
            $updatableInputs.prop('disabled', true);
            
            // 폼의 action을 삭제 URL로 변경
            $updateForm.attr('action', deleteActionUrl);
            
            // 폼 제출 (POST /approval24/admin/insts/delete 호출)
            $updateForm.submit();
        }
    });

});

// 1. Daum Postcode API 함수 (openDaumPostcode)
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // R: 도로명, J: 지번
            const addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
            
            // 우편번호 (ID: instPost)
            document.getElementById('instPost').value = data.zonecode; 
            
            // 기본 주소 (ID: instAddress)
            document.getElementById('instAddress').value = addr;
            
            // 상세 주소 입력창에 포커스 (ID: instDetailAddress)
            document.getElementById('instDetailAddress').focus();
        }
    }).open();
}

// 2. 폼 제출 로직 (btnUpdateTop)
//    - 버튼이 폼 외부에 있으므로, 클릭 시 명시적으로 폼 제출
$(document).ready(function() {
    
    // 폼 외부에 있는 등록 버튼 클릭 시 폼 제출
    $('#btnUpdateTop').on('click', function(e) {
        
        if (!form.checkValidity()) {
             // 유효성 검사 실패 시 브라우저가 기본 동작을 수행하고 제출 중단
             return; 
        }
        
        // 폼 제출
        $('#').submit();
    });
});

</script>

</body>
</html>