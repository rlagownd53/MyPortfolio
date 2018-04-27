<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach var="list" items="${orderList }">
	<div class="contents" onclick="view('detail_${list.no_order}');">
		<div class="order-no">${list.no_order }</div>
		<div class="order-date">${list.order_date }</div>
		<div class="order-menu">${list.menu_name }</div>
		<div class="order-price">${list.totalprice }</div>
		<div class="order-stat">${list.stat }</div>
		<div class="order-menudetail">
			<a
				href="${pageContext.request.contextPath }/order?no=${list.no_menu}">
				<img src="${pageContext.request.contextPath }/image/detail.png"
				width="20" height="20">
			</a>
		</div>
		<div class="order-cancle">
			<c:if test="${list.stat eq '입금 확인중' or list.stat eq '입금 완료'}">
				<button id="cancle"
					onclick="location.href='cancle?no_order=${list.no_order}'">
					<span>취소하기</span>
				</button>
			</c:if>
		</div>
	</div>

	<div class="contents-detail" id="detail_${list.no_order }"
		style="display: none;" align="center">
		<table class="contents-table">
			<tr>
				<td class="td-info">받는 분</td>
				<td>${list.order_name }</td>
			</tr>
			<tr>
				<td class="td-info">받으실 곳</td>
				<td>(${list.post })${list.addr1 } ${list.addr2 }</td>
			</tr>
			<tr>
				<td class="td-info">연락처</td>
				<td>${list.tel }</td>
			</tr>
			<tr>
				<td class="td-info">배송예정일</td>
				<td>${list.want_date }</td>
			</tr>
			<c:if test="${!empty list.comments }">
				<tr>
					<td class="td-info">주문메세지</td>
					<td>${list.comments }</td>
				</tr>
			</c:if>
		</table>
	</div>
</c:forEach>