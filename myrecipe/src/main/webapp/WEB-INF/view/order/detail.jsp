<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/cancle.css?v=1">
<div class="container" style="margin-top:50;">
<div class="page text-center">
	<div class="empty-row"></div>
	<div class="row area-90 center">
		<h1>주문상세정보</h1>
		<br>
		<div class="order-number">
			<h3>주문번호 : ${groupno }</h3>
		</div>
		<div class="order-header-line"></div>
		<br>
		<div class="contents-wrapper">
			<div class="info-wrapper" align="center">
				<div class="order-info">주문상세정보</div>
				<div class="order-cnt">주문수량</div>
				<div class="cancle-cnt">옵션수량</div>
				<div class="order-price">상품금액</div>
			</div>
			<div class="divide-line"></div>

			<div class="detail-wrapper" align="center">
			<c:forEach var="orderInfo" items="${orderList }">
				<div class="order-info">
					<c:forEach var="mfdto" items="${mfdto}">
						<c:if test="${mfdto.menu_no==orderInfo.no_menu && mfdto.imgtype=='mainimg'}">
							<img src="${pageContext.request.contextPath}/menuimg/${orderInfo.menu_name}/${mfdto.filename}"
								width="130" height="130">
								${orderInfo.menu_name }
						</c:if>
					</c:forEach> 
				</div>
				<div class="order-cnt">${orderInfo.menu_cnt }</div>
				<div class="cancle-cnt">
					<c:forEach var="list" items="${menuList }">
						<c:if test="${list.menu_no eq orderInfo.no_menu }">
							<c:if test="${orderInfo.op1_cnt > 0 }">${list.op1_name }(${orderInfo.op1_cnt }개)
							</c:if><br>
							<c:if test="${orderInfo.op2_cnt > 0 }">${list.op2_name }(${orderInfo.op2_cnt }개)
							</c:if><br>
							<c:if test="${orderInfo.op3_cnt > 0 }">${list.op3_name }(${orderInfo.op3_cnt }개)
							</c:if>
						</c:if>
					</c:forEach>
				</div>
				<div class="order-price" id="order-price">${orderInfo.totalprice }</div>
			</c:forEach>
			<div class="empty-row"></div>
			
			<div class="dash-border"></div>
			<div class="item-result" align="right" style="margin-right:200px;">
			<span style="font-size:23px;">합계 :</span>
				<img src="${pageContext.request.contextPath }/image/won.png" width="30" height="30">
				<label id="result" style="font-size:23px;"></label>
				<span style="font-size:23px;">${price }원</span>
			</div>
			<div class="empty-row"></div>
		</div>
		</div>
		
<div class="order-header-line"></div>
   <div class="order-info">주문자 정보</div>
      <table class="orderinfo" width="100%">
         <tr>
            <td class="info-label">주문하시는 분</td>
            <td><label>${memberInfo.name }</label></td>
            
         </tr>
         <tr>
            <td class="info-label">주소</td>
            <td><label>(${memberInfo.post})
            ${memberInfo.addr1 }<br>${memberInfo.addr2 }</label></td>
         </tr>
         <tr>
            <td class="info-label">핸드폰 번호</td>
            <td><label>${memberInfo.phone }</label></td>
         </tr>
         <tr>
            <td class="info-label">이메일</td>
            <td><label>${memberInfo.email }</label></td>
         </tr>
      </table>
   </div>

  <div class="order-header-line"></div>
   <!-- 배송정보 입력 -->
   <div class="order-info">배송 정보</div>

   <table class="orderinfo" width="100%">
      <tr>
         <td class="info-label">받으실 분</td>
         <td>
         <label>${memberInfo.name }</label></td>
      </tr>

      <tr>
         <td class="info-label">받으실 곳</td>
         <td><label>(${memberInfo.post}) ${memberInfo.addr1}
         <br>${memberInfo.addr2}</label></td>
      </tr>
      <tr>
         <td class="info-label">연락처</td>
         <td><label>${memberInfo.phone }</label></td>
      </tr>
      <tr>
         <td class="info-label">배송예정일</td>
         <td><input type="date" name="want_date" value="${want_date }" readonly>
         (배송업체 사정상 최대 1일 지연도착 가능)</td>
      </tr>
      <tr>
     	 <c:if test="${comments ne null }">
         <td class="info-label">남기신 말씀</td>
         <td><input type="text" name="comments" value="${comments}"></td></c:if>
      </tr>
   </table>
   <br>
   <div align="center">
	<button onclick="javascript:window.close()">닫기</button>
	</div>
</div>

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
    
    .divide-line {
    height: 1px;
    background-color: gray;
    width: auto;
    margin-left: 10px;
    margin-right: 10px;
    margin-top: 10px;
    margin-bottom: 20px;
    }
    .dash-border{
	border-bottom: dashed 1px #696969;
	margin-left: 2px;
	margin-right: 30px;
	margin-top: 20px;
	margin-bottom: 20px;
}
 
    
     
    
    .info-label{
    width : 20%;
    }
}
	
</style>

