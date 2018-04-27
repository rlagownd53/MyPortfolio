<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/admin/adminnav.jsp"%>
<script src="${pageContext.request.contextPath}/js/olist/list.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(document).ready(function() {
		$("#myTable2").tablesorter({
			sortList : [ [ 0, 1 ] ],
			headers : {
				1 : {
					sorter : "Integer"
				},
				debug : true
			}
		});
	})
</script>
<div class="col-lg-9" style="padding-top: 50px">
	<h1 class="text-center">신규 주문 리스트</h1>
	<button id="new" class="btn btn-default">전체 선택</button>
	<button id="update" class="btn btn-success">체크된 상태 변경</button>
	<table id="myTable" class="tablesorter table table-bordered">
		<thead>
			<tr>
				<th>체크</th>
				<th>주문 번호</th>
				<th>주문자 이름</th>
				<th>메뉴 이름</th>
				<th>수량</th>
				<th>총 주문 금액</th>
				<th>배송지 정보</th>
				<th>주문일자</th>
				<th>배송예정일</th>
				<th>주문 상태</th>
				<th></th>
				<th></th>
			</tr>
		</thead>
		<tbody id="choice1">
			<c:forEach var="olist" items="${olist}">
				<c:set var="stat" value="${olist.stat}"></c:set>
				<c:if test="${stat eq '입금 확인중'}">
					<tr class="ch1">
						<td><input type="checkbox" id="newcheck"
							name="${olist.no_order}" value="${olist.stat}"></td>
						<td>${olist.no_order}</td>
						<td>${olist.order_name}</td>
						<td>${olist.menu_name}</td>
						<td>${olist.menu_cnt }</td>
						<td>${olist.totalprice }</td>
						<td>(${olist.post }) ${olist.addr1 } ${olist.addr2 }</td>
						<td>${olist.order_date}</td>
						<td>${olist.want_date }</td>
						<td>${olist.stat}</td>
						<td><select id="stat-select">
								<option value="선택" selected="selected">선택</option>
								<option value="입금 확인중">입금 확인중</option>
								<option value="입금 완료">입금 완료</option>
								<option value="배송중">배송중</option>
								<option value="배송 완료">배송 완료</option>
						</select></td>
						<td><button class="stat-bth">변경</button></td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<h1 class="text-center">배송 예정 및 배송중 주문 리스트</h1>
	<button id="shipping" class="btn btn-default">전체 선택</button>
	<button id="update2" class="btn btn-success">체크된 상태 변경</button>
	<table id="myTable2" class="tablesorter table table-bordered">
		<thead>
			<tr>
				<th>체크</th>
				<th>주문 번호</th>
				<th>주문자 이름</th>
				<th>메뉴 이름</th>
				<th>수량</th>
				<th>총 주문 금액</th>
				<th>배송지 정보</th>
				<th>주문일자</th>
				<th>배송예정일</th>
				<th>주문 상태</th>
				<th></th>
				<th></th>
			</tr>
		</thead>
		<tbody id="choice2">
			<c:forEach var="olist" items="${olist}">
				<c:set var="stat" value="${olist.stat}"></c:set>
				<c:if test="${stat eq '입금 완료' or stat eq '배송중'}">
					<tr class="ch2">
						<td><input type="checkbox" id="newcheck2"
							name="${olist.no_order}" value="${olist.stat}"></td>
						<td>${olist.no_order}</td>
						<td>${olist.order_name}</td>
						<td>${olist.menu_name}</td>
						<td>${olist.menu_cnt }</td>
						<td>${olist.totalprice }</td>
						<td>(${olist.post }) ${olist.addr1 } ${olist.addr2 }</td>
						<td>${olist.order_date}</td>
						<td>${olist.want_date }</td>
						<td>${olist.stat}</td>
						<td><select id="stat-select" name="stat-select">
								<option value="선택">선택</option>
								<option value="입금 확인중">입금 확인중</option>
								<option value="입금 완료">입금 완료</option>
								<option value="배송중">배송중</option>
								<option value="배송 완료">배송 완료</option>
						</select></td>
						<td><button class="stat-bth">변경</button></td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table></div>
	<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<script>
		$(document)
				.ready(
						function() {
							var token = $("meta[name='_csrf']").attr("content");
							var header = $("meta[name='_csrf_header']").attr("content");
							$("#update")
									.click(
											function() {
												var stat = $(
														'input[id="newcheck"]:checked')
														.serializeArray()
														.map(function(item) {
															return item.value
														});
												var no = $(
														'input[id="newcheck"]:checked')
														.serializeArray()
														.map(function(item) {
															return item.name
														});
												for (var i = 0; i < no.length; i++) {
													var alldata = {
														"orderNo" : no[i],
														"orderSt" : stat[i]
													};
													$.ajax({
																url : "${pageContext.request.contextPath}/complete",
																type : "post",
																data : alldata,
																async : false,
																beforeSend: function(xhr) {
														            xhr.setRequestHeader(header, token);
														        },
																sussess : function(
																		data) {
																	console
																			.log("수정 완료!");
																},
																error : function(
																		jqXHR,
																		textStatus,
																		errorThrown) {
																	alert("에러 발생~~ \n"
																			+ textStatus
																			+ " : "
																			+ errorThrown);
																},
																fail : function() {
																	alert("전송 실패");
																}
															});
												}
												location.reload();
											});
							$("#update2")
									.click(
											function() {
												var stat = $(
														'input[id="newcheck2"]:checked')
														.serializeArray()
														.map(function(item) {
															return item.value
														});
												var no = $(
														'input[id="newcheck2"]:checked')
														.serializeArray()
														.map(function(item) {
															return item.name
														});
												for (var i = 0; i < no.length; i++) {
													var alldata = {
														"orderNo" : no[i],
														"orderSt" : stat[i]
													};
													$.ajax({
																url : "${pageContext.request.contextPath}/complete",
																type : "post",
																data : alldata,
																async : false,
																beforeSend: function(xhr) {
														            xhr.setRequestHeader(header, token);
														        },
																sussess : function(
																		data) {
																	console
																			.log("수정 완료!");
																},
																error : function(
																		jqXHR,
																		textStatus,
																		errorThrown) {
																	alert("에러 발생~~ \n"
																			+ textStatus
																			+ " : "
																			+ errorThrown);
																},
																fail : function() {
																	alert("전송 실패");
																}
															});
												}
												location.reload();
											});
						});
	</script>
	<script>
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
		$(".stat-bth").click(function() {
			var tdArr = new Array(); // 배열 선언
			var checkBtn = $(this);
			var tr = checkBtn.parent().parent();
			var td = tr.children();
			var no = td.eq(1).text();
			var stat = td.eq(9).text();
			var target = td.eq(10).children();
			console.log(no);
			console.log(stat);
			console.log(target.val());
			if(stat!=target.val() && target.val()!="선택"){
				alldata = {
						"orderNo" : no,
						"orderSt" : target.val()
				};
				$.ajax({
					url : "${pageContext.request.contextPath}/complete2",
					type : "post",
					data : alldata,
					async : false,
					beforeSend: function(xhr) {
			            xhr.setRequestHeader(header, token);
			        },
					sussess : function(
							data) {
						console.log("수정 완료!");},
					error : function(
							jqXHR,
							textStatus,
							errorThrown) {
						alert("에러 발생~~ \n"
								+ textStatus
								+ " : "
								+ errorThrown);
					},
					fail : function() {
						alert("전송 실패");
					}
				});
	
	location.reload();
		};
		});
	</script>
</div>
</div>
