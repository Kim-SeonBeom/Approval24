<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- header 영역 -->
<head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
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
                        <h1 class="h3 mb-0 text-gray-800">취업지원금 신청</h1>
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
                                        <tr>
                                            <th scope="col" class="text-dark bg-light  font-weight-bold"  >접수부서</th>
                                            <td colspan="3">취업지원과</td>
                                        </tr>
                                        <tr>
                                            <th scope="col" class="text-dark bg-light font-weight-bold "  >민원서식</th>
                                            <td colspan="3">취업지원금 신청</td>
                                        </tr>
                                        <tr>
                                           <th scope="col" class="text-dark bg-light font-weight-bold "  >담당자</th>
                                            <td colspan="3">이혜성</td>
                                        </tr>
                                        <tr>
                                            <th scope="col" class="text-dark bg-light  font-weight-bold"  >담당자번호</th>
                                            <td colspan="3">010-2859-9296</td>
                                        </tr>
                                        <tr>
                                            <th scope="col" class="text-dark bg-light font-weight-bold"  >접수일</th>
                                            <td>2025-10-15</td>
                                             <th scope="col" class="text-dark bg-light font-weight-bold"  >마감일</th>
                                            <td>2025-11-21</td>
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
								
								<!-- 결재선 지정 -->
								<div class="d-sm-flex align-items-center justify-content-between mb-2	mt-4">
    									<h5 class="h5 mb-0 text-gray-800 mt-4">결재선 설정</h5>
								</div>
								
								<div class="d-flex mb-3">
                                    <select id="presetSelector" class="form-control mr-2" style="max-width: 200px;">
                                        <option value="">북마크 불러오기</option>
                                    </select>
                                    <button type="button" class="btn btn-secondary btn-icon-split btn-sm mr-2" onclick="loadSelectedPreset()">
                                        <span class="icon text-white-50"><i class="fas fa-bookmark"></i></span>
                                        <span class="text">불러오기</span>
                                    </button>
                                    <input id=boomarkName placeholder="북마크 이름을 입력해주세요" style="margin-right:7px;">
                                    <button type="button" class="btn btn-info btn-icon-split btn-sm" onclick="saveApprovalPreset()" style="margin-right:7px;">
                                        <span class="icon text-white-50"><i class="fas fa-save"></i></span>
                                        <span class="text">현재 결재선 저장</span>
                                    </button>
                                    
                                    <button type="button" class="btn btn-danger btn-icon-split btn-sm" onclick="clearPresets()">
									  <span class="icon text-white-50"><i class="fas fa-trash-alt"></i></span>
									  <span class="text">북마크 삭제</span>
									</button>

                                </div>
								
								
								<table class="table table-bordered" width="100%" cellspacing="0">

									<thead>
										<tr>
											<th class="bg-light  text-dark text-center"
												style="border-top: 2px solid #28a745;">기안제목</th>
											<th class="bg-light  text-dark text-center"
												style="border-top: 2px solid #28a745;">결재권한</th>
											<th class="bg-light  text-dark text-center"
												style="border-top: 2px solid #28a745;">결재권자</th>
										</tr>
									</thead>
									
									<tbody id="approvalTableBody">
                                        <!-- 자바스크립트가 동적으로 행을 삽입합니다. -->
                                    </tbody>
								</table>
								
								<!-- 테이블 행 추가 -->
						        <div class="mt-6 text-center">
						            <button id="addRowButton"
									        type="button"
									        class="btn btn-primary text-white"
									        style="background-color:#16a34a; border-color:#16a34a;"
									        onclick="addRow()">
									  + 테이블 행 추가
									</button>
						        </div>
								
								
								
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
                    <button type="button" class="btn btn-primary btn-lg shadow-sm mr-2"  data-toggle="modal" data-target="#approveModal" >
						<i class="fas fa-check-circle"></i> 승인
					</button>
                    <button type="button" class="btn btn-danger btn-lg shadow-sm" data-toggle="modal" data-target="#rejectModal">
						<i class="fas fa-times-circle"></i> 반려
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
</div>
<!-- Logout Modal-->
<%@ include file="/WEB-INF/views/common/logoutModal.jsp" %>
<!-- footer 영역 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
let rowCounter = 0;
const PRESET_STORAGE_KEY = 'approvalPresets';

