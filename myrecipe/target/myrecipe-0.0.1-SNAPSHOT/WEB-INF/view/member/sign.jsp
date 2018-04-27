<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"> 
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 가입 페이지</title>
<!-- Bootstrap -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css"
	integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M"
	crossorigin="anonymous">
<!-- 다음 우편번호 검색 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
				<script>
					//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
					function sample4_execDaumPostcode() {
						new daum.Postcode(
								{
									oncomplete : function(data) {
										// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

										// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
										// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
										var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
										var extraRoadAddr = ''; // 도로명 조합형 주소 변수

										// 법정동명이 있을 경우 추가한다. (법정리는 제외)
										// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
										if (data.bname !== ''
												&& /[동|로|가]$/g.test(data.bname)) {
											extraRoadAddr += data.bname;
										}
										// 건물명이 있고, 공동주택일 경우 추가한다.
										if (data.buildingName !== ''
												&& data.apartment === 'Y') {
											extraRoadAddr += (extraRoadAddr !== '' ? ', '
													+ data.buildingName
													: data.buildingName);
										}
										// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
										if (extraRoadAddr !== '') {
											extraRoadAddr = ' ('
													+ extraRoadAddr + ')';
										}
										// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
										if (fullRoadAddr !== '') {
											fullRoadAddr += extraRoadAddr;
										}

										// 우편번호와 주소 정보를 해당 필드에 넣는다.
										document
												.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
										document
												.getElementById('sample4_roadAddress').value = fullRoadAddr;
										document
												.getElementById('sample4_jibunAddress').value = data.jibunAddress;

										// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
										if (data.autoRoadAddress) {
											//예상되는 도로명 주소에 조합형 주소를 추가한다.
											var expRoadAddr = data.autoRoadAddress
													+ extraRoadAddr;
											document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
													+ expRoadAddr + ')';

										} else if (data.autoJibunAddress) {
											var expJibunAddr = data.autoJibunAddress;
											document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
													+ expJibunAddr + ')';

										} else {
											document.getElementById('guide').innerHTML = '';
										}
									}
								}).open();
					}
				</script>

</head>
<body>
	<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
		<a class="navbar-brand" href="#">MyRecipe</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarsExampleDefault"
			aria-controls="navbarsExampleDefault" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarsExampleDefault">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
				<li class="nav-item"><a class="nav-link disabled" href="#">Disabled</a>
				</li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="http://example.com"
					id="dropdown01" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">Dropdown</a>
					<div class="dropdown-menu" aria-labelledby="dropdown01">
						<a class="dropdown-item" href="#">Action</a> <a
							class="dropdown-item" href="#">Another action</a> <a
							class="dropdown-item" href="#">Something else here</a>
					</div></li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="text" placeholder="Search"
					aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>

	<article class="container" style="margin-top: 5%">
		<div class="page-header">
			<h1>
				회원가입 <small>sign page</small>
			</h1>
		</div>
		<div class="col-md-6 col-md-offset-3">
			<form role="form" action="sign" method="post">
				<div class="form-group">
					<label for="InputEmail">이메일 주소</label> 
					<input name="email" type="email" class="form-control" id="InputEmail" placeholder="이메일 주소">
				</div>
				<div class="form-group">
					<label for="InputPassword1">비밀번호</label> <input name="password"
						type="password" class="form-control" id="InputPassword1"
						placeholder="비밀번호">
				</div>
				<div class="form-group">
					<label for="InputPassword2">비밀번호 확인</label> <input name="pw2"
						type="password" class="form-control" id="InputPassword2"
						placeholder="비밀번호 확인">
					<p class="help-block">비밀번호 확인을 위해 다시한번 입력 해 주세요</p>
				</div>
				<div class="form-group">
					<label for="username">이름</label> <input name="name" type="text"
						class="form-control" id="username" placeholder="이름을 입력해 주세요">
				</div>
				<div class="form-group">
					<label for="username">전화번호 입력</label>
				</div>
				<div class="form-group">
					<input name="phone" type="tel" class="form-control" id="username" placeholder="- 없이 입력해 주세요">
				</div>
				<div class="form-group">
				<input type="text" id="sample4_postcode" placeholder="우편번호" name="post" class="form-control">
				<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="btn btn-info">
				<br><div>
				<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="addr1" class="form-control"> 
				<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="addr2" class="form-control"> 
				<span id="guide" style="color: #999">
				</span>
				</div>
				<div class="checkbox">
					<label> <input type="checkbox" value="remember-me">
						<a href="#">이용약관</a>에 동의합니다.
					</label>
				</div>
		</div>
		<div class="form-group text-center">
			<button type="submit" class="btn btn-info">
				회원가입<i class="fa fa-check spaceLeft"></i>
			</button>
			<button type="submit" class="btn btn-warning">
				가입취소<i class="fa fa-times spaceLeft"></i>
			</button>
		</div>
		</form>
		<hr>
		</div>
	</article>

	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
		integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"
		integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1"
		crossorigin="anonymous"></script>
</body>
</html>
