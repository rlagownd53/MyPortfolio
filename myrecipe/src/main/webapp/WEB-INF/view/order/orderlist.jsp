<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/write.css"> --%>
<link rel="stylesheet" type="text/css"
   href="${pageContext.request.contextPath}/css/myorder.css?v=5">
<div class="container" style="margin-top: 90;">
   <div class="page text-center">
      <div class="empty-row"></div>
      <div class="row area-90 center">
         <h1>나의 주문 내역</h1>
      </div>
      <div class="empty-row"></div>
	<div class="order-header-line"></div>
      <div class="wrapper ">
      <table class="table table-responsive table-hover text-center">
      	<thead>
         <tr>
            <th class="text-center">주문번호</th>
            <th class="text-center">주문일자</th>
            <th class="text-center">상품명</th>
            <th class="text-center">결제금액</th>
            <th class="text-center">주문상태</th>
            <th class="text-center">주문정보</th>
            <th class="text-center">주문취소</th>
          </tr>
         </thead>
         <tbody>
         <c:forEach var="list" items="${orderList}">
        	<c:if test="${list.groupno ne target}">
             <tr>
            <td> ${list.groupno }</td>
               <td>${list.order_date }</td>
               <td>
               <c:choose>
                  <c:when test="${list.groupsize-1 > 0 }">
                     ${list.menu_name }외 ${list.groupsize-1 }건
                  </c:when>
                  <c:otherwise>
                     ${list.menu_name }
                  </c:otherwise>
               </c:choose></td>
              <td> ${menulist.get(list.groupno)+3000}</td>
              <td>${list.stat }</td>
             <td>
                     <img src="${pageContext.request.contextPath }/image/detail.png"
                     width="20" height="20" onclick="popup(${list.groupno}, ${menulist.get(list.groupno)+3000})">
            </td>
              <td>
              
                  <c:if test="${list.stat eq '입금 확인중' or list.stat eq '입금 완료'}">
                     <button id="cancle" class="btn btn-default"
                        onclick="location.href='cancle?groupno=${list.groupno}'">
                        <span>취소하기</span>
                     </button>
                  </c:if>
              </td>
          <c:set var="target" value="${list.groupno}"/>
          </tr>
			</c:if>          
         </c:forEach>
        </tbody>
        </table>
        </div>
         <!-- 최근 한달 -->
         <!--       select * from menu_order where order_date between to_date(add_months(sysdate, -1)) and sysdate;  -->
         <div class="empty-row"></div>
         <button id="viewmore" class="btn btn-primary">
            <span>30일 이전 배송내역 더보기</span>
         </button>
         <div class="empty-row"></div>
         <div id="contents-more"></div>
      </div>
   </div>
<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script>
   function popup(no, price){
      var url = "detail?groupno="+no+"&price="+price;
      var name = "popup";
      window.open(url,name,"width=1000,height=750,toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=yes,left=100,right=50");
   }
   
   //30일 전 배송 내역 더보기
   $(document).ready(function() {

      $('#viewmore').bind('click', function() {

         console.log('${no_member}');

         $.post("html", {
            no_member : '${no_member}'
         }, function(htmlResult) {
            $('#contents-more').html(htmlResult);//html코드 추가
         });
      });

   });
</script>

<%@ include file="/WEB-INF/view/template/footer.jsp"%>