<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결재 라인 조회</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* (스타일 시트 내용은 이전과 동일합니다. 편의상 생략합니다.) */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            padding: 20px;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        /* 카드 컨테이너 스타일 (Flexbox를 사용하여 카드들을 정렬) */
        #approval-cards-container {
            display: flex;
            flex-wrap: wrap; 
            gap: 20px; 
            justify-content: center;
        }

        /* 개별 카드 스타일 */
        .card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px;
            box-sizing: border-box;
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .card h4 {
            color: #007bff;
            margin-top: 0;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }

        .card p {
            margin: 5px 0;
            color: #555;
            font-size: 0.95em;
        }
        
        /* 상태별 강조 스타일 (코드 값 기준) */
        .status-A { /* 예: 승인 코드가 'A'일 경우 */
            background-color: #e6ffed; 
        }
        .status-P { /* 예: 대기 코드가 'P'일 경우 */
            background-color: #fff8e1;
        }
        .status-R { /* 예: 반려 코드가 'R'일 경우 */
            background-color: #ffebeb;
        }
        /* 참고: 실제 사용하는 APPROVAL_STATUS_CD 값에 따라 .status-XXX 부분을 수정해야 합니다. */

        /* 메시지 및 로딩 스타일 */
        #message {
            text-align: center;
            color: #dc3545;
            margin-top: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <h2>결재 라인 정보 (민원 ID: 62)</h2>
    <div id="approval-cards-container">
    </div>
    <div id="message"></div>

    <script>
        // jQuery 코드 블록 내에서는 $를 사용합니다.
        $(document).ready(function() {
            const complainId = 62; 
            const url = "/approval24/api/approval/line"; 
            
            $.ajax({
                type: "GET",
                url: url,
                data: { complainId: complainId },
                dataType: "json",
                success: function(response) {
                    $('#message').empty(); 
                    
                    if (Array.isArray(response)) {
                        if (response.length > 0) {
                            displayApprovalLines(response);
                        } else {
                            $('#message').text('조회된 결재 이력이 없습니다.');
                        }
                    } 
                    else if (response && response.success === false) {
                        $('#message').text('오류 발생: ' + response.message);
                    } 
                    else {
                        $('#message').text('알 수 없는 응답 형식입니다.');
                        console.error("Unknown response format:", response);
                    }
                },
                error: function(xhr, status, error) {
                    let errorMessage = "서버 요청 중 알 수 없는 오류가 발생했습니다.";
                    
                    try {
                        const errorResponse = JSON.parse(xhr.responseText);
                        if (errorResponse && errorResponse.message) {
                            errorMessage = '오류: ' + errorResponse.message;
                        }
                    } catch (e) {
                        errorMessage = `요청 실패 (HTTP 상태 코드: \${xhr.status}): \${status}`; // \${}는 JS 템플릿 리터럴
                    }
                    
                    $('#message').text(errorMessage);
                    console.error("AJAX Error:", status, error, xhr.responseText);
                }
            });

            /**
             * 결재 이력 목록을 화면에 카드 형태로 표시하는 함수
             * @param {Array<ApprovalHistoryDTO>} historyList - 결재 이력 목록
             */
            function displayApprovalLines(historyList) {
                const container = $('#approval-cards-container');
                container.empty(); 

                historyList.forEach(function(item) {
                    // **매퍼에서 전달받은 DTO 필드명에 맞게 key를 사용합니다.**
                    const cardHtml = `
                        <div class="card status-${item.approvalStatusCd}">
                            <h4>결재 순서 ${item.seqNo || '-'}</h4>
                            <p><strong>결재자 ID:</strong> ${item.accountId || '-'}</p>
                            <p><strong>결재자 유형:</strong> ${item.approverTypeName || '-'}</p>
                            <p><strong>상태:</strong> <span style="font-weight: bold;">${item.approvalStatusName || item.approvalStatusCd || 'N/A'}</span></p>
                            <p><strong>처리 일자:</strong> ${item.processDt || 'N/A'}</p>
                            <p><strong>의견:</strong> ${item.approvalComment || '없음'}</p>
                            <hr style="border: 0; border-top: 1px dashed #eee; margin: 10px 0;">
                            <p style="font-size: 0.85em;"><strong>카테고리:</strong> ${item.categoryName || '-'}</p>
                        </div>
                    `;
                    container.append(cardHtml);
                });
            }
        });
    </script>

</body>
</html>