// ================================================
// 1. 더미 데이터 정의
// ================================================
const APPROVAL_AUTHORITIES = [
  { value: "review",  text: "검토" },
  { value: "approve", text: "승인" }
];

const APPROVAL_USERS = [
  { value: "jeong", text: "정동윤 - 과장" },
  { value: "kim",   text: "김선범 - 팀장" },
  { value: "lee",   text: "이승찬 - 부장" },
  { value: "park",  text: "양윤모 - 차장" }
];

// ================================================
// 2. 헬퍼 함수
// ================================================
function createOptionsHtml(data, selectedValue) {
  if (selectedValue === undefined || selectedValue === null) selectedValue = '';
  let options = '<option value="select">-- 선택하세요 --</option>';
  data.forEach(function(item) {
    let selected = (item.value === selectedValue) ? ' selected' : '';
    options += '<option value="' + item.value + '"' + selected + '>' + item.text + '</option>';
  });
  return options;
}

/** 결재선 테이블의 단일 행 HTML을 생성 */
function generateApprovalRowHtml(authorityValue, userValue, isFirst) {
  if (authorityValue === undefined || authorityValue === null) authorityValue = '';
  if (userValue === undefined || userValue === null) userValue = '';
  rowCounter++;

  const authorityOptions = createOptionsHtml(APPROVAL_AUTHORITIES, authorityValue);
  const userOptions = createOptionsHtml(APPROVAL_USERS, userValue);
  const disabledAttr = isFirst ? ' disabled' : '';
  const titleAttr = isFirst ? ' title="첫 행은 삭제할 수 없습니다"' : ' title="행 삭제"';

  let html = '';
  html += '<tr class="approval-row">';
  html +=   '<td class="align-middle">미용업 영업신고 수리</td>';
  html +=   '<td class="align-middle">';
  html +=     '<select class="form-control" id="authorityId_' + rowCounter + '" name="authorityId" required style="width:100%;">';
  html +=       authorityOptions;
  html +=     '</select>';
  html +=   '</td>';
  html +=   '<td class="align-middle">';
  html +=     '<div class="d-flex align-items-center">';
  html +=       '<select class="form-control mr-2" id="userName_' + rowCounter + '" name="userName" required style="width:70%;">';
  html +=         userOptions;
  html +=       '</select>';
  html +=       '<button type="button" onclick="removeRow(this)" data-role="delete-row" class="btn btn-danger btn-icon-split btn-sm"' + titleAttr + disabledAttr + '>';
  html +=         '<span class="icon text-white-50"><i class="fas fa-trash"></i></span>';
  html +=         '<span class="text">삭제</span>';
  html +=       '</button>';
  html +=     '</div>';
  html +=   '</td>';
  html += '</tr>';
  return html;
}

// ================================================
// 3. 초기화
// ================================================
function initializeForm() {
  const tableBody = document.getElementById('approvalTableBody');
  tableBody.innerHTML = generateApprovalRowHtml('select', 'select', true);
  updatePresetSelector();

  // 삭제 버튼 활성화/비활성화 제어
  const selector = document.getElementById('presetSelector');
  const delBtn = document.querySelector('button[onclick="clearPresets()"]');
  if (selector && delBtn) {
    delBtn.disabled = !selector.value;
    selector.addEventListener('change', function() {
      delBtn.disabled = !selector.value;
    });
  }
}
document.addEventListener('DOMContentLoaded', initializeForm);

// ================================================
// 4. 북마크 기능
// ================================================
function updatePresetSelector() {
  const selector = document.getElementById('presetSelector');
  if (!selector) return;
  const raw = localStorage.getItem(PRESET_STORAGE_KEY) || '{}';
  let presets;
  try { presets = JSON.parse(raw); } catch(e) { presets = {}; }

  while (selector.options.length > 1) selector.remove(1);
  Object.keys(presets).forEach(name => {
    const option = document.createElement('option');
    option.value = name;
    option.textContent = name;
    selector.appendChild(option);
  });
}

