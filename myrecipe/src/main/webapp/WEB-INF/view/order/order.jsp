<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/view/template/header.jsp"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/order.css?v=22">


<div class="container" style="margin-top:90;">
<div class="page center">
	<div class="empty-row"></div>
	<div class="row area-90 center">
		<form action="order" method="post" onkeydown="return captureReturnKey(event)"
		onsubmit="return popUp(${menuInfo.stock});">
			<div class="item-wrapper">
				<div class="item-img">
					<c:forEach var="mfdto" items="${mfdto}">
						<c:if
							test="${mfdto.menu_no==menuInfo.menu_no && mfdto.imgtype=='mainimg'}">
							<img
								src="${pageContext.request.contextPath}/menuimg/${menuInfo.name}/${mfdto.filename}"
								width="400" height="400">
							<input type="hidden" name="filename" value="${mfdto.filename }">
						</c:if>
					</c:forEach>
				</div>

				<div class="item-info">

					<input type="hidden" name="no_menu" value="${menuInfo.menu_no}">
					<div class="item-name" align="left">
						<label style="font-size: 26px;">${menuInfo.name }</label>
					</div>

					<div class="item-detail" align="left">
						<b>${menuInfo.type }류</b>
					</div>

					<br>
					<div class="border"></div>

					<div class="price">
						<div class="info">상품가격</div>
						<div class="detail">${menuInfo.price }원</div>
					</div>

					<div class="default_info">
						<div class="info">배송정보</div>
						<div class="detail">일반배송</div>
					</div>

					<div class="default_info">
						<div class="info">배송비</div>
						<div class="detail">3000원</div>
					</div>

					<div class="dash-border"></div>
					<div class="default_info">
						<div class="detail">(남은 수량 : ${menuInfo.stock }개)</div>
					</div><br>
					
					<div class="form-group">
						<div class="info">수량</div>
						<div class="detail col-sm-2">
							<input type="number" class="form-control" name="menu_cnt" id="menu_cnt" value="1"
								min="1" step="1">
						</div>
					</div>
					<div class="dash-border"></div>
					
					<div class="form-group">
					<input type="hidden" name="op1_name" value=${menuInfo.op1_name }>
					<input type="hidden" name="op1_price" value="${menuInfo.op1_price }">
						<c:if test="${not empty menuInfo.op1_name}">
							<div class="info">${menuInfo.op1_name }(${menuInfo.op1_price}원)</div>
							<div class="detail col-sm-2">
								<input type="number" class="form-control" name="op1_cnt" id="op1_cnt" value="0"
									min="0" max="100" step="1">
									
							</div>
						</c:if>
					</div>
					<br>
					<div class="form-group">
					<input type="hidden" name="op2_name" value=${menuInfo.op2_name }>
					<input type="hidden" name="op2_price" value="${menuInfo.op2_price }">
						<c:if test="${not empty menuInfo.op2_name}">
							<div class="info">${menuInfo.op2_name }(${menuInfo.op2_price}원)</div>
							<div class="detail col-sm-2">
								<input type="number" class="form-control" name="op2_cnt" id="op2_cnt" value="0"
									min="0" max="100" step="1">
							</div>
						</c:if>
					</div>
					
					
					<div class="form-group">
						<input type="hidden" name="op3_name" value=${menuInfo.op3_name }>
						<input type="hidden" name="op3_price" value="${menuInfo.op3_price }">
						<c:if test="${not empty menuInfo.op3_name}">
							<div class="info">${menuInfo.op3_name }(${menuInfo.op3_price}원)</div>
							<div class="detail col-sm-2">
								<input type="number" class="form-control" name="op3_cnt" id="op3_cnt" value="0"
									min="0" max="100" step="1">
							</div>
						</c:if>
					</div>
					<div class="border"></div>

					<div class="price">
						<div class="info">가격</div>
						<div class="detail">
							<label id="price" style="font-size: 24px; color: #d44d44;">${menuInfo.price }원</label>
						</div>
					</div>

					<div class="view_button">
						<button name="cartbtn" id="cartbtn" type="submit"
						style="background-color:rgb(255,255,255); color:rgb(68,68,68);">
							<img src="${pageContext.request.contextPath }/image/cart.png"
								width="20" height="20"> <span>장바구니</span>
						</button>
						
						<button name="paybtn" id="paybtn" type="submit" 
						style="background-color:rgb(68,68,68); color:rgb(255,255,255);">
							<img src="${pageContext.request.contextPath}/image/check.png"
								width="20" height="20" class="check-img"><span>바로구매</span>
						</button>
					</div>

				</div>
			</div>
			
			<div class="empty-row"></div>
			<div class="order-header-line"></div>

			<div class="menu-detail text-center">
				<h3>이렇게 보내드립니다.</h3>
				<div class="empty-row"></div>
				<c:forEach var="mfdto" items="${mfdto}">
					<c:if
						test="${mfdto.menu_no==menuInfo.menu_no && mfdto.imgtype=='foodimg'}">
						<img
							src="${pageContext.request.contextPath}/menuimg/${menuInfo.name}/${mfdto.filename}"
							width="800" height="600">
					</c:if>
				</c:forEach>

				<div class="empty-row"></div>
				<div class="material">
					<h3>사용자 레시피</h3>
					<c:forEach var="mfdto" items="${mfdto}">
						<c:if
							test="${mfdto.menu_no==menuInfo.menu_no && mfdto.imgtype=='recipeimg'}">
							<img
								src="${pageContext.request.contextPath}/menuimg/${menuInfo.name}/${mfdto.filename}">
						</c:if>
					</c:forEach>
				</div>
				<div class="empty-row"></div>
			</div>
		</form>
	</div>
