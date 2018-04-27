<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<table id="myTable" class="tablesorter">
		<thead>
			<tr>
				<th>회원 번호</th>
				<th>회원 이메일</th>
				<th>회원 이름</th>
				<th>회원 전화번호</th>
				<th>회원 우편번호</th>
				<th>회원 주소</th>
				<th>회원 상세</th>
				<th>가입일</th>
			</tr>
		</thead>
		<c:forEach var="list" items="${memberlist}">
			<tbody>
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
			</tbody>
		</c:forEach>
	</table>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>