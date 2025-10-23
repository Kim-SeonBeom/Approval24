// 주소 설정
function openDaumPostcode(){
	new daum.Postcode({
		oncomplete: function(data){
			// 도로명
			var roadAddr = data.roadAddress;
			// 지번
			var jibunAddr = data.jibunAddress;
			// 우편번호
			var extraRoadAddr='';
			
			if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				extraRoadAddr += data.bname;
			}
			
			if(data.bname !== '' && data.apartment === 'Y'){
				extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}
			
			if(extraRoadAddr !== ''){
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}
			
			document.getElementById('postalCode').value = data.zonecode;
			document.getElementById("addr1").value = roadAddr;
			
			document.getElementById("addr2").focus();
		}
			
	}).open();
	
}