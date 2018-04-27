<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<!-- 어드민 css -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/adminmenu.css">
	<!-- 부트스트랩 css -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
  src="https://code.jquery.com/jquery-3.2.1.js"
  integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
  crossorigin="anonymous"></script>
<!-- 차트 js-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
		<!-- 테이블솔터 js 및 css -->
<script src="${pageContext.request.contextPath}/js/jquery.tablesorter/jquery.tablesorter.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery.tablesorter/themes/blue/style.css" type="text/css">
	<script>
	$(document).ready(function() {
		$("#myTable").tablesorter({
			sortList : [ [ 0, 1 ] ],
			headers : {
				1 : {
					sorter : "Integer"
				},
				debug : true
			}
		});
	})
</script>
	<div class="container-fluid">
	<div class="col-xs-12">
	<nav class="navbar navbar-default navbar-fixed-top">
      <div>
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="${pageContext.request.contextPath}">My Recipe</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Dashboard</a></li>
            <li><a href="#">Settings</a></li>
            <li><a href="#">Help</a></li>
          </ul>
        </div>
      </div>
    </nav></div>
		<div class="col-md-2" style="padding-top: 40px">
			<div class="left-option">
			<div class="alert alert-success">
				<h2 class="text-left">회원관리</h2>
				<h4 class="text-left">
					<a href="memberlist">회원 목록</a>
				</h4>
				<h4 class="text-left">
					<a href="mnqlist">문의 목록</a>
				</h4></div>
			</div>
			<div class="left-option">
			<div class="alert alert-info">
				<h2 class="text-left">상품관리</h2>
				<h4 class="text-left">
					<a href="mmodi">메뉴 목록</a>
				</h4></div>
			</div>
			<div class="left-option">
			<div class="alert alert-warning">
				<h2 class="text-left">주문관리</h2>
				<h4 class="text-left">
					<a href="olist">주문 현황</a>
				</h4>
				<h4 class="text-left">
					<a href="olist2">완료된 주문</a>
				</h4></div>
			</div>
		</div>
