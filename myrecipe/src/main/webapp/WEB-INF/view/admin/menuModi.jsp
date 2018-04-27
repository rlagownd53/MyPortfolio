<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/view/admin/adminnav.jsp"%>

<div class="col-lg-9" style="padding-top: 50px">
<h1 class="text-center">상품 리스트</h1>
	<table id="myTable" class="tablesorter table table-bordered">
		<thead>
			<tr>
				<th>no</th>
				<th>메뉴명</th>
				<th>가격</th>
				<th>종류</th>
				<th>재고</th>
				<th>옵션1 내용</th>
				<th>옵션1 가격</th>
				<th>옵션2 내용</th>
				<th>옵션2 가격</th>
				<th>옵션3 내용</th>
				<th>옵션3 가격</th>
				<th>판매 상태</th>
				<th>판매 등급</th>
				<th>등록 일시</th>
				<th colspan="2"><input type="button" value="신규 등록" onclick="location.href='madd?no='" class="btn btn-default"></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="mdto" items="${mdto}">
				<tr>
					<td>${mdto.menu_no}</td>
					<td>${mdto.name}</td>
					<td>${mdto.price}</td>
					<td>${mdto.type}</td>
					<td>${mdto.stock}</td>
					<td>${mdto.op1_name}</td>
					<td>${mdto.op1_price}</td>
					<td>${mdto.op2_name}</td>
					<td>${mdto.op2_price}</td>
					<td>${mdto.op3_name}</td>
					<td>${mdto.op3_price}</td>
					<td>${mdto.stat}</td>
					<td>${mdto.stat_grade}</td>
					<td>${mdto.reg}</td>
					<td><input type="button" value="수정" onclick="location.href='mdetail?no=${mdto.menu_no}'" class="btn btn-default btn-xs"></td>
					<td><input type="button" value="삭제" onclick="location.href='mdelete?no=${mdto.menu_no}'" class="btn btn-default btn-xs"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<script type="text/javascript">
		window.onload = function() {
			var no = ${param.no};
			if((${param.mode}).equal('add')){
				alert('['+no+'] 메뉴 추가 완료 ! \n 많이 파세요~');
			}
			if((${param.mode}).equal('del')){
				alert('['+no+'] 메뉴 삭제 완료 !');
			}
		}
	</script>
</div>
