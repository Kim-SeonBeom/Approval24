<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
**<%@ page isELIgnored="true" %>**


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Approval History Test</title>
</head>
<body>
    <h3>결재 내역 테스트 </h3>

    <div style="margin-top:10px;">
        <table id="historyTable" border="1" cellpadding="6" cellspacing="0">
            <thead>
                <tr>
                    <th>카테고리</th>
                    <th>사용자</th>
                    <th>결재자 유형</th>
                    <th>상태</th>
                    <th>처리일</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>

    <div style="margin-top:12px;">
        <label>의견: <input type="text" id="comment" /></label>
        <button id="approveBtn">승인</button>
        <button id="rejectBtn">반려</button>
    </div>

    <script>
        const ctx = '<%= request.getContextPath() %>';
        
        const complainIdString = $('input[name="complainId"]').val();
        
        if (!complainIdString || isNaN(complainIdString)) {
            return console.error("민원 ID가 유효하지 않습니다. HTML input[id='complain-id']의 value를 확인하세요.");
        }

        const complainIdInt = parseInt(complainIdString, 10);
        
        let approvalList = [];

        document.getElementById('approveBtn').addEventListener('click', () => sendDecision('E002'));
        document.getElementById('rejectBtn').addEventListener('click', () => sendDecision('E003'));

        // 페이지 로드시 결재 내역 자동 로드
        window.addEventListener('load', loadLine);

        async function loadLine() {
            const tbody = document.querySelector('#historyTable tbody');
            tbody.innerHTML = '<tr><td colspan="5">로딩 중...</td></tr>';
            try {
                const res = await fetch(ctx + '/api/approval/line?complainId=' + complainIdInt, { credentials: 'same-origin' });
                approvalList = await res.json();

                if (!Array.isArray(approvalList) || approvalList.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="5">결재 이력이 없습니다.</td></tr>';
                    return;
                }

                tbody.innerHTML = '';
                approvalList.forEach(item => {
                    const tr = document.createElement('tr');
                    tr.innerHTML = `
                        <td>${item.categoryName || ''}</td>
                        <td>${item.userName || ''}</td>
                        <td>${item.approverTypeName || ''}</td>
                        <td>${item.approvalStatusName || ''}</td>
                        <td>${item.processDt ? new Date(item.processDt).toLocaleString() : ''}</td>
                    `;
                    tbody.appendChild(tr);
                });

            } catch (e) {
                console.error(e);
                tbody.innerHTML = '<tr><td colspan="5">서버 오류 발생</td></tr>';
            }
        }

        async function sendDecision(statusCd) {
            // 현재 결재 순번(PENDING / E001) DTO 찾기
            const current = approvalList.find(item => item.approvalStatusCd === 'E001');
            if (!current) {
                alert('현재 처리 가능한 결재가 없습니다.');
                return;
            }

            // DTO 전체를 복사하고 상태코드 및 코멘트만 변경
            const payload = { ...current, approvalStatusCd: statusCd, approvalComment: document.getElementById('comment').value || '' };

            if (!confirm((statusCd === 'E002' ? '승인' : '반려') + ' 하시겠습니까?')) return;

            try {
                const res = await fetch(ctx + '/api/approval/process', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'same-origin',
                    body: JSON.stringify(payload)
                });

                const json = await res.json().catch(() => null);
                if (res.ok) {
                    alert(json?.message || '처리 성공');
                    document.getElementById('comment').value = '';
                    loadLine(); // 최신 내역 갱신
                } else {
                    alert(json?.message || ('오류: ' + res.status));
                }
            } catch (e) {
                console.error(e);
                alert('서버 에러 발생');
            }
        }
    </script>
</body>
</html>