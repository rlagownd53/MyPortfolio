<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<title>회원 가입 페이지</title>
<!-- 다음 우편번호 검색 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/js/post.js"></script>
<script src="${pageContext.request.contextPath}/js/passwordcheck.js"></script>
</head>
<body>
	<article class="container" style="margin-top: 5%">
		<div class="page-header text-center">
			<h1>
				회원가입 <small>sign page</small>
			</h1>
		</div>
		<div class="col-md-6 col-md-offset-3">
			<form role="form" action="sign" method="post">
				<div class="m-input text-center">
					<label for="InputEmail">이메일 주소</label> 
					<input name="email"
						type="email" class="form-control" id="InputEmail" value="${email}">
				</div>
				<div class="form-group text-center">
					<label for="InputPassword1" >비밀번호
												<p id="res1"></p>
					</label> 
					<input name="password"
						type="password" class="form-control" id="InputPassword1"
						placeholder="비밀번호는 영 대.소문자 숫자 특수문자 포함 최소 8 글자 입니다 " onkeyup="pwCheck();">
				</div>
				<div class="form-group text-center">
					<label for="InputPassword2">비밀번호 확인
												<p id="res2"></p>
					</label>
					<input name="password2"
						type="password" class="form-control" id="InputPassword2"
						placeholder="비밀번호는 영 대.소문자 숫자 특수문자 포함 최소 8 글자 입니다" onkeyup="pw2Check();">
					<p class="help-block">비밀번호 확인을 위해 다시한번 입력 해 주세요</p>
				</div>
				<div class="form-group text-center">
					<label for="username">이름<p id="res3"></p></label>
					<input name="name" type="text"
						class="form-control" id="username" value="${name}" onkeyup="nickCheck();">
				</div>
				<div class="form-group text-center">
					<label for="username">전화번호 입력</label>
				</div>
				<div class="form-group text-center">
					<input name="phone" type="tel" class="form-control" id="username"
						placeholder="- 없이 입력해 주세요"> 
						</div>	<div class="form-group text-center">
					<SELECT NAME=telecom SIZE=1 class="form-control">
						<OPTION VALUE=kt>KT</OPTION>
						<OPTION VALUE=lg>LG</OPTION>
						<OPTION VALUE=sk>SK</OPTION>
						<OPTION VALUE=알뜰폰 SELECTED>알뜰폰</OPTION>
					</SELECT>
				</div>
				<div class="form-group text-center">
					<input type="text" id="sample6_postcode" placeholder="우편번호"
						name="post" class="form-control" onclick="sample6_execDaumPostcode()"> 
						</div><div class="form-group text-center">
						<input type="text" id="sample6_address" placeholder="검색된 주소" name="addr1" class="form-control">
				</div>
				<div class="form-group">
					<input type="text" id="sample6_address2" placeholder="상세 주소"
						name="addr2" class="form-control"> <span id="guide"
						style="color: #999"> </span>
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btn btn-info">
						회원가입<i class="fa fa-check spaceLeft"></i>
					</button>
					<button type="button" class="btn btn-warning"
						onclick="location.href='home'">
						가입취소<i class="fa fa-times spaceLeft"></i>
					</button>
				</div>
			</form>
			<hr>
		</div>
	</article>
</body>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>