<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/view/template/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/cancle.css?v=3">
<div class="container" style="margin-top:90;">
<div class="page text-center">
	<div class="empty-row"></div>
	<div class="row area-90 center">
		<h1>주문취소</h1>
		<br>
		<div class="small-wrapper" align="left">
			<small>취소하실 상품의 수량과 사유를 선택하시고 결제금액을 확인해주세요.</small><br> <small>부분취소
				시 할인/결제 금액이 변경됩니다.</small>
		</div>

		<div class="empty-row"></div>
		

		<div class="order-number text-left">
			<h3>주문번호 : ${groupno }</h3>
		</div>
		
		<div class="order-header-line"></div>
		<br>
		<div class="contents-wrapper">
		<table class="table">
			<thead>
				<tr>
					<th class="text-center">상품정보/판매가</th>
					<th class="text-center">주문수량</th>
					<th class="text-center">취소수량</th>
					<th class="text-center">주문금액/취소금액</th>
					<th class="text-center">취소사유</th>
				</tr>
			</thead>
		<tbody>
				<c:set var="total" value="0"/>
				<c:forEach var="orderInfo" items="${orderList }">
				<tr>
				<c:set var="total" value="${total + orderInfo.totalprice }"/>
				<td class="order-info white text-left" style="text-overflow:ellipsis;">
					<c:forEach var="mfdto" items="${mfdto}">
						<c:if test="${mfdto.menu_no==orderInfo.no_menu && mfdto.imgtype=='mainimg'}">
							<img src="${pageContext.request.contextPath}/menuimg/${orderInfo.menu_name}/${mfdto.filename}"
								width="130" height="130">${orderInfo.menu_name }
						</c:if>
					</c:forEach> 
				</td>
				<td>${orderInfo.menu_cnt }</td>
				<td>${orderInfo.menu_cnt }</td>
				<td>${orderInfo.totalprice }</td>
				<td>
					<select>
						<option selected>단순변심</option>
						<option>배송 지연</option>
						<option>상품 품절</option>
						<option>다른 상품 잘못 주문</option>
						<option>상품옵션 선택 실수</option>
					</select>
				</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

			<div id="cancle-form">
				<div class="order-header-line"></div>
				<h3>결제정보</h3>
				<div class="empty-row"></div>
				<form action="cancle" method="post">
					<input type="hidden" name="groupno" value="${groupno}">
					<div align="center">
						<table>
							<tr>
								<td class="td-info">주문금액</td>
								<td>${total + 3000 }원</td>
							</tr>
							<tr>
								<td class="td-info">환불예정 금액</td>
								<td><span id="price_span">${total + 3000 }원</span></td>
							</tr>
						</table>
					</div>
					<div class="empty-row"></div>
					<input id="paybtn" class="btn btn-default" type="button" value="이전으로" onclick="history.back();">
					<input type="submit" class="btn btn-danger" id="cancle_btn" value="주문취소하기">
				</form>
				<div class="empty-row"></div>
			</div>
		</div>
	</div>
</div>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script>

	$(document).ready(function() {
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		$('#cancle_btn').on('click', function() {
			
			var queryString = $("form[type=hidden]").serialize();
			
			$.ajax({
				url:'cancle',
				type:'post',
				data:queryString,
				beforeSend: function(xhr) {
		            xhr.setRequestHeader(header, token);
				}
			});
			
		});
	});
</script>

<%@ include file="/WEB-INF/view/template/footer.jsp"%>
