<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 등록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .approver-box { border: 1px dashed #ccc; padding: 10px; margin-bottom: 10px; }
        .approver-list-item { margin-top: 5px; border: 1px solid #eee; padding: 5px; }
    </style>
</head>
<body>
    <h1>새 북마크 등록 ✨</h1>
    
    <form action="/approval24/bookmark/create" method="post" id="bookmarkForm">
        <p>
            <label for="bookmarkName">북마크 이름:</label>
            <input type="text" id="bookmarkName" name="bookmarkName" required>
        </p>
        
        <p>
            <label for="accountId">작성자 ID:</label>
            <%-- 실제 환경에서는 세션에서 가져와 hidden 필드로 처리 --%>
            <input type="number" id="accountId" name="accountId" value="1" required> 
        </p>

        <div class="approver-box">
            <h3>결재자 추가</h3>
            
            <%-- 1. 부서 선택 드롭다운 (Controller에서 받은 depts 사용) --%>
            <label for="deptSelect">부서 선택:</label>
            <select id="deptSelect">
                <option value="">-- 부서를 선택하세요 --</option>
                <c:forEach var="dept" items="${depts}">
                    <option value="${dept.deptId}">${dept.deptName}</option>
                </c:forEach>
            </select>
            
            <%-- 2. 부서 선택에 따라 계정 목록이 동적으로 채워질 곳 --%>
            <div id="accountList" style="margin-top: 10px;">
                </div>
            
            <%-- 3. 최종적으로 등록될 결재자 목록 --%>
            <h4 style="margin-top: 20px;">선택된 결재 경로 (Approvers)</h4>
            <div id="selectedApprovers">
                </div>
        </div>

        <button type="submit">북마크 저장</button>
        <a href="/approval24/bookmark/list">취소</a>
    </form>
    
    <script>
        // 1. 부서 선택 시 해당 부서의 계정 목록을 불러오는 AJAX
        $('#deptSelect').on('change', function() {
            var deptId = $(this).val();
            if (deptId) {
                $.ajax({
                    url: '/approval24/bookmark/accounts', // 컨트롤러의 @PostMapping("/accounts") 매핑
                    type: 'POST',
                    data: { deptId: deptId },
                    success: function(accounts) {
                        var html = '<ul>';
                        if (accounts.length > 0) {
                            $.each(accounts, function(i, acc) {
                                html += '<li class="approver-list-item">' + 
                                        acc.userName + ' (' + acc.deptName + ') ' + 
                                        '<button type="button" onclick="addApprover(' + acc.accountId + ', \'' + acc.userName + '\')">추가</button>' +
                                        '</li>';
                            });
                        } else {
                            html += '<li>해당 부서에 활성 계정이 없습니다.</li>';
                        }
                        html += '</ul>';
                        $('#accountList').html(html);
                    },
                    error: function() {
                        alert('계정 목록을 불러오는 데 실패했습니다.');
                    }
                });
            } else {
                $('#accountList').empty();
            }
        });

        // 2. '추가' 버튼 클릭 시 결재자 목록에 추가
        var approverCount = 0; // 결재자 순번(seqNo)에 사용
        function addApprover(accountId, approverName) {
            approverCount++;
            
            // DTO 구조에 맞게 Hidden 필드와 표시 요소를 추가
            var approverHtml = '<div id="appr_' + approverCount + '" style="margin-bottom: 5px;">' +
                                '<strong>순서 ' + approverCount + ' : ' + approverName + '</strong>' +
                                // List<Approver> approvers[i].fieldName 형식으로 Spring이 바인딩
                                '<input type="hidden" name="approvers[' + (approverCount - 1) + '].seqNo" value="' + approverCount + '">' +
                                '<input type="hidden" name="approvers[' + (approverCount - 1) + '].approverId" value="' + accountId + '">' +
                                '<input type="hidden" name="approvers[' + (approverCount - 1) + '].approverTypeCd" value="AP01">' + // 예시 코드
                                '<input type="hidden" name="approvers[' + (approverCount - 1) + '].delYn" value="N">' +
                                '<button type="button" onclick="removeApprover(' + approverCount + ')">제거</button>' +
                                '</div>';
            
            $('#selectedApprovers').append(approverHtml);
        }

        // 3. 결재자 제거
        function removeApprover(seq) {
            $('#appr_' + seq).remove();
            // 참고: 실제 운영 환경에서는 순번(seqNo)을 다시 매겨주는 로직이 필요할 수 있습니다.
        }
    </script>
</body>
</html>