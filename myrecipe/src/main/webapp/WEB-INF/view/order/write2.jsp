<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<script>
   function check() {
      var res =  confirm("결재를 진행하시겠습니까?");
      if(res==true){
         return true;
      }else if(res==false){
         return false;
      }
   }
</script>
<link rel="stylesheet" type="text/css"
   href="${pageContext.request.contextPath}/css/write.css?v=2">
<div class="container" style="margin-top:90;">
<form onsubmit="return check();" action="write2" method="post">
   <div class="order-header">
		<div class="order-title">주문서 작성</div>
		<div class="order-subtitle">주문하실 상품명 및 수량을 정확하게 확인해 주세요.</div>
	</div>
	<div class="order-header-line"></div>

	<div class="order-table">
		<table class="order-itemlist text-center">
			<thead>
				<tr>
					<th class="input_txt text-center" colspan="2">주문 상세 정보</th>
					<th class="input_txt text-center">주문 수량</th>
					<th class="input_txt text-center">옵션 수량</th>
					<th class="input_txt text-center">주문 금액</th>
				</tr>
			</thead>
         <tbody>
            <c:set var="total" value="0"/>
            <c:forEach var="cart" items="${cartList}">
                  <tr>
                     <td colspan="2" class="text-left"><img src="${pageContext.request.contextPath}/menuimg/${cart.menu_name}/${cart.filename}"
                        width="130" height="130"> ${cart.menu_name}</td>
                     <td>${cart.menu_cnt }개
                      <br>(개당 ${cart.menu_price}원)
                      <input type="hidden" name="no_menu" value="${cart.no_menu }">
                      <input type="hidden" name="no" value="${cart.no }">
                      </td>
					<td><c:if test="${cart.op1_cnt > 0 }">${menuInfo.op1_name }(${cart.op1_cnt }개)
						<input type="hidden" name="op1_cnt" value="${op1_cnt }">
					</c:if><br>
						<c:if test="${cart.op2_cnt > 0 }">${menuInfo.op2_name }(${cart.op2_cnt }개)
						<input type="hidden" name="op2_cnt" value="${op2_cnt }">
						</c:if><br>
						<c:if test="${cart.op3_cnt > 0 }">${cart.menuInfo.op3_name }(${op3_cnt }개)
						<input type="hidden" name="op3_cnt" value="${op3_cnt }">
						</c:if>
					 </td>
                     <td><label name="pricelb" id="pricelb${cart.no }" style="color:#B90000;font-size:28px;">${cart.menu_price * cart.menu_cnt}원</label></td>
                     <c:set var="total" value="${total+cart.menu_cnt*cart.menu_price}"/>
                  </tr>
               </c:forEach>
         </tbody>
      </table>
   </div>

   <div class="order-header-line"></div>

   <!-- 주문정보 입력  -> 기존 정보에서 가져옴-->
   <input type="hidden" name="no_member" value="${memberInfo.no }">
   <input type="hidden" name="menu_cnt" value="${cart.menu_cnt}"> <input
      type="hidden" name="no_menu" value="${menuInfo.menu_no }"> <input
      type="hidden" name="menu_name" value="${cart.menu_name }">

  <div class="order-info text-center">주문자 정보</div>
		<table class="orderinfo">
			<tr>
				<td class="info-label text-center">주문하시는 분</td>
				<td><input class="form-control" type="text" placeholder="${memberInfo.name }"
					readonly></td>
			</tr>
			<tr>
				<td class="info-label text-center">주소</td>
				<td><input class="form-control" type="text" placeholder="${memberInfo.addr1 }"
					readonly></td>
			</tr>
			<tr>
				<td class="info-label text-center">핸드폰 번호</td>
				<td><input class="form-control" type="tel" placeholder="${memberInfo.phone }"
					readonly></td>
			</tr>
			<tr>
				<td class="info-label text-center">이메일</td>
				<td><input class="form-control" type="email" placeholder="${memberInfo.email }"
					readonly></td>
			</tr>
		</table>

  <div class="order-header-line"></div>
	<!-- 배송정보 입력 -->
	<div class="order-info text-center">배송 정보</div>
		<table class="orderinfo">
		<tr>
			<td class="info-label text-center">배송지 선택</td>
			<td><div class="checkbox"><input type="radio" name="d_choice" value="normal"
				onclick="div_OnOff(this.value);" checked>기본배송지 
				<input type="radio" name="d_choice" value="recent"
				onclick="div_OnOff(this.value);">최근배송지 
				<input type="radio" name="d_choice" value="new" 
				onclick="div_OnOff(this.value);">신규배송지</div></td>
		</tr>

		<tr>
			<td class="info-label text-center">받으실 분</td>
			<td class="text-left"><div class="col-sm-3"><input class="form-control" type="text" name="name" value="${memberInfo.name }"
				required></div></td>
		</tr>

		<tr>
			<td class="info-label text-center">받으실 곳</td>
			<td><div class="col-sm-3"><input class="form-control" type="text" name="post" id="post" placeholder="우편번호"
				value="${memberInfo.post}" required></div>
				<div class="text-left"><input type="button" onclick="sample6_execDaumPostcode();"
				value="우편번호 찾기" class="btn btn-info"></div><br>
				<div class="col-sm-7"><input class="form-control" type="text" name="addr1" id="addr1"
				value="${memberInfo.addr1}" placeholder="주소"></div>
				<div class="col-sm-3"><input class="form-control" type="text" name="addr2" id="addr2" value="${memberInfo.addr2}"
				placeholder="상세주소" required></div>
				</td>
		</tr>
		<tr>
			<td class="info-label text-center">연락처</td>
			<td><div class="col-sm-3"><input class="form-control" type="tel" name="tel" value="${memberInfo.phone }"
				required></div></td>
		</tr>
		<tr>
			<td class="info-label text-center">배송일 선택</td>
			<td><div class="col-sm-3"><input class="form-control" type="date" 
			name="want_date" id="want_date" required></div>
			(배송업체 사정상 최대 1일 지연도착 가능)</td>
		</tr>
		<tr>
			<td class="info-label text-center">남기실 말씀</td>
			<td><div class="col-sm-8">
			<input class="form-control" type="text" name="comments"></td></div>
		</tr>
	</table>


