
function openDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			// R: 도로명, J: 지번
			const addr = data.userSelectedType === 'R' ? data.roadAddress
					: data.jibunAddress;

			// 우편번호 
			document.getElementById('complainuserPost').value = data.zonecode;

			// 기본 주소
			document.getElementById('complainuserAddress').value = addr;

			// 상세 주소 입력창에 포커스
			document.getElementById('complainuserAddrDetail').focus();
		}
	}).open();
}