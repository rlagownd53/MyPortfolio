<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table id="myTable" class="tablesorter">
<h1>월별 판매량</h1>
	<thead>
		<tr>
			<th>주문 번호</th>
			<th>주문자 이름</th>
			<th>메뉴 번호</th>
			<th>수량</th>
			<th>총 주문 금액</th>
			<th>배송지 정보</th>
			<th>주문일자</th>
			<th>배송예정일</th>
			<th>주문 상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="olist" items="${olist}">
			<c:set var="stat" value="${olist.stat}"></c:set>
			<c:if test="${stat=='배송중'}">
				<tr>
					<td id="menuno">${olist.no_order}</td>
					<td>${olist.order_name}</td>
					<td>${olist.no_menu}</td>
					<td>${olist.menu_cnt }</td>
					<td>${olist.totalprice }</td>
					<td>(${olist.post }) ${olist.addr1 } ${olist.addr2 }</td>
					<td>${olist.order_date }</td>
					<td>${olist.want_date }</td>
					<td onclick="location.href='complete?orderNo=${olist.no_order}';">${olist.stat}</td>
				</tr>
			</c:if>
			<c:if test="${stat=='배송완료'}">
				<tr>
					<td>${olist.no_order}</td>
					<td>${olist.order_name}</td>
					<td>${olist.no_menu}</td>
					<td>${olist.menu_cnt }</td>
					<td>${olist.totalprice }</td>
					<td>(${olist.post }) ${olist.addr1 } ${olist.addr2 }</td>
					<td>${olist.order_date }</td>
					<td>${olist.want_date }</td>
					<td>${olist.stat}</td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>