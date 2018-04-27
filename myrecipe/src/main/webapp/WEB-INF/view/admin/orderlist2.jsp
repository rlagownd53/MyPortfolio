<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/view/admin/adminnav.jsp"%>
<div class="col-lg-9" style="padding-top: 50px">
	<h1 class="text-center">판매 완료 주문 리스트</h1>
	<table id="myTable" class="tablesorter table table-bordered">
		<thead>
		<tr>
			<th>주문 번호</th>
			<th>주문자 이름</th>
			<th>메뉴 이름</th>
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
			<c:if test="${stat eq '배송완료'}">
				<tr>
					<td>${olist.no_order}</td>
					<td>${olist.order_name}</td>
					<td>${olist.menu_name}</td>
					<td>${olist.menu_cnt }</td>
					<td>${olist.totalprice }</td>
					<td>(${olist.post }) ${olist.addr1 } ${olist.addr2 }</td>
					<td>${olist.order_date}</td>
					<td>${olist.want_date }</td>
					<td>${olist.stat}</td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
	</table>
</div></div>
