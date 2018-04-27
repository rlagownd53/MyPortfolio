<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<title>회원 가입 페이지</title>
<!-- 다음 우편번호 검색 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/js/post.js"></script>
</head>
<body>
	<article class="container" style="margin-top: 5%">
		<div class="page-header text-center">
			<h1>
				정보 수정<small>edit page</small>
			</h1>
		</div>
		<div class="col-md-6 col-md-offset-3">
			<form role="form" action="edit?${_csrf.parameterName}=${_csrf.token}" method="post">
			<sec:csrfInput/>
				<div class="form-group text-center">
					<label for="InputEmail">이메일 주소</label> <input name="email"
						type="email" class="form-control" id="InputEmail"
						value="${dto.email}">
				</div>
				<div class="form-group text-center">
					<label for="InputPassword1">비밀번호</label> <input name="password"
						type="password" class="form-control" id="InputPassword1"
						placeholder="비밀번호">
				</div>
				<div class="form-group text-center">
					<label for="username">이름</label> <input name="name" type="text"
						class="form-control" id="username" value="${dto.name}">
				</div>
				<div class="form-group text-center">
					<label for="username">전화번호 입력</label>
				</div>
				<div class="form-group">
					<input name="phone" type="tel" class="form-control" id="username"
						value="${dto.phone}"></div> <div class="form-group">
						<SELECT NAME=telecom SIZE=1 class="form-control">
						<OPTION VALUE=kt>KT</OPTION>
						<OPTION VALUE=lg>LG</OPTION>
						<OPTION VALUE=sk>SK</OPTION>
						<OPTION VALUE=알뜰폰 SELECTED>알뜰폰</OPTION>
					</SELECT>
				</div>
				<div class="form-group text-center">
					<label for="username">주소 입력</label>
				</div>
				<div class="form-group">
					<input type="text" id="sample6_postcode" value="${dto.post}"
						name="post" class="form-control" onclick="sample6_execDaumPostcode()">
						</div><div class="form-group">
						<input type="text" id="sample6_address" value="${dto.addr1}" name="addr1" class="form-control">
				</div>
				<div class="form-group">
					<input type="text" id="sample6_address2" value="${dto.addr2}"
						name="addr2" class="form-control"> <span id="guide"
						style="color: #999">
				</div>
				</span>

				<div class="form-group text-center">
					<button type="submit" class="btn btn-info">
						수정 완료<i class="fa fa-check spaceLeft"></i>
					</button>
					<button type="button" class="btn btn-warning"
						onclick="location.href='${pageContext.request.contextPath}'">
						홈으로<i class="fa fa-times spaceLeft"></i>
					</button>
				</div>
			</form>
			<hr>
		</div>
	</article>
</body>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>