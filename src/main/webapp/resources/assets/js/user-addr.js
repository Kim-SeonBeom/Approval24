function openDaumPostcode() {
    new daum.Postcode({
        oncomplete : function(data) {
            try {
                // R: 도로명, J: 지번
                const addr = data.userSelectedType === 'R'
                    ? data.roadAddress
                    : data.jibunAddress;

                // 각 요소 가져오기
                const postInput   = document.getElementById('complainuserPost');
                const addrInput   = document.getElementById('complainuserAddress');
                const detailInput = document.getElementById('complainuserAddrDetail');

                // 요소가 있는 경우에만 값/포커스 적용
                if (postInput)   postInput.value   = data.zonecode;
                if (addrInput)   addrInput.value   = addr;
                if (detailInput) detailInput.focus();

            } catch (e) {
                console.error('[user-addr.js oncomplete 에러]', e);
            }
        }
    }).open();
}
