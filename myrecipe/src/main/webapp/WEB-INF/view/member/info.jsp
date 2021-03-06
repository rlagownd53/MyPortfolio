<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<title>회원 정보 페이지</title>
</head>
<body>
	<article class="container" style="margin-top: 5%">
		<div class="page-header text-center">
			<h1>
				회원 정보<small>info page</small>
			</h1>
		</div>
		<div class="col-md-6 col-md-offset-3">
			<div class="form-group text-center">
				<label for="InputEmail">이메일 주소</label> <input name="email"
					type="email" class="form-control" id="InputEmail"
					value="${dto.email}" readonly>
			</div>
			<div class="form-group text-center">
				<label for="username">이름</label> <input name="name" type="text"
					class="form-control" id="username" value="${dto.name}" readonly>
			</div>
			<div class="form-group text-center">
				<label for="username">전화번호</label>
			</div>
			<div class="form-group text-center">
				<input name="phone" type="tel" class="form-control" id="username"
					value="${dto.phone} [${dto.telecom}]" readonly>
			</div>
			<div class="form-group text-center">
				<label for="username">우편번호</label> <input type="text"
					id="sample6_postcode" placeholder="${dto.post}" name="post"
					class="form-control" readonly> <label for="username">주소</label>
				<input type="text" id="sample6_address" value="${dto.addr1}"
					name="addr1" class="form-control" readonly>
			</div>
			<div class="form-group text-center">
				<input type="text" id="sample6_address2" value="${dto.addr2}"
					name="addr2" class="form-control" readonly><span id="guide"
					style="color: #999">
			</div>
			</span>

			<div class="form-group text-center">
				<button type="button" class="btn btn-info"
					onclick="location.href='${pageContext.request.contextPath}/edit'">
					수정<i class="fa fa-check spaceLeft"></i>
				</button>
				<button type="button" class="btn btn-warning"
					onclick="location.href='${pageContext.request.contextPath}'">
					홈으로<i class="fa fa-times spaceLeft"></i>
				</button>
			</div>
			<hr>
		</div>
	</article>
</body>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>