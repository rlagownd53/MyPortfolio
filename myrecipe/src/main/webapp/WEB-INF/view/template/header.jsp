<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<head>
<title>My Recipe</title>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css">
<script src="${pageContext.request.contextPath}/js/board.js"></script>
<script>
	function logout() {
		$("#logoutForm").submit();
	}
	window.onbeforeunload = logout;
</script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">
/* GLOBAL STYLES
-------------------------------------------------- */
/* Padding below the footer and lighter body text */
body {
	padding-bottom: 40px;
	color: #5a5a5a;
	min-height: 500px;
}

/* CUSTOMIZE THE NAVBAR
-------------------------------------------------- */

/* Special class on .container surrounding .navbar, used for positioning it into place. */
.navbar-wrapper {
	position: absolute;
	top: 0;
	right: 0;
	left: 0;
	z-index: 20;
}

/* Flip around the padding for proper display in narrow viewports */
.navbar-wrapper>.container {
	padding-right: 0;
	padding-left: 0;
}

.navbar-wrapper .navbar {
	padding-right: 15px;
	padding-left: 15px;
}

.navbar-wrapper .navbar .container {
	width: auto;
}

/* CUSTOMIZE THE CAROUSEL
-------------------------------------------------- */

/* Carousel base class */
.carousel {
	height: 500px;
	margin-top: 80px;
	margin-bottom: 60px;
}
/* Since positioning the image, we need to help out the caption */
.carousel-caption {
	z-index: 10;
}

/* Declare heights because of positioning of img element */
.carousel .item {
	height: 500px;
}

.carousel-inner>.item>img {
	margin: 0 auto;
	min-width: 80%;
	height: 500px;
}

/* MARKETING CONTENT
-------------------------------------------------- */

/* Center align the text within the three columns below the carousel */
.marketing .col-lg-4 {
	margin-bottom: 20px;
	text-align: center;
}

.marketing h2 {
	font-weight: normal;
}

.marketing .col-lg-4 p {
	margin-right: 10px;
	margin-left: 10px;
}

/* Featurettes
------------------------- */
.featurette-divider {
	margin: 80px 0; /* Space out the Bootstrap <hr> more */
}

/* Thin out the marketing headings */
.featurette-heading {
	font-weight: 300;
	line-height: 1;
	letter-spacing: -1px;
}

/* RESPONSIVE CSS
-------------------------------------------------- */
@media ( min-width : 768px) {
	/* Navbar positioning foo */
	.navbar-wrapper {
		margin-top: 20px;
	}
	.navbar-wrapper .container {
		padding-right: 15px;
		padding-left: 15px;
	}
	.navbar-wrapper .navbar {
		padding-right: 0;
		padding-left: 0;
	}

	/* The navbar becomes detached from the top, so we round the corners */
	.navbar-wrapper .navbar {
		border-radius: 4px;
	}

	/* Bump up size of carousel content */
	.carousel-caption p {
		margin-bottom: 20px;
		font-size: 21px;
		line-height: 1.4;
	}
	.featurette-heading {
		font-size: 50px;
	}
}

@media ( min-width : 992px) {
	.featurette-heading {
		margin-top: 120px;
	}
}
form {
	margin: 0;
}
</style>
<script>
	//NOTICE!! DO NOT USE ANY OF THIS JAVASCRIPT
	//IT'S JUST JUNK FOR OUR DOCS!
	//++++++++++++++++++++++++++++++++++++++++++
	/*!
	 * Copyright 2014 Twitter, Inc.
	 *
	 * Licensed under the Creative Commons Attribution 3.0 Unported License. For
	 * details, see http://creativecommons.org/licenses/by/3.0/.
	 */
	//Intended to prevent false-positive bug reports about Bootstrap not working properly in old versions of IE due to folks testing using IE's unreliable emulation modes.
	(function() {
		'use strict';

		function emulatedIEMajorVersion() {
			var groups = /MSIE ([0-9.]+)/.exec(window.navigator.userAgent)
			if (groups === null) {
				return null
			}
			var ieVersionNum = parseInt(groups[1], 10)
			var ieMajorVersion = Math.floor(ieVersionNum)
			return ieMajorVersion
		}

		function actualNonEmulatedIEMajorVersion() {
			// Detects the actual version of IE in use, even if it's in an older-IE emulation mode.
			// IE JavaScript conditional compilation docs: http://msdn.microsoft.com/en-us/library/ie/121hztk3(v=vs.94).aspx
			// @cc_on docs: http://msdn.microsoft.com/en-us/library/ie/8ka90k2e(v=vs.94).aspx
			var jscriptVersion = new Function(
					'/*@cc_on return @_jscript_version; @*/')() // jshint ignore:line
			if (jscriptVersion === undefined) {
				return 11 // IE11+ not in emulation mode
			}
			if (jscriptVersion < 9) {
				return 8 // IE8 (or lower; haven't tested on IE<8)
			}
			return jscriptVersion // IE9 or IE10 in any mode, or IE11 in non-IE11 mode
		}

		var ua = window.navigator.userAgent
		if (ua.indexOf('Opera') > -1 || ua.indexOf('Presto') > -1) {
			return // Opera, which might pretend to be IE
		}
		var emulated = emulatedIEMajorVersion()
		if (emulated === null) {
			return // Not IE
		}
		var nonEmulated = actualNonEmulatedIEMajorVersion()

		if (emulated !== nonEmulated) {
			window
					.alert('WARNING: You appear to be using IE'
							+ nonEmulated
							+ ' in IE'
							+ emulated
							+ ' emulation mode.\nIE emulation modes can behave significantly differently from ACTUAL older versions of IE.\nPLEASE DON\'T FILE BOOTSTRAP BUGS based on testing in IE emulation modes!')
		}
	})();
</script>
</head>
<body>
	<div class="navbar-wrapper">
		<div class="container">
			<nav id="nav" class="navbar navbar-default navbar-static-top">
				<div class="container">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed"
							data-toggle="collapse" data-target="#navbar"
							aria-expanded="false" aria-controls="navbar">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="${pageContext.request.contextPath}">My
							Recipe</a>
					</div>
					<div id="navbar" class="navbar-collapse collapse">
						<ul class="nav navbar-nav">
							<li><a href="guide">이용 방법</a></li>
							<li><a href="not">공지 사항</a></li>
							<li><a href="<c:url value="mlist"/>">전체 메뉴</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<sec:authorize access="isAnonymous()">
								<li><a href="login">회원 가입</a></li>
								<li><a href="login">로그인</a></li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_user')">
								<form name="logoutForm" action="<c:url value="/logout"/>"
									method="post">
									<sec:csrfInput />
								</form>
							</sec:authorize>
							<c:if test="${cookie.memberEmail.value !=null}">
								<li><a href="javascript:logoutForm.submit();">로그아웃</a></li>
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" 
										role="button" aria-expanded="true">마이페이지
								 	<span class="caret"></span>
								</a>
									<ul class="dropdown-menu" role="menu">
										<li><a href="info">내 정보</a></li>
										<li><a href="myqna">내 문의</a></li>
										<li><a href="cart">장바구니</a></li>
									</ul></li>
									<li><a href="orderlist">주문 내역</a></li>
							</c:if>
							<li><a href="blist">고객 센터</a></li>							
							<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
								<li><a href="admin">관리자페이지</a></li>
							</sec:authorize>
						</ul>
					</div>
				</div>
			</nav>
		</div>
	</div>