<div class="order-header-line"></div>
	<!-- 결제 정보 확인 -->
	<div class="order-info text-center">결제금액</div>
	<table class="orderinfo table text-center">
		<tr>
			<td>총 주문 금액</td>
			<td></td>
			<td>배송비</td>
			<td></td>
			<td>총 할인 금액</td>
			<td></td>
			<td>총 결제 예정 금액</td>
		</tr>
			<tr>
			<td><c:out value="${total }"/></td>
			<td><img src="${pageContext.request.contextPath }/image/plus.png" width="20" height="20"></td>
			<td>3,000</td>
			<td><img src="${pageContext.request.contextPath }/image/minus.png" width="20" height="20"></td>
			<td>0</td>
			<td><img src="${pageContext.request.contextPath }/image/equal.png" width="20" height="20"></td>
			<td><c:out value="${total + 3000 }"/></td>
			<td><input type="hidden" name="totalprice"
				value="${total }"></td>
		</tr>
	</table>

   <div class="order-header-line"></div>
	<!-- 결제수단 선택 -->
	<div class="order-info text-center">결제수단</div>
	<table class="orderinfo">
		<tr>
			<td class="text-center">일반결제</td>
			<td><input type="radio" name="payment" value="creditcard"
				checked>신용카드 <input type="radio" name="payment"
				value="account">계좌이체 <input type="radio" name="payment"
				value="noaccount">무통장입금</td>
		</tr>
	</table>

  <div class="empty-row"></div>
	<div align="center">
		<input id="canclebtn" class="btn btn-default" type="button" value="취소하기">
		<input id="paybtn" class="btn btn-danger" type="submit" value="결제하기">
	</div>
