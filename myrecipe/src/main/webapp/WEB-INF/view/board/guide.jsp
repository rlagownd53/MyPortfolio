<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file= "/WEB-INF/view/template/header.jsp" %>
<script src ="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
	/* 공간창출 위한 css <br>과 같은 역할*/
	.empty{
		display: block;
	    width:100%;
	    height:40px; 
	}
	.titlearea {
		width: 98%;
		margin: 10px 0px 20px 10px; 
		border-bottom: 1px solid rgb(208,208,208);
	}
	
	/* 외부를 감싸고 있는 div 속성 */
	.guidepage {
		width: 100%;
		text-align: left;	
		padding: 10px;
	}
	
	.guide_head{
		position:relative;
	}
	
	/* ul태그 css */
	.guidebar {
		width: 100%;
		padding: 0px;
   		border-bottom: 1px solid;
   		border-left : 0;
   		display: table;
   		margin: 0 0 10px;
	}
	
	/* ul 안의 li 속성 css*/
	.guidebar li {
		float: none;
		display: inline-block;
		vertical-align: middle;
		width: 16.6%;
		letter-spacing: 2px;
	}
	
 	.select, .guidebar li:hover{  
 		position: relative; 
 		top: 0; 
 		padding : 13px; 
 		background: black; 
 		border : 1px solid black;
 		border-bottom: 0; 
 		color: white; 
 	} 
 	.guidebar li:hover a{
 		text-decoration: none;
 		color: white;
 	}
 	
	.guidebar li.select a{
		text-decoration: none;
		min-width: 0;
		border: 0;
		font-size: 15px;
		text-align: center;
		display: inline-block;
		margin:0;
		color: white;
	}
	
	.guidebar li a{
		width:100%;		
		min-width: 0;
		border: 0;
		font-size: 15px;
		text-align: center;
		display: inline-block;
		margin:0;
		color: black;
	}
	
	/* 설명 div 속성 */
	.guidecontent{
		margin: 30 0;
		padding: 10px;
		line-height: 200%;
	}
	
	/* p태그 폰트 속성 */
	.guide_font{
		font-size: 17px;
		font-family: monospace;
	}
</style>

