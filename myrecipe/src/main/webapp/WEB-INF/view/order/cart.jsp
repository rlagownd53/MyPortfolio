<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="/WEB-INF/view/template/header.jsp"%>
<style>
	.child-td{
		display: flex;
		align-items: center;
	}
</style>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/cancle.css?v=11">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/cart.css?v=16">
<div class="container" style="margin-top:90;">
<div class="page text-center">
<form action="cart" method="post" id="orderform">
<%-- 	<input type="hidden" name="no" value=${no }> --%>
	<div class="empty-row"></div>
	<div class="row area-90 center">
		<h1>장바구니</h1>
		<small>주문하실 상품명 및 수량을 정확하게 확인해주세요.</small>
		<div class="empty-row"></div>
		<div class="info-wrapper" align="left">
			<h2>
				장바구니에 담긴 상품 <label style="color: #B90000">${fn:length(cartList) }</label>건
			</h2>
		</div>
		<br>
		<div class="order-header-line"></div>

		<div class="state-wrapper" align="left">
			<table class="cart-itemlist text-center">
				<thead>
					<tr>
						<th></th>
						<th colspan="2" class="text-center">주문상세 정보</th>
						<th></th>
						<th class="text-center">옵션수량</th>
						<th class="text-center">주문금액</th>
					</tr>
				</thead>
				<tbody>
					
					<c:forEach var="cart" items="${cartList}" begin="0">
					<c:set var="total" value="${cart.menu_price * cart.menu_cnt }"/>
						<tr class="vertical-align">
							<td><input type="checkbox" name="del_check" value="${cart.no }" checked></td>
							<td colspan="2" class="text-left"><img
								src="${pageContext.request.contextPath}/menuimg/${cart.menu_name}/${cart.filename}"
								width="130" height="130"> ${cart.menu_name}</td>
							<td><div class="align-middle"><input type="number" id="menucnt${cart.no }"
								value="${cart.menu_cnt }" min="1" step="1">
								<input type="button" value="수정" class="editbtn" id="${cart.no }"></div></td>
							<td><c:if test="${cart.op1_cnt > 0 }">${cart.op1_name } : ${cart.op1_cnt }개
							<c:set var="total" value="${total+cart.op1_cnt*cart.op1_price }"/></c:if><br>
								<c:if test="${cart.op2_cnt > 0 }">${cart.op2_name } : ${cart.op2_cnt }개
								<c:set var="total" value="${total+cart.op2_cnt*cart.op2_price }"/></c:if><br>
								<c:if test="${cart.op3_cnt > 0 }">${cart.op3_name } : ${cart.op3_cnt }개
								<c:set var="total" value="${total+cart.op3_cnt*cart.op3_price }"/></c:if>
							</td>
							<td class="align-middle">
							<label id="pricelb${cart.no }" style="color:#B90000;font-size:28px;">${total }원</label>
							</td>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
			<div class="empty-row"></div>
			<div class="item-result">
				<img src="${pageContext.request.contextPath }/image/won.png" width="30" height="30">
				<label id="result" style="font-size:23px;"></label>
				<span style="font-size:23px;">원</span>
			</div>
			<div class="empty-row"></div>
			
		</div>
		
		<div class="order-header-line"></div>
		<div class="btn-wrpper">
			<div class="btn-content"><input class="btn btn-default" type="button" value="이전으로" 
			onclick="history.back();"></div>
			<div class="btn-content"><input class="btn btn-danger" id="order" type="submit" value="선택상품 주문"></div>
			<div class="btn-content"><input class="btn btn-default" id="delete" type="button" value="선택상품 삭제"></div>
			<div class="btn-content"><input class="btn btn-default" id="deleteAll" type="button" value="전체 비우기"></div>
		</div>
		<div class="empty-row"></div>
		</div>
	</form>
	</div>
<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script>
	$(document).ready(function() {
		var result = 0;
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		$('.editbtn').each(function() {
			
			var id = $(this).attr('id');
			var price = $('#pricelb'+id).text().substr(0,$('#pricelb'+id).text().indexOf('원'));
			var cnt_before = $('#menucnt'+id).val(); //수정전 개수
			var item_price =  Number(price)/Number(cnt_before); //상품가격
			
			result = result + Number(price);
			$('#result').text(result); //합계
			
			$(this).on('click', function(e){
				console.log("이전 값 : " + cnt_before);
				
				var print = Number($('#result').text()); //이전 합계
				
				var cnt = $('#menucnt'+id).val(); //변경된 개수
				console.log("현재 값 : " +  cnt);
				var res = parseInt(cnt) * item_price; //변경된 상품가격
			
				$('#pricelb'+id).text(res + '원');
				if(cnt>cnt_before){
					console.log("실행1");
					$('#result').text(print+(cnt-cnt_before)*item_price); //합계 변경
				}else{
					console.log("실행2");
					console.log("이전 " +cnt_before);
					console.log(cnt);
					console.log(print-(cnt_before-cnt)*item_price);
					$('#result').text(print-(cnt_before-cnt)*item_price); 	
				}
				
				cnt_before = cnt; //현재값을 이전값으로 저장
				$.post("editcart",{
					menu_cnt: cnt,
					no: id
					}
				);
				return false;
					
			});
		});
		
		$('#delete').on('click', function(){
			var del_no = new Array();//선택 삭제 배열
			
			$('input[name="del_check"]:checked').each(function(i){
				del_no.push($(this).val());
			});
			console.log("삭제 번호 : " + del_no);
			
			$.ajaxSettings.traditional = true; //배열값 전송을 위한 ajax 세팅
			
			console.log("실행");
			$.ajax({
				url : "delete",
				type:"post",
				async : false, 
				data:{no : del_no},
				success: function (result){
					if(result){
						console.log("성공");
					}else{
						console.log("실패");
					}
				}
			});
			location.reload();
		});
		
		$('#deleteAll').on('click', function(){
			var result = confirm('모두 삭제하시겠습니까?');
			
			if(result){
				$.ajax({
					url : "deleteAll",
					type:"get",
					success: function (result){
						if(result){
							console.log("성공");
						}else{
							console.log("실패");
						}
					}
				});
				location.reload();
			}
		});
	
	});
</script>


<%@ include file="/WEB-INF/view/template/footer.jsp"%>
