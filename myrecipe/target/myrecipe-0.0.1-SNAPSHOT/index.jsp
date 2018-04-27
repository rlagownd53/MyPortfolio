<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<%@ include file="/WEB-INF/view/template/header.jsp" %>

<div>
	<h1>Best Menu</h1>
	<img src="https://placehold.it/700x450" width="700" height="450">
</div>

<html>
	<head>
		<meta charset="utf-8">
		<title>
		</title>
	</head> 
	<body>
		<h1><a href="list">list 보기</a></h1>
		<h1><a href="edit">정보 수정</a></h1>
		<h1><a href="sign">회원가입</a></h1>
		<h1><a href="login">로그인</a></h1>
		<h1><a href="info">정보보기</a></h1>
		<h1><a href="menulist">메뉴 리스트 이동</a></h1>
		<h1><a href="order">주문하기</a></h1>
	</body>
</html>
<div>
	<h1>New Menu</h1>
	<img src="https://placehold.it/400x350" width="400" height="350">
</div>

<%@ include file="/WEB-INF/view/template/footer.jsp" %>
