<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>계정 신청 승인 | 결재24</title>


</head>
<body id="page-top" style="background: linear-gradient(to right, #126C83, #74BCAA); min-height: 100vh;">
	<div id="wrapper" style="background: transparent !important;">

		<div id="content-wrapper" class="d-flex flex-column" style="background: transparent !important;">
			<div id="content" style="background: transparent !important;">

				<div class="container-fluid">
					<!-- Page Heading -->
					<div class="d-flex align-items-center justify-content-between mb-4">
					</div>

					<div class="row justify-content-center">
						<div class="col-lg-10 col-xl-10">
						<form id="requestForm" action="${pageContext.request.contextPath}/account/approveForm" method="post">
							<div class="card shadow mb-4">
								<div class="card-header py-3 d-flex align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">
										계정신청
									</h6>
								</div>

								<div class="card-body">

									<!-- 신청 정보 -->
									<div class="row">
										<!-- 기관 -->
										<div class="col-md-6 mb-3">
											<label>기관</label>
											<select class="form-control" id="instId">
												<option value="">-- 기관 선택 --</option>
												<c:forEach var="inst" items="${instList}">
													<option value="${inst.instId}">${inst.instName}</option>
												</c:forEach>
											</select>
										</div>
										
										<!-- 부서 -->
										<div class="col-md-6 mb-3">
											<label>부서</label>
											<select class="form-control"id="deptId">
												<option value="">-- 부서 선택--</option>
												<c:forEach var="request" items="${deptList}">
													<option value="${request.deptId}">${request.deptName}</option>
												</c:forEach>
											</select>
											<small id="deptMessage" class="form-text text-muted"></small>
										</div>

										<div class="col-md-4 mb-3">
											<label>신청자</label> <input type="text" class="form-control readonly-box" value="${request.userName}" placeholder="신청자 입력" >
										</div>
										<div class="col-md-4 mb-3">
											<label>휴대전화</label> <input type="text" class="form-control readonly-box" value="${request.phone}"placeholder="휴대전화 입력" >
										</div>
										<div class="col-md-4 mb-3">
											<label>주민번호</label> <input type="text" class="form-control readonly-box" value="${request.userResident}"placeholder="주민번호 입력"  >
											<input type="hidden" value='${request.userNo}'>
										</div>
										<!-- 아이디 -->
										<div class="col-md-4 mb-3">
											<label>아이디</label> 
											<div class="input-group">
												<input type="text" class="form-control" name="loginId" id="loginId" value="${request.loginId}"placeholder="아이디 입력" >
												<div class="input-group-append">
													<button class="btn btn-secondary" type="button" id="idCheck">중복확인</button>
												</div>
											</div>
											<input type="hidden" id="idCheckResult" value="false">
											<small id="idCheckMessage" class="form-text text-muted"></small>
										</div>  
										
										<div class="col-md-4 mb-3">
											<label>비밀번호</label> <input id="password" type="password" class="form-control readonly-box" value="${request.password}"  placeholder="비밀번호 입력">
										</div>
										
										<div class="col-md-4 mb-3">
											<label>비밀번호 확인</label> <input id="passwordCheck"type="password" class="form-control readonly-box" placeholder="비밀번호 확인" >
    										<small id="passwordCheckMessage" class="form-text text-muted"></small>
										</div>
									</div>
									<!-- row끝 -->
											<!-- 권한 요청 start-->
											<div id="authFieldsContainer" class="row">
												<div class="col-md-6 mb-3 auth-field-group" data-index="0">
													<label>요청 권한</label>
													<div class="input-group">
													
													<!--권한 리스트 -->
														<select class="form-control auth-select"name="requestAuthName" required>
															<option value="">-- 권한을 선택하세요 --</option>
															<c:forEach var="request" items="${authList}">
																<option value="${request.authorityId}">${request.authorityName}</option>
															</c:forEach>
														</select>
														
														<div class="input-group-append">
															<button class="btn btn-success btn-add-auth"	type="button">+</button>
														</div>
														
													</div>
												</div>
											</div>
											<!-- 권한 요청 end-->

										</div>




								<div class="d-flex justify-content-between mb-4 ml-4 mr-4">
									<a href="${pageContext.request.contextPath}/login" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 홈으로 가기
									</a>

									<div>
											<button type="submit" class="btn btn-primary" id="btnApprove">
												<i class="fas fa-check mr-1"></i> 신청
											</button>
									</div>
								</div>						
							</div>
							</form>
						</div>

					</div>
				</div>

			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#content -->

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	<!-- /#content-wrapper -->

	<!-- /#wrapper -->

	<script>
		$(document).ready(function(){
			// 아이디
			const $loginId = $('#loginId');
			const $idCheckMessage = $('#idCheckMessage');
			const $idCheckResult = $('#idCheckResult');
			// 패스워드
			const $password = $('#password');
			const $passwordCheck = $('#passwordCheck');
			const $passwordCheckMessage =$('#passwordCheckMessage');
			//부서
			const $instId = $('#instId');
			const $deptId = $('#deptId');
			const $deptMessage = $('#deptMessage');
			
			// 권한 설정
			const $container = $('#authFieldsContainer');
			
			const $firstSelect = $container.find('.auth-select').first();
			const originalOptionsHtml = $firstSelect.html();
			
			//==================================================================
			// 권한 필드
			function getUsedAuthIds(){
				// 권한 중복 제거를 위한 배열
				const usedIds = [];
				$container.find('.auth-select').each(function(){
					const selectOption =[];
					const selectedId = $(this).val();
					if(selectedId && selectedId !==""){
						usedIds.push(selectedId);
					}
					if(authId){
						selectOption.push({
							"authorityId" : authorityId,
							"authorityName" : authorityName
						});
					}
				});
				return usedIds;
			}
			
			//최종 올 옵션
			function updateAllAuthOptions(){
				const usedIds = getUsedAuthIds();
				
				$container.find('.auth-select').each(function(){
					const $currentSelect = $(this);
					const currentSelectedId = $currentSelect.val();
					
					//Rette mich
					$currentSelect.html(originalOptionsHtml);
					
					usedIds.forEach(authorityId =>{
						if(authorityId !== currentSelectedId &&authorityId !== ""){
							$currentSelect.find(`option[value="${authorityId}"]`).remove();
						}
					});
					$currentSelect.val(currentSelectedId);
				});
			}
			
			//  번호 정렬
			function reorderAuthLabels() {
   				$container.find('.auth-field-group').each(function(index) {
   					const $label = $(this).find('label');
           			$label.text(`요청 권한 `);
    			});

    			// 마지막 그룹에만 + 버튼 유지
   				const $allGroups = $container.find('.auth-field-group');
   				$allGroups.find('.btn-add-auth').remove(); // 전체 + 제거
   				$allGroups.find('.btn-remove-auth').removeClass('btn-success').addClass('btn-danger').text('-');

    			const $lastGroup = $allGroups.last();
    			const $append = $lastGroup.find('.input-group-append');

    			$append.html('<button class="btn btn-success btn-add-auth" type="button">+</button>');
			}

			// 추가 템플릿
			const authFieldTemplate = `
	            <div class="col-md-6 mb-3 auth-field-group">
				<label>요청 권한</label>
	                <div class="input-group">
	                    <select class="form-control auth-select" name="requestAuthName" required>
	                        </select>
	                    <div class="input-group-append">
	                        <button class="btn btn-danger btn-remove-auth" type="button">-</button>
	                    </div>
	                </div>
	            </div>
	        `;
			
			
		// + 버튼 눌렀을때 추가
  		$container.on('click', '.btn-add-auth', function() {
	  		const usedIds = getUsedAuthIds();

   		 	// 새 필드 생성
    		const $newField = $(authFieldTemplate);
    		const $newSelect = $newField.find('.auth-select');
    		$newSelect.html(originalOptionsHtml);

   			// 이미 선택된 권한 제거
    		usedIds.forEach(authorityId => {
        		$newSelect.find(`option[value="${authorityId}"]`).remove();
    		});
   		

    		// 기존 모든 + 버튼을 제거하고 -로 변경
    		$container.find('.btn-add-auth')
        		.removeClass('btn-success btn-add-auth')
        		.addClass('btn-danger btn-remove-auth')
        		.text('-');
    

			// 새 필드를 컨테이너에 추가
			$container.append($newField);

   			// 필드 인덱스 재정렬
  			reorderAuthLabels();
    		updateAllAuthOptions();
		});

        
        // 권한 선택 변경시 (다른 필드의 옵션 업데이트)
        $container.on('change', '.auth-select', function() {
            updateAllAuthOptions();
        });
        
        // 권한 필드 제거 버튼
        $container.on('click', '.btn-remove-auth', function() { 
            const $group = $(this).closest('.auth-field-group'); 
            $group.remove();
            reorderAuthLabels(); 
            updateAllAuthOptions(); 
        });
		// ========================================================

		// 기관에 따른 부서
		$('#instId').on('change', function(){
			const instId = $instId.val().trim();
			if(instId ==null || instId ==""){
				$deptMessage.text("기관을 선택해주세요.").css('color', 'red');
			}
			// 기관 선택시 부서 목록 불러오기
			
			else{
				$.ajax({
					url: '${pageContext.request.contextPath}/account/getDeptList',
					type: 'GET',
					data: {instId: instId},
					dataType: 'json',
					success: function(response){
						const deptId = $deptId.val().trim();
						$deptId.empty();
						$deptId.append('<option value="">-- 부서 선택 --</option>');
						
						if(response && response.length >0){
							$.each(response, function(index, dept){
								$deptId.append($('<option>', {
											value: dept.deptId,
											text: dept.deptName
								}));
							});
						} else{
							$deptMessage.text("해당 기관에 등록된 부서가 없습니다.");
						}
				},
				error: function(xhr, status, error) {
					$deptMessage.text("부서 목록을 불러오지 못했습니다: " + error).css('color', 'red');
				}
			});
		}
	});
		
			
		// ========================================================
			
			//패스워드 체크
			$('#passwordCheck').on('input', function(){
				const password = $password.val().trim();
				const passwordCheck = $passwordCheck.val().trim();
				
				if(password === passwordCheck ){
					$passwordCheckMessage.text("비밀번호가 일치합니다.").css('color', 'blue');
				}
				else{
					$passwordCheckMessage.text("비밀번호가 일치하지 않습니다.").css('color', 'red');
				}
			});
			$password.on('input', function() {
	            $passwordCheck.trigger('input'); 
	        });
			 
			$('#idCheck').on('click', function(){
				const loginId = $loginId.val().trim();
				
				console.log('/account/checkID');
				
				// 아이디는 4자 이상으로
				if(loginId.length <4){
					$idCheckMessage.text("아이디는 최소 4자 이상으로 합니다.").css('color', 'red');
					$idCheckResult.val('false');
					return;
				}
				$.ajax({
					url: '${pageContext.request.contextPath}/account/checkID',
					type: 'GET',
					data: {loginId: loginId},
					success: function(response){
						if(response.available){
							$idCheckMessage.text("사용 가능한 아이디입니다.").css('color', 'blue');
							$idCheckResult.val('true');
						}
						else{
							$idCheckMessage.text("사용 불가능한 아이디입니다.").css('color', 'red');
							$idCheckResult.val('false');
						}
					},
					error: function() {
	                    $idCheckMessage.text("서버 오류가 발생했습니다.").css('color', 'red');
	                    $idCheckResult.val('false');
	                }
					
				});
			});
			
			// 제출전 최종확인
			$loginId.on('input', function(){
				$idCheckMessage.text("아이디 중복 확인이 필요합니다.").css('color', 'gray');
				$idCheckResult.val('false');
			});
			$('#requestForm').on('submit', function(e){
				if($idCheckResult.val() !== 'true'){
					e.preventDefault();
					alert("아이디 중복 확인을 완료해주세요.");
					$loginId.focus();
					return;
				}
				if ($password.val() !== $passwordCheck.val()) {
					e.preventDefault();
	                alert("비밀번호와 확인이 일치하지 않습니다.");
	                $passwordCheck.focus();
	                return; 
	            }
				// 권한 체크
				let authFilled = true;
	            $container.find('.auth-select').each(function() {
	                if ($(this).val() === "") {
	                    authFilled = false;
	                    return false; 
	                }
	            });

	            if (!authFilled) {
	                e.preventDefault();
	                alert("요청 권한을 모두 선택해주세요.");
	                return;
	            }
			});
			updateAllAuthOptions();
		});
	</script>
</body>
</html>