</div>

<script language="JavaScript">
	function popUp(stock){
		
		if(stock == 0){
		   alert("해당 상품은 품절입니다.");
			return false;
		}
	}
	
	function captureReturnKey(e){
		if(e.keyCode==13 && e.srcElement.type != 'textarea')
			return false;
	}

	$(document).ready(function() {
		var menu;
		var op1;
		var op2;
		var op3;
				
		$('#menu_cnt').blur(function() {
				menu = $('#menu_cnt').val();
				op1 = $('#op1_cnt').val();
				op2 = $('#op2_cnt').val();
				op3 = $('#op3_cnt').val();
				
				if(menu > 100){
					alert("수량은 최대 100개입니다.");
					$('#menu_cnt').val(100);
				}
				
					
				if(isNaN(op1))
					op1=0;
					
				if(isNaN(op2))
					op2=0;
					
				if(isNaN(op3))
					op3=0;
					
				var res = menu*'${menuInfo.price}'+op1*'${menuInfo.op1_price}'
					+op2*'${menuInfo.op2_price}'+op3*'${menuInfo.op3_price}';
					
					$('#price').text(res+'원');
		});

		$('#menu_cnt').on('click',function() {
					menu = $('#menu_cnt').val();
					op1 = $('#op1_cnt').val();
					op2 = $('#op2_cnt').val();
					op3 = $('#op3_cnt').val();
					
					if(menu > 100){
						alert("수량은 최대 100개입니다.");
						$('#menu_cnt').val(100);
					}
					
					if(isNaN(op1))
						op1=0;
					
					if(isNaN(op2))
						op2=0;
					
					if(isNaN(op3))
						op3=0;
					
					var res = menu*'${menuInfo.price}'+op1*'${menuInfo.op1_price}'
					+op2*'${menuInfo.op2_price}'+op3*'${menuInfo.op3_price}';
					
					$('#price').text(res+'원');
				});
				$('#op1_cnt').blur(function() {
					menu = $('#menu_cnt').val();
					op1 = $('#op1_cnt').val();
					op2 = $('#op2_cnt').val();
					op3 = $('#op3_cnt').val();
					
					if(op1 > 5){
						alert("수량은 최대 5개입니다.");
						$('#op1_cnt').val(5);
					}
					
					
					if(isNaN(op1))
						op1=0;
					
					if(isNaN(op2))
						op2=0;
					
					if(isNaN(op3))
						op3=0;
					var res = menu*'${menuInfo.price}'+op1*'${menuInfo.op1_price}'
					+op2*'${menuInfo.op2_price}'+op3*'${menuInfo.op3_price}';
					
					$('#price').text(res+'원');
				});
				
				$('#op1_cnt').on('click',function() {
					menu = $('#menu_cnt').val();
					op1 = $('#op1_cnt').val();
					op2 = $('#op2_cnt').val();
					op3 = $('#op3_cnt').val();
					
					if(op1 > 5){
						alert("수량은 최대 5개입니다.");
						$('#op1_cnt').val(5);
					}
					
					
					if(isNaN(op1))
						op1=0;
					
					if(isNaN(op2))
						op2=0;
					
					if(isNaN(op3))
						op3=0;
					var res = menu*'${menuInfo.price}'+op1*'${menuInfo.op1_price}'
					+op2*'${menuInfo.op2_price}'+op3*'${menuInfo.op3_price}';
					
					$('#price').text(res+'원');
				});
				
				$('#op2_cnt').blur(function() {
					menu = $('#menu_cnt').val();
					op1 = $('#op1_cnt').val();
					op2 = $('#op2_cnt').val();
					op3 = $('#op3_cnt').val();
					
					if(op2 > 5){
						alert("수량은 최대 5개입니다.");
						$('#op2_cnt').val(5);
					}
					
					
					if(isNaN(op1))
						op1=0;
					
					if(isNaN(op2))
						op2=0;
					
					if(isNaN(op3))
						op3=0;
					var res = menu*'${menuInfo.price}'+op1*'${menuInfo.op1_price}'
					+op2*'${menuInfo.op2_price}'+op3*'${menuInfo.op3_price}';
					
					$('#price').text(res+'원');
				});
				
				$('#op2_cnt').on('click',function() {
					menu = $('#menu_cnt').val();
					op1 = $('#op1_cnt').val();
					op2 = $('#op2_cnt').val();
					op3 = $('#op3_cnt').val();
					
					if(op2 > 5){
						alert("수량은 최대 5개입니다.");
						$('#op2_cnt').val(5);
					}
					
					if(isNaN(op1))
						op1=0;
					
					if(isNaN(op2))
						op2=0;
					
					if(isNaN(op3))
						op3=0;
					var res = menu*'${menuInfo.price}'+op1*'${menuInfo.op1_price}'
					+op2*'${menuInfo.op2_price}'+op3*'${menuInfo.op3_price}';
					
					$('#price').text(res+'원');
				});
				
				$('#op3_cnt').blur(function() {
					menu = $('#menu_cnt').val();
					op1 = $('#op1_cnt').val();
					op2 = $('#op2_cnt').val();
					op3 = $('#op3_cnt').val();
					
					if(op3 > 5){
						alert("수량은 최대 5개입니다.");
						$('#op2_cnt').val(5);
					}
					
					if(isNaN(op1))
						op1=0;
					
					if(isNaN(op2))
						op2=0;
					
					if(isNaN(op3))
						op3=0;
					var res = menu*'${menuInfo.price}'+op1*'${menuInfo.op1_price}'
					+op2*'${menuInfo.op2_price}'+op3*'${menuInfo.op3_price}';
					
					$('#price').text(res+'원');
				});
				
				$('#op3_cnt').on('click',function() {
					menu = $('#menu_cnt').val();
					op1 = $('#op1_cnt').val();
					op2 = $('#op2_cnt').val();
					op3 = $('#op3_cnt').val();
					
					if(op3 > 5){
						alert("수량은 최대 5개입니다.");
						$('#op2_cnt').val(5);
					}
					
					if(isNaN(op1))
						op1=0;
					
					if(isNaN(op2))
						op2=0;
					
					if(isNaN(op3))
						op3=0;
					var res = menu*'${menuInfo.price}'+op1*'${menuInfo.op1_price}'
					+op2*'${menuInfo.op2_price}'+op3*'${menuInfo.op3_price}';
					
					$('#price').text(res+'원');
				});
				
// 				$('#cartbtn').on('click',function(){
// 					var res = confirm('장바구니로 이동하시겠습니까?');
// 					if(res){
						
// 					}else{
// 						window.history.back();
// 					}
// 				});
			
	});
</script>

<style>
	.order-header-line {
    height: 2px;
    background-color: #cc7772;
    width: auto;
    margin-left: 10px;
    margin-right: 10px;
    margin-top: 10px;
    margin-bottom: 20px;
    }
</style>

<%@ include file="/WEB-INF/view/template/footer.jsp"%>