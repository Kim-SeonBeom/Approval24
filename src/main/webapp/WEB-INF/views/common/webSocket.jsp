<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>
// 컨텍스트 경로 (Context Path)
const CONTEXT_PATH = '${pageContext.request.contextPath}';

document.addEventListener("DOMContentLoaded", function() {
    
    // 🔔 핵심 변수 설정 🔔
    var currentUserId = '${sessionScope.user}'; 
    if (currentUserId === 'null' || currentUserId === '' || currentUserId === 'undefined') {
        currentUserId = null;
    }
    
    var bellElement = document.getElementById('alarm-badge');

    var socket = new SockJS(CONTEXT_PATH + '/ws'); 
    var stompClient = Stomp.over(socket);
    // STOMP 라이브러리 자체 로그 비활성화 (로그를 보려면 이 줄을 주석 처리)
    stompClient.debug = null; 

    // =========================================================================
    // 1. 알림 숫자 갱신 함수
    // =========================================================================
    function loadUnreadCount() {
        if (!currentUserId) {
            if (bellElement) bellElement.style.display = 'none';
            return;
        }

        fetch(CONTEXT_PATH + '/api/notification/unread-count') 
            .then(response => response.ok ? response.json() : 0)
            .then(count => {
                if (bellElement) {
                    bellElement.innerText = count;
                    bellElement.style.display = count > 0 ? 'block' : 'none'; 
                }
            })
            .catch(error => console.error('🔔 알림 수 로드 중 에러:', error));
    }


    // =========================================================================
    // 2. 알림 목록 로드 및 표시 함수 (오직 메시지만) 
    // =========================================================================
    function loadAndDisplayRecentAlarms() {
        if (!currentUserId) return;

        const listContainer = document.getElementById('alarm-items-list');
        if (!listContainer) return;

        listContainer.innerHTML = '<a class="dropdown-item text-center small text-gray-500">알림 로딩 중...</a>';

        fetch(CONTEXT_PATH + '/api/notification/recent')
            .then(response => response.ok ? response.json() : [])
            .then(alarms => {
                listContainer.innerHTML = '';
                
                if (alarms && alarms.length > 0) {
                    
                    // 🚨 진단 로그 추가: 데이터가 JS에 잘 넘어왔는지 콘솔에서 확인하세요.
                    console.log('🔔 수신 알림 데이터:', alarms); 

                    alarms.forEach(alarm => {
                        // 🚨 항목 메시지가 실제로 존재하는지 확인하는 로그 (F12 콘솔 확인 필수)
                        console.log('🔔 항목 메시지 확인:', alarm.message); 

                        const isUnread = alarm.readYn === 'N'; 
                        
                        const item = document.createElement('a');
                        item.href = '#'; 
                        
                        // 기존 디자인 클래스(d-flex, align-items-center) 유지
                        item.className = 'dropdown-item d-flex align-items-center'; 
                        
                        // 읽지 않은 알림 강조
                        if (isUnread) {
                            item.style.backgroundColor = '#f8f9fc';
                            item.style.fontWeight = 'bold';
                        }

                        // 🚨🚨🚨 가장 안정적인 구조: 부트스트랩 클래스를 활용하여 메시지 표시를 강제합니다. 🚨🚨🚨
                        item.innerHTML = `
                            <div class="mr-3">
                                <div class="icon-circle bg-primary">
                                    <i class="fas fa-file-alt text-white"></i>
                                </div>
                            </div>
                            <div>
                                <div class="font-weight-bold" style="white-space: normal; line-height: 1.2;">
                                    \${alarm.message}
                                </div>
                                </div>
                        `;
                        
                        // 클릭 이벤트: 읽음 처리 -> URL 이동 (DTO의 url 필드 사용)
                        item.addEventListener('click', (e) => {
                            e.preventDefault();
                            markAlarmAsReadAndGo(alarm.seqNo, alarm.url); 
                        });
                        
                        listContainer.appendChild(item);
                    });
                } else {
                    listContainer.innerHTML = '<a class="dropdown-item text-center small text-gray-500">새 알림이 없습니다.</a>';
                }
            })
            .catch(error => {
                console.error('🔔 알림 목록 로드 중 에러:', error);
                listContainer.innerHTML = '<a class="dropdown-item text-center small text-danger">목록을 불러올 수 없습니다.</a>';
            });
    }

    // =========================================================================
    // 3. 알림 읽음 처리 및 URL 이동 함수
    // =========================================================================
    function markAlarmAsReadAndGo(seqNo, url) {
        if (!seqNo || !currentUserId) {
            // URL이 null이면 대시보드 등으로 이동하도록 수정해야 할 수 있습니다. (현재는 url로 이동)
            window.location.href = url ? url : CONTEXT_PATH + '/dashboard'; 
            return;
        }

        fetch(CONTEXT_PATH + '/api/notification/read/' + seqNo, { 
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        })
        .then(response => {
            if (response.ok) {
                loadUnreadCount(); 
            } else {
                console.error(`🔔 알림 ${seqNo} 읽음 처리 실패.`);
            }
        })
        .catch(error => {
            console.error('🔔 읽음 처리 API 호출 중 에러:', error);
        })
        .finally(() => {
            window.location.href = url;
        });
    }

    // =========================================================================
    // 4. STOMP 및 클릭 이벤트 연결
    // =========================================================================
    var connectCallback = function(frame) {
    	console.log('✅ WebSocket 연결 성공!');
        loadUnreadCount();
        
        stompClient.subscribe('/topic/notification-events', function(message) {
            loadUnreadCount();
        });
        
        if (currentUserId) {
            stompClient.subscribe('/user/queue/alerts', function(message) {
                // 개인 알림 수신 시 알림 창 띄우기
                alert("새 알림: " + message.body); 
                loadUnreadCount();
            });
        }
        
        stompClient.subscribe('/topic/general', function(message) {
                // 전체 알림 수신 시 알림 창 띄우기
                alert("전체 알림: " + message.body);
        });
    };

    var errorCallback = function(error) {
        // 재연결 로직
        setTimeout(function() {
            stompClient.connect({}, connectCallback, errorCallback);
        }, 5000);
    };

    if (currentUserId) {
        stompClient.connect({}, connectCallback, errorCallback);
    } else {
        loadUnreadCount();
    }
    
    // 💡 종 모양 클릭 이벤트 리스너 연결
    const alarmBell = document.getElementById('alarm-bell');
    if (alarmBell) {
        alarmBell.addEventListener('click', function(e) {
            loadAndDisplayRecentAlarms();
        });
    }
});
</script>