<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/admin/adminnav.jsp"%>
	<div class="col-lg-9" style="padding-top: 50px">
	<h1 class="text-center">회원 리스트</h1>
	<div class="container">
	<table id="myTable" class="tablesorter table table-bordered">
		<thead>
			<tr>
				<th class="text-center">번호</th>
				<th class="text-center">이메일</th>
				<th class="text-center">이름</th>
				<th class="text-center">전화번호</th>
				<th class="text-center">우편번호</th>
				<th class="text-center">주소</th>
				<th class="text-center">상세 주소</th>
				<th class="text-center">가입일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${memberlist}">
				<tr>
					<td>${list.no}</td>
					<td>${list.email}</td>
					<td>${list.name}</td>
					<td>${list.telecom}${list.phone}</td>
					<td>${list.post}</td>
					<td>${list.addr1}</td>
					<td>${list.addr2}</td>
					<td>${list.reg}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div></div></div>
