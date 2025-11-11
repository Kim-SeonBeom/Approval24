<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>${bookmark.bookmarkName} 상세 정보</title>

    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

<div class="container-fluid mt-4">
  <div class="row">
    <!-- 왼쪽 부서/계정 트리 카드 -->
    <div class="col-md-5">
      <div class="card shadow mb-4">
        <div class="card-header py-3">
          <h6 class="m-0 font-weight-bold text-primary">부서 선택</h6>
        </div>
        <div class="card-body" id="deptTreeContainer">
          <ul id="deptTree" class="list-group">
            <!-- AJAX로 부서 목록 불러오기 -->
          </ul>
        </div>
      </div>
    </div>

    <!-- 오른쪽 결재자 카드 -->
    <div class="col-md-7">
      <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex justify-content-between align-items-center">
          <h6 class="m-0 font-weight-bold text-primary">결재자 목록</h6>
          <button id="saveApprovers" class="btn btn-primary btn-sm">수정 반영</button>
        </div>
        <div class="card-body" id="approverCards">
          <c:forEach var="appr" items="${bookmark.approvers}" varStatus="status">
            <div class="card mb-2 approver-card" data-index="${status.index}">
              <div class="card-body d-flex justify-content-between align-items-center">
                <div>${appr.approverName} (${appr.deptName}) - ${appr.approverTypeCdName}</div>
                <button type="button" class="btn btn-danger btn-sm remove-approver">X</button>
              </div>
              <input type="hidden" name="approvers[${status.index}].approverId" value="${appr.approverId}">
              <input type="hidden" name="approvers[${status.index}].approverTypeCd" value="${appr.approverTypeCd}">
            </div>
          </c:forEach>
        </div>
      </div>
    </div>
  </div>
  
  <%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
  
</div>

<script>
$(document).ready(function(){

  // 1. 부서 트리 AJAX 로드
  $.getJSON('/approval24/api/common/depts', function(depts){
    depts.forEach(function(dept){
      let li = $('<li class="list-group-item dept-item"></li>').text(dept.deptName).data('dept', dept);
      li.append('<ul class="list-group mt-1 accounts-list" style="display:none;"></ul>'); // 계정 서브리스트
      $('#deptTree').append(li);
    });
  });

  // 2. 부서 클릭 → 계정 불러오기
  $('#deptTree').on('click', '.dept-item', function(e){
    e.stopPropagation(); // 부모 이벤트 방지
    let $deptLi = $(this);
    let dept = $deptLi.data('dept');
    let $accountList = $deptLi.find('.accounts-list');
    if ($accountList.children().length === 0){
      $.getJSON('/approval24/api/common/accounts', {deptId: dept.deptId}, function(accounts){
        accounts.forEach(function(acc){
          let li = $('<li class="list-group-item list-group-item-action account-item"></li>').text(acc.userName);
          li.data('acc', {id: acc.accountId, name: acc.userName, deptName: dept.deptName});
          $accountList.append(li);
        });
      });
    }
    $accountList.toggle();
  });

  // 3. 계정 클릭 → 오른쪽 카드로 추가
  $('#deptTree').on('click', '.account-item', function(e){
    e.stopPropagation();
    let acc = $(this).data('acc');
    let idx = $('#approverCards .approver-card').length;
    let card = $(`
      <div class="card mb-2 approver-card" data-index="${idx}">
        <div class="card-body d-flex justify-content-between align-items-center">
          <div>${acc.name} (${acc.deptName}) - 신규</div>
          <button type="button" class="btn btn-danger btn-sm remove-approver">X</button>
        </div>
        <input type="hidden" name="approvers[${idx}].approverId" value="${acc.id}">
        <input type="hidden" name="approvers[${idx}].approverTypeCd" value="">
      </div>
    `);
    $('#approverCards').append(card);
  });

  // 4. 제거 버튼
  $('#approverCards').on('click', '.remove-approver', function(){
    $(this).closest('.approver-card').remove();
  });

  // 5. 수정 반영 버튼
  $('#saveApprovers').click(function(){
    $('#approverUpdateForm').submit();
  });
});
</script>