// 북마크 저장
function saveApprovalPreset() {
  const input = document.getElementById('boomarkName');
  const name = input && input.value.trim() ? input.value.trim() : '자동 저장 (' + new Date().toLocaleString('ko-KR') + ')';

  const rows = document.querySelectorAll('#approvalTableBody tr');
  const currentApprovalData = [];
  rows.forEach(row => {
    const authorityId = row.querySelector('select[name^="authorityId"]').value;
    const userName = row.querySelector('select[name^="userName"]').value;
    if (authorityId && userName) currentApprovalData.push({ authority: authorityId, user: userName });
  });


  const raw = localStorage.getItem(PRESET_STORAGE_KEY) || '{}';
  let presets;
  try { presets = JSON.parse(raw); } catch(e) { presets = {}; }

  presets[name] = currentApprovalData;
  localStorage.setItem(PRESET_STORAGE_KEY, JSON.stringify(presets));

  updatePresetSelector();
  if (input) input.value = '';
}

// 북마크 불러오기
function loadSelectedPreset() {
  const selector = document.getElementById('presetSelector');
  const name = selector.value;

  const raw = localStorage.getItem(PRESET_STORAGE_KEY) || '{}';
  let presets;
  try { presets = JSON.parse(raw); } catch(e) { presets = {}; }

  const data = presets[name];

  const tableBody = document.getElementById('approvalTableBody');
  tableBody.innerHTML = '';
  rowCounter = 0;
  data.forEach((row, index) => {
    tableBody.insertAdjacentHTML('beforeend', generateApprovalRowHtml(row.authority, row.user, index === 0));
  });

  const firstBtn = tableBody.firstElementChild?.querySelector('button[data-role="delete-row"]');
  if (firstBtn) firstBtn.disabled = true;

}

// 북마크 삭제
function clearPresets() {
  const selector = document.getElementById('presetSelector');
  const name = selector.value;

  const raw = localStorage.getItem(PRESET_STORAGE_KEY) || '{}';
  let presets;
  try { presets = JSON.parse(raw); } catch(e) { presets = {}; }


  delete presets[name];
  localStorage.setItem(PRESET_STORAGE_KEY, JSON.stringify(presets));
  updatePresetSelector();
  selector.selectedIndex = 0;

}

// ================================================
// 5. 행 추가/삭제
// ================================================
function addRow() {
  const tableBody = document.getElementById('approvalTableBody');
  tableBody.insertAdjacentHTML('beforeend', generateApprovalRowHtml('', '', false));
  const firstBtn = tableBody.firstElementChild?.querySelector('button[data-role="delete-row"]');
  if (firstBtn) firstBtn.disabled = true;
}

function removeRow(button) {
  const tableBody = document.getElementById('approvalTableBody');
  const row = button.closest('tr');
  if (!row || !tableBody) return;
  tableBody.removeChild(row);
  const firstBtn = tableBody.firstElementChild?.querySelector('button[data-role="delete-row"]');
  if (firstBtn) firstBtn.disabled = true;
}
</script>
<script>
// 승인 / 반려 모달 관련
function confirmReject() {
  const reason = document.getElementById('rejectComment')?.value || '';
  $('#rejectModal').modal('hide');
}

function confirmApprove() {
  const approvalData = [];
  document.querySelectorAll('#approvalTableBody tr').forEach((row, idx) => {
    const authorityId = row.querySelector('select[name^="authorityId"]').value;
    const userName = row.querySelector('select[name^="userName"]').value;
    if (authorityId && userName) approvalData.push({ order: idx + 1, authorityId, userName });
  });

  const comment = document.getElementById('approveComment')?.value || '';
  $('#approveModal').modal('hide');
}
</script>


</body>
</html>