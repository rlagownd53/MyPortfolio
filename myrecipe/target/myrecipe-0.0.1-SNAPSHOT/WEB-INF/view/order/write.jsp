<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/view/template/header.jsp"%>
<form action="write" method="post">
	<div class="order-header">
		<div class="order-title">주문서 작성</div>
		<div class="order-subtitle">주문하실 상품명 및 수량을 정확하게 확인해 주세요.</div>
	</div>
	<div class="order-header-line"></div>

	<div class="order-table">
		<table class="order-itemlist">
			<thead>
				<tr>
					<th class="input_txt" colspan="2">주문 상세 정보</th>
					<th class="input_txt">주문 수량</th>
					<th class="input_txt">주문 금액</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><img src="https://placehold.it/300x200"></td>
					<td>메뉴 이름</td>
					<td>${menu_cnt}개</td>
					<td>메뉴 가격</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="order-header-line"></div>

	<!-- 주문정보 입력  -> 기존 정보에서 가져옴-->
	<div class="order-info">주문자 정보</div>
	<table class="orderinfo">
		<tr>
			<td class="info-label">주문하시는 분</td>
			<td><input type="text" name="name" placeholder="주문하시는 분"></td>
		</tr>
		<tr>
			<td class="info-label">주소</td>
			<td><input type="text" name="address" readonly></td>
		</tr>
		<tr>
			<td class="info-label">핸드폰 번호</td>
			<td><input type="tel" name="phon"></td>
		</tr>
		<tr>
			<td class="info-label">이메일</td>
			<td><input type="email" name="email"></td>
		</tr>
	</table>

	<div class="order-header-line"></div>
	<!-- 배송정보 입력 -->
	<div class="order-info">배송 정보</div>

	<table class="orderinfo">
		<tr>
			<td class="info-label">배송지 선택</td>
			<td><input type="checkbox" name="normal">기본배송지 <input
				type="checkbox" name="recent">최근배송지</td>
		</tr>
		<tr>
			<td class="info-label">받으실 분</td>
			<td><input type="text" name="address"></td>
		</tr>
		<tr>
			<td class="info-label">받으실 곳</td>
			<td><input type="text" id="post" placeholder="우편번호"> <input
				type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="addr1" placeholder="주소"> <input
				type="text" id="addr2" placeholder="상세주소"></td>
		</tr>
		<tr>
			<td class="info-label">연락처</td>
			<td><input type="tel" name="phon"></td>
		</tr>
		<tr>
			<td class="info-label">배송일 선택</td>
			<td><input type="date" name="want_date"></td>
		</tr>
		<tr>
			<td class="info-label">남기실 말씀</td>
			<td><input type="text" name="comment"></td>
		</tr>
	</table>


	<div class="order-header-line"></div>
	<!-- 결제 정보 확인 -->
	<div class="order-info">결제금액</div>
	<table class="orderinfo">
		<tr>
			<td>총 주문 금액</td>
			<td>배송비</td>
			<td>총 할인 금액</td>
			<td>총 결제 예정 금액</td>
		</tr>
		<tr>
			<td>22,900</td>
			<td>3,000</td>
			<td>0</td>
			<td>26,400</td>
		</tr>
	</table>

	<div class="order-header-line"></div>
	<!-- 결제수단 선택 -->
	<div class="order-info">결제수단</div>
	<table class="orderinfo">
		<tr>
			<td>일반결제</td>
			<td><input type="checkbox">신용카드 <input type="checkbox">계좌이체
				<input type="checkbox">핸드폰 <input type="checkbox">무통장입금
			</td>
		</tr>
	</table>

	<div class="order-head-line"></div>
	<div align="center">
		<input id="paybtn" type="submit" value="결제하기">
	</div>
</form>

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
</script>

<%@ include file="/WEB-INF/view/template/footer.jsp"%>