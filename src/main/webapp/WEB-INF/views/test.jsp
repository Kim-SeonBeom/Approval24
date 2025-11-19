<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WebSocket Alarm Test</title>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .container { max-width: 600px; margin: 0 auto; }
        #log { border: 1px solid #ccc; height: 150px; overflow-y: scroll; padding: 10px; margin-top: 10px; background: #f9f9f9; }
        .alert { background: #e0f7fa; padding: 5px; margin-bottom: 5px; border-left: 5px solid #00bcd4; }
        .status { background: #fff3e0; padding: 5px; margin-bottom: 5px; border-left: 5px solid #ff9800; }
    </style>
</head>
<body>

<div class="container">
    <h2>STOMP WebSocket 테스트 클라이언트</h2>
    
    <div id="connectionStatus" style="color: red; font-weight: bold;">연결 상태: 연결 전</div>
    
    <hr>
    
    <h3>수신자 브라우저 (유저 ID: 103)</h3>
    <p>
        이 브라우저가 유저 ID **103**으로 **로그인되어 있다면** 알림을 받을 수 있습니다.<br>
        유저 ID: **103** | 구독 경로: `/user/queue/private-alerts`
    </p>

    <div id="log"></div>

    <hr>
    
    <h3>송신자 기능 (로그인 여부 무관)</h3>
    <p>클라이언트(브라우저)에서 **직접** 서버의 `/app/send/queue/private` 경로로 메시지를 보냅니다.</p>
    <label for="messageInput">보낼 메시지:</label>
    <input type="text" id="messageInput" value="긴급 결재 필요합니다" style="width: 250px;">
    
    <button onclick="sendPrivateMessage(103)">유저 103에게 메시지 전송</button>
</div>

<script>
    var stompClient = null;
    var currentUserId = '103'; // 테스트를 위해 하드코딩된 현재 사용자의 ID

    function log(text, type) {
        var logDiv = document.getElementById('log');
        var newEntry = document.createElement('div');
        newEntry.className = type || 'status';
        newEntry.innerHTML = '<strong>[' + new Date().toLocaleTimeString() + ']</strong> ' + text;
        logDiv.appendChild(newEntry);
        logDiv.scrollTop = logDiv.scrollHeight;
    }

    // 1. 웹소켓 연결
    function connect() {
        // 서버의 웹소켓 엔드포인트
        var socket = new SockJS('/ws'); 
        stompClient = Stomp.over(socket);
        
        stompClient.connect({}, function (frame) {
            document.getElementById('connectionStatus').innerText = '연결 상태: 성공';
            document.getElementById('connectionStatus').style.color = 'green';
            log('STOMP 연결 성공!', 'status');

            // 2. 개인 메시지 구독
            // 로그인되어 있다면, 서버의 AlarmController로부터 알림을 받습니다.
            stompClient.subscribe('/user/queue/private-alerts', function (alarm) {
                log('🚨 개인 알림 수신: ' + alarm.body, 'alert');
            });

            // 3. 상태 알림 구독 (자신이 보낸 메시지 성공 여부 확인)
            stompClient.subscribe('/user/queue/status', function (status) {
                log('✅ 상태 알림 수신: ' + status.body, 'status');
            });
            
        }, function(error) {
            document.getElementById('connectionStatus').innerText = '연결 상태: 실패';
            document.getElementById('connectionStatus').style.color = 'red';
            log('STOMP 연결 실패: ' + error, 'status');
        });
    }

    // 3. 개인 메시지 전송 함수 (버튼 클릭 시 호출)
    function sendPrivateMessage(targetId) {
        if (!stompClient || !stompClient.connected) {
            log('❌ 연결 상태가 아닙니다. 다시 연결해주세요.', 'status');
            return;
        }
        
        var messageContent = document.getElementById('messageInput').value;

        // AlarmDTO와 매핑될 JSON 객체
        var alarmDTO = {
            // 서버의 AlarmDTO.getReceiverId()는 Long 타입이므로 숫자 형태로 전송
            receiverId: targetId, 
            message: messageContent
        };

        stompClient.send(
            "/app/send/queue/private", // 💡 AlarmController의 @MessageMapping 경로
            {}, 
            JSON.stringify(alarmDTO)
        );
        log(`메시지 발송 시도: ID ${targetId}에게 "${messageContent}"`, 'status');
        
        // 💡 중요: 로그인 안 한 브라우저라면 이 메시지 전송은 AlarmController에서 Principal이 없어 거부될 것입니다.
        // 이 메시지가 성공적으로 처리되려면, 이 브라우저 역시 'Principal'이 주입된 상태여야 합니다.
    }

    window.onload = connect;
</script>

</body>
</html>