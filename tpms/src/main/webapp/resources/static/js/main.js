/**
 * 
 */

$(function(){

        const modal = document.getElementById("modal")
		const btnModal = document.getElementById("btn-cancel")

		btnModal.addEventListener("click", e => {
		    modal.style.display = "none";
		})
		
		const closeBtn = modal.querySelector(".close-area")
		closeBtn.addEventListener("click", e => {
		    modal.style.display = "none"
		})
		
		modal.addEventListener("click", e => {
		    const evTarget = e.target
		    if(evTarget.classList.contains("modal-overlay")) {
		        modal.style.display = "none"
		    }
		})
	
	// 대여신청을 클릭한 경우
	// 1. 로그인이 되어있는지 확인 -> 되어있지 않다면 알림창띄우고 로그인 페이지이동여부 결정 
	// 로그인 되어있으면 대여신청 팝업 띄우고 신청받기
	$('#phone-list').on('click', '.apply' , function(){
		let phoneCode = $(this).closest('tr').attr('id');
		// 로그인 여부 확인
		$.ajax({
			type:"GET",
			url:"rest/islogin",
		})
		.done(function(user){
			if(!user){
				// 로그인 되어있지 않은 경우 
				let confirmValue = confirm("대여신청은 로그인 후에만 가능합니다. \n로그인 페이지로 이동하시겠습니까?");
				if(confirmValue){
					// 로그인 된 후에 다시 전페이지로 돌아가는 부분 추가 구현하면 좋을듯
					location.href = "/tpms/login"; 
				}
			}else{
				// 기기코드 설정하고 값 비우고 띄우기
				$('#rental-form').find('#phone-code').val(phoneCode);
				$('#rental-form').find('#rental-start').val('')
				$('#rental-form').find('#rental-end').val('')
				modal.style.display = "flex";
				
			}
		});
	});
	
	// 대여모달 신청누르면 -> 유효성검사 후 제출
	$('#modal').on('click', '.apply', function(){
		// 값 유효성 확인
		// 1.시작일이 종료일보다 앞이 맞는지
		let startDateString = $('#rental-form').find('#rental-start').val();
		let endDateString = $('#rental-form').find('#rental-end').val();
		let startDate = new Date(startDateString);
		let endDate = new Date(endDateString);
		
		if(startDateString == ''){
			alert("시작일을 입력하세요");
			$('#rental-form').find('#rental-start').focus();
			return;
		} else if(endDateString == ''){
			alert("종료일를 입력하세요");
			$('#rental-form').find('#rental-end').focus();			
			return;
		} else if(startDateString > endDateString){
			alert("시작일은 종료일보다 앞이여야 합니다.");
			$('#rental-form').find('#rental-start').focus();
			return;
		} else if(startDateString == endDateString){
			alert("시작일과 종료일은 같을 수 없습니다.");
			$('#rental-form').find('#rental-start').focus();
			return;
		} else if(endDate - startDate > 518400000){
			alert("대여할 수 있는 최대기간은 일주일입니다.");
			$('#rental-form').find('#rental-end').focus();	
			return;
		} else if(new Date() > startDate){
			alert("대여시작일은 오늘보다 뒤여야합니다.");
			$('#rental-form').find('#rental-start').focus();	
			return;
		} else if(startDate - new Date() > 345600000){
			alert("대여신청은 대여일로부터 3일 이전부터 가능합니다.");
			$('#rental-form').find('#rental-start').focus();	
			return;
		}
		
		// 유효성 검사 완료하면 폼 제출
		$('#rental-form').submit();
	})

	
});