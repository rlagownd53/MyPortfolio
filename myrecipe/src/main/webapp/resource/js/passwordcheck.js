function idCheck() {
	var regex = /^[\w]{8,20}$/;
	var target = document.querySelector("input[name=id]");
	if (regex.test(target.value)) {
		target.style.border = "3px solid blue";
		return true;
	} else {
		target.style.border = "3px solid red";
		return false;
	}
}

function pwCheck() {
	var regex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*=+]).{8,20}$/;
	var target = document.querySelector("input[name=password]");
	var res =  document.querySelector("#res1");
	if (regex.test(target.value)) {
		target.style.border = "3px solid blue";
		$(res).text("");
		return true;
	} else {
		target.style.border = "3px solid red";
		$(res).text("형식에 맞지않는 비밀번호 입니다.").css("color","red");
		return false;
	}
}

function pw2Check() {
	var pw = document.querySelector("input[name=password]");
	var target = document.querySelector("input[name=password2]");
	var res =  document.querySelector("#res2");
	if (pw.value === target.value) {
		target.style.border = "3px solid blue";
		$(res).text("");
		return true;
	} else {
		target.style.border = "3px solid red";
		$(res).text("입력하신 비밀번호가 같지 않습니다.").css("color","red");
		return false;
	}
}

function nickCheck() {
	var regex = /^[가-힣]{2,6}$/;
	var target = document.querySelector("input[name=name]");
	var res =  document.querySelector("#res3");
	if (regex.test(target.value)) {
		target.style.border = "3px solid blue";
		$(res).text("");
		return true;
	} else {
		target.style.border = "3px solid red";
		$(res).text("이름은 최소 2글자 이상 한글로 입력하세요").css("color","red");
		return false;
	}
}