</form>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
<%-- <meta name="_csrf" content="${_csrf.token}"/> --%>
<%-- <meta name="_csrf_header" content="${_csrf.headerName}"/> --%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
   function sample6_execDaumPostcode() {
      new daum.Postcode(
            {
               oncomplete : function(data) {
                  // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                  var fullAddr = ''; // 최종 주소 변수
                  var extraAddr = ''; // 조합형 주소 변수

                  // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                     fullAddr = data.roadAddress;

                  } else { // 사용자가 지번 주소를 선택했을 경우(J)
                     fullAddr = data.jibunAddress;
                  }

                  // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                  if (data.userSelectedType === 'R') {
                     //법정동명이 있을 경우 추가한다.
                     if (data.bname !== '') {
                        extraAddr += data.bname;
                     }
                     // 건물명이 있을 경우 추가한다.
                     if (data.buildingName !== '') {
                        extraAddr += (extraAddr !== '' ? ', '
                              + data.buildingName : data.buildingName);
                     }
                     // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                     fullAddr += (extraAddr !== '' ? ' (' + extraAddr
                           + ')' : '');
                  }

                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
                  document.getElementById('post').value = data.zonecode; //5자리 새우편번호 사용
                  document.getElementById('addr1').value = fullAddr;

                  // 커서를 상세주소 필드로 이동한다.
                  document.getElementById('addr2').focus();
               }
            }).open();
   }

   function div_OnOff(v) {
      if (v == "normal") {
         document.getElementById('post').value = '${memberInfo.post}';
         document.getElementById('addr1').value = '${memberInfo.addr1}';
         document.getElementById('addr2').value = '${memberInfo.addr2}';
      }

      if (v == "recent") {
         document.getElementById('post').value = '${recentOrder.post}';
         document.getElementById('addr1').value = '${recentOrder.addr1}';
         document.getElementById('addr2').value = '${recentOrder.addr2}';
      }

      if (v == "new") {
         document.getElementById('post').value = '';
         document.getElementById('addr1').value = '';
         document.getElementById('addr2').value = '';
      }
   }
   
   $(document).ready(function() {
// 	   var token = $("meta[name='_csrf']").attr("content");
// 	   var header = $("meta[name='_csrf_header']").attr("content");
	   
      var today = new Date();
      var dd = today.getDate()+3;
      var mm = today.getMonth()+1;
      var yy = today.getFullYear();
      if(dd < 10)
         dd = '0' + dd;
      if(mm<10)
         mm = '0' + mm;
      var rightnow = yy + '-' + mm + '-' + dd;
      $('#want_date').attr('min', rightnow);
      
      $('#canclebtn').on('click', function(){
    	  console.log("실행");
    	  
//     	  var arr = new Array();
//     	  $('#cartno').each(function(i){
// 				arr.push($(this).val());
// 			});
		 var arr = $('input[type="hidden"][name="no"]').map(function(){
			 return this.getAttribute("value");
		 }).get();
    	  
		 for(var i=0;i<arr.length;i++)
    	  console.log("선택번호 : " +arr[i]);
    	  
    	  
    	  $.ajaxSettings.traditional = true;
			$.ajax({
				url:'back2',
				type:'post',
				async : false,
				data: {
					no: arr
				}
			});
			location.href="cart";
		});
      $("#nav").click(function(e){
// 			e.preventDefault();
		var arr = $('input[type="hidden"][name="no"]').map(function(){
			 return this.getAttribute("value");
		 }).get();
    	  
		 for(var i=0;i<arr.length;i++)
    	  console.log("선택번호 : " +arr[i]);
    	  
    	  
    	  $.ajaxSettings.traditional = true;
    	  
    	  $.ajax({
				url:'back2',
				type:'post',
				async : false,
				data: {
					no: arr
				}
			});
		});
   });
   
 //뒤로가기버튼 막기
	history.pushState(null, document.title, location.href); 
	window.addEventListener('popstate', function(event) {
		alert('뒤로가기 버튼을 사용할 수 없습니다.');
		history.pushState(null, document.title, location.href);
	});
	
// 	$(window).bind("beforeunload", function() {
// 		//실행할 함수를 리턴해야한다.
// 		var res = confirm('종료하시겠습니까?');
// 		if(res)
// 			return true;
// 		else
// 			return false;
// 	});
</script>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>