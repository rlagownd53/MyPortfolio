<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/view/template/header.jsp"%>
<h1>주문하기 테스트</h1>
<div class="page">
	<form action="order" method="post">
	<div class="item">
<!-- 		<div class="left-box"> -->
		<div class="item-img">
			<img src="https://placehold.it/400x350" width="400" height="350">
		</div>
		<div class="item-info">
<!-- 			<div class="info-list"> -->
<!-- 				<div class="title">배송정보</div> -->
<!-- 			</div> -->
			<div class="item-name">
				<dl>
					<dt>메뉴 이름</dt>
					<dd></dd>
				</dl>
			</div>

			<div class="price">
				<!-- 할인을 하는 경우 -->
				<span class="discount">22%</span>
				<div class="before_after">
					<span class="before"> 17,800</span> <span class="after"> <strong>13,800(할인후)</strong>
						<em>원</em>
					</span>
				</div>
			</div>

			<div class="default_info">
				<div class="view_option">
					<div class="inner">
						<dl>
							<dt>
								배송비 <strong>3000</strong> 원
							</dt>
							<dd>
								<div class="name">구매수량
								<input type="number" name="menu_cnt" value="1" min="1" step="1">
								</div>
							</dd>

						</dl>
					</div>
				</div>
			</div>

			<div class="view_button">
				<button id="paybtn" type="submit">
					<img src="${pageContext.request.contextPath}/image/check.png"
						width="20" height="20"> 
						<span>바로구매</span>
				</button>
				<button id="cartbtn" type="button" onclick="cart();">
					<img src="${pageContext.request.contextPath }/image/cart.png"
						width="20" height="20">
						<span>장바구니</span>
				</button>
			</div>

		</div>
	</div>
	<div class="detail">
		<h1>상품 상세 정보 출력</h1>
	</div>
	</form>
</div>

<script language="JavaScript">
function cart(){
	top.location="cart";
}
</script>

<%@ include file="/WEB-INF/view/template/footer.jsp"%>