<div class="empty"></div>
<div class="container" style="margin-top: 90px;">
	<div class="titlearea">
		<h2 style="letter-spacing: 2px;">이용방법</h2>
	</div>
	<div class="guidepage">
		<div id="membership" class="guide_head">
			<ul class="guidebar">
				<li class="select"><a href="#">회원가입 안내</a></li>
				<li><a href="#order">주문 안내</a></li>
				<li><a href="#payment">결제 안내</a></li>
				<li><a href="#delivery">배송 안내</a></li>
				<li><a href="#change">교환/반품 안내</a></li>
				<li><a href="#refund">주문취소/환불 안내</a></li>
			</ul>
			<div class="guidecontent">
				<h2 style="letter-spacing: 2px;">회원가입 안내</h2>
				<p class="guide_font">
					[회원가입] 메뉴를 통해 이용약관, 개인정보보호정책 동의 및 일정 양식의 가입항목을 기입함으로써 회원에 가입되며, <br>
					가입 즉시 서비스를 무료로 이용하실 수 있습니다. 주문하실 때에 입력해야하는 각종 정보들을 일일이 입력하지 않으셔도 됩니다. <br>
					공동구매, 경매행사에 항상 참여하실 수 있습니다. 회원을 위한 이벤트 및 각종 할인행사에 참여하실 수 있습니다.
				</p>
			</div>
		</div>
		<div id="order" class="guide_head">
			<ul class="guidebar">
				<li><a href="#membership">회원가입 안내</a></li>
				<li class="select"><a href="#">주문 안내</a></li>
				<li><a href="#payment">결제 안내</a></li>
				<li><a href="#delivery">배송 안내</a></li>
				<li><a href="#change">교환/반품 안내</a></li>
				<li><a href="#refund">주문취소/환불 안내</a></li>
			</ul>
		</div>
		<div class="guidecontent">
			<h2 style="letter-spacing: 2px;">주문 안내</h2>
			<p class="guide_font">
				상품주문은 다음단계로 이루어집니다.<br><br>
				- Step1: 상품검색<br>
				- Step2: 장바구니에 담기<br>
				- Step3: 회원ID 로그인<br>
				- Step4: 주문서 작성<br>
				- Step5: 결제방법선택 및 결제<br>
				- Step6: 주문 성공 화면 (주문번호)<br><br>
				비회원일 경우 주문이 불가하오니 회원가입후 이용하여 주시길 바랍니다.
			</p>
		</div>
		<div id="payment" class="guide_head">
			<ul class="guidebar">
				<li><a href="#membership">회원가입 안내</a></li>
				<li><a href="#order">주문 안내</a></li>
				<li class="select"><a href="#">결제 안내</a></li>
				<li><a href="#delivery">배송 안내</a></li>
				<li><a href="#change">교환/반품 안내</a></li>
				<li><a href="#refund">주문취소/환불 안내</a></li>
			</ul>
		</div>
		<div class="guidecontent">
			<h2 style="letter-spacing: 2px;">결제 안내</h2>
			<p class="guide_font">
				저희는 신용카드, 계좌이체 , 무통장입금의 3가지 결제방법을 제공하여 드립니다. <br>
				무통장 입금이나 계좌이체를 이용하실 경우 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접<br>
				입금하시면 되고, 신용카드 결제는 OOOPG사의 전자결제를 이용하므로 보안문제는 걱정하지 않으셔도 되며, 이용내역서에는 <br>
				㈜OOO으로 기록됩니다.<br><br> 
				이용 가능한 국내 발행 신용카드<br>
				- 국내발행 모든 신용카드 <br><br>
				이용 가능한 해외 발생 신용카드 <br>
				- VISA Card, MASTER Card, AMEX Card<br><br> 
				무통장 입금 가능 은행 <br>
				- OO은행, OO은행 <br><br>
				무통장 입금시의 송금자 이름은 주문시 입력하신 주문자의 실명이어야 합니다.
			</p>
		</div>
		<div id="delivery" class="guide_head">
			<ul class="guidebar">
				<li><a href="#membership">회원가입 안내</a></li>
				<li><a href="#order">주문 안내</a></li>
				<li><a href="#payment">결제 안내</a></li>
				<li class="select"><a href="#">배송 안내</a></li>
				<li><a href="#change">교환/반품 안내</a></li>
				<li><a href="#refund">주문취소/환불 안내</a></li>
			</ul>
		</div>
		<div class="guidecontent">
			<h2 style="letter-spacing: 2px;">배송 안내</h2>
			<p class="guide_font">
				배송 방법 : 택배<br>
				배송 지역 : 전국(제주/도서산간 제외)<br>
				배송 비용 : 3000원<br>
				배송 기간 : 2일 ~ 4일<br>
				배송 안내 : 신선식품이므로 산간벽지나 도서지방은 배송이 불가합니다.<br><br>
				고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있으며,<br>
				주문하실 때 희망 배송일자를 넉넉히 잡아주시면(3일이상) 원하시는 날짜에 배송할 수 있도록 최선을 다하겠습니다.
			</p>
		</div>
		<div id="change" class="guide_head">
			<ul class="guidebar">
				<li><a href="#membership">회원가입 안내</a></li>
				<li><a href="#order">주문 안내</a></li>
				<li><a href="#payment">결제 안내</a></li>
				<li><a href="#delivery">배송 안내</a></li>
				<li class="select"><a href="#">교환/반품 안내</a></li>
				<li><a href="#refund">주문취소/환불 안내</a></li>
			</ul>
		</div>
		<div class="guidecontent">
			<h2 style="letter-spacing: 2px;">교환/반품 안내</h2>
			<p class="guide_font">
				<b>상품의 특성상 아래의 경우 교환이나 반품/환불이 불가능합니다.</b><br>
				-주관적인 의견 및 단순변심인 경우<br>
				-고객님의 보관 부주의로 상품이 변질될 경우<br>
				-물품을 개봉하고 시간경과로 인해 재판매가 불가능하게 된 경우<br>
				-반품배송 시 상품이 손상되어 온 경우<br>
				(냉동식품의 경우 상품 특성상 반품자체가 불가능하오니 신중한 구매 부탁드립니다)<br><br>
				
				<b>상품에 문제가 있는 경우 수령하신 날 즉시 연락을 주셔야 교환 및 환불이 가능합니다.</b><br><br>
								
				<b>(문제가 있는 상품 교환 및 환불하려면?)</b><br>
				-절대 상품을 폐기하지 마시고 사진촬영 후 고객센터로 전화 주세요.<br>
				-고객센터와 통화 후 반송해 주세요.<br>
				-반송된 상품을 쿡템에서 확인 후 교환 및 환불해 드립니다.<br>
				(상품이 없을 경우 교환 환불이 불가 하오니 양해 바랍니다)
			</p>
		</div>
		<div id="refund" class="guide_head">
			<ul class="guidebar">
				<li><a href="#membership">회원가입 안내</a></li>
				<li><a href="#order">주문 안내</a></li>
				<li><a href="#payment">결제 안내</a></li>
				<li><a href="#delivery">배송 안내</a></li>
				<li><a href="#change">교환/반품 안내</a></li>
				<li class="select"><a href="#">주문취소/환불 안내</a></li>
			</ul>
		</div>
		<div class="guidecontent">
			<h2 style="letter-spacing: 2px;">주문취소/환불 안내</h2>
			<p class="guide_font">
				주문 취소는 미결재인 상태에서는 고객님이 직접 취소하실 수가 있습니다. 결제후 취소는 저희 고객센터로 문의해 주시기 바랍니다. <br>
				무통장 입금의 경우 일정기간동안 송금을 하지 않으면 자동 주문 취소가 되고, 구매자가 원하는 경우 인터넷에서 바로 취소 하실 수도 있으며,<br>
				 송금을 하신 경우에는 환불조치 해드립니다. 카드로 결제하신 경우, 승인 취소가 가능하면 취소을 해드리지만 승인 취소가 불가능한 경우 <br>
				 해당 금액을 모두 송금해 드립니다. 반송을 하실 때에는 주문번호, 회원번호를 메모하여 보내주시면 보다 신속한 처리에 도움이 됩니다.
			</p>
		</div>
	</div>


<div class="empty"></div>
<div class="empty"></div>

<%@ include file= "/WEB-INF/view/template/footer.jsp" %>