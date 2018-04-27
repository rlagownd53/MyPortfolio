<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file= "/WEB-INF/view/template/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">

<script src="http://code.jquery.com/jquery-3.2.1.js"></script>


<script>
	var preContent;
	function view_content(target) {
		var curContent = document.getElementById(target);
		if(preContent && preContent==curContent) {
			preContent.style.display == "none" ? preContent.style.display = "block" : preContent.style.display = "none";
		} else {
			if(preContent) preContent.style.display = "none";
			curContent.style.display = "block";
		}
		preContent = curContent;
	}
	
	function search(type, key) {
		console.log("type = "+type);
		console.log("key = "+key);
	}
</script>

<div class="page center">
	<br>
	<div class="empty-row"></div>
	<div class="board_nav center">
		<div style="display: inline;"><span><a href="#q1">자주 묻는 질문(FAQ)</a></span> &nbsp; / &nbsp;</div>
		<div style="display: inline;"><span><a href="#q2">문의 게시판</a></span></div>
	</div>
	<div class="row area-90 center">
		<div class="page_header center">
			<h1>자주 묻는 질문(FAQ)</h1>
			<br>
			<small>고객님들께서 자주하시는 질문을 모아 두었습니다.</small>
		</div>
		<div class="contents_wrapper">
			<div class="content_head center">
				<div class="list_no">번호</div>
				<div class="list_title">제목</div>
			</div>
			<div class="list_content">
				<div class="list_head center" onclick="view_content('q_7')">
					<div class="list_no">7</div>
					<div class="list_title">배송 가능 지역은 어디인가요?</div>
				</div>
				<div class="contents_desc" id="q_7" style="display:none;">
					<table  class="content_table">
						<tr valign="top">
							<th>
								<img src="${pageContext.request.contextPath}/image/answer.gif" 
											width="30" height="20">
							</th>
							<td>
							현재 제주도 및 도서산간 지방을 제외한 전국으로 배송이 가능합니다.<br><br>
							다만 지역에 따라 배송시간이 상이하며, 저녁식사 시간 이후 도착할 수 있다는 것을 명심하세요.<br><br>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="list_head center" onclick="view_content('q_6')">
					<div class="list_no">6</div>
					<div class="list_title">언제 배송되나요?</div>
				</div>
				<div class="contents_desc" id="q_6" style="display:none;">
					<table  class="content_table">
						<tr valign="top">
							<th>
								<img src="${pageContext.request.contextPath}/image/answer.gif" 
											width="30" height="20">
							</th>
							<td>
							선택하신 배송도착예정일로부터 하루 전에 발송되며 익일날 받아 보실 수 있습니다.<br><br>
							다만, 저녁식사시간 이후 도착할 수 있으며, 이후 도착을 이유로 환불은 불가능합니다.<br><br>
							이점 유의하시길 바랍니다.<br>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="list_head center" onclick="view_content('q_5')">
					<div class="list_no">5</div>
					<div class="list_title">교환 및 환불은 어떻게 할 수 있나요?</div>
				</div>
				<div class="contents_desc" id="q_5" style="display:none;">
					<table  class="content_table">
						<tr valign="top">
							<th>
								<img src="${pageContext.request.contextPath}/image/answer.gif" 
											width="30" height="20">
							</th>
							<td>
							식품이라는 특성 상 교환이 불가하오니 신중한 구매를 부탁드립니다. 물론 보내드린 박스에<br><br>
							하자가 있을 경우엔 폐기절차 후 환불 과정을 진행하실 수 있습니다. 저희가 보내드린 쿠킹박스에<br><br>
							문제가 있으신가요? 언제든지 문의게시판이나 고객센터로 전화주시면 빠르게 보상처리를 받으실 수 있습니다.<br>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="list_head center" onclick="view_content('q_4')">
					<div class="list_no">4</div>
					<div class="list_title">유통기한은 어떻게 되나요?</div>
				</div>
				<div class="contents_desc" id="q_4" style="display:none;">
					<table  class="content_table">
						<tr valign="top">
							<th>
								<img src="${pageContext.request.contextPath}/image/answer.gif" 
											width="30" height="20">
							</th>
							<td>
							상품을 배송 받으신 날부터 3일 이내에 요리하시는 것을 권장해 드립니다. 하지만 마트에서 <br><br>
							따로 장을 보신것보다는 보다 오래 신선도가 유지된다는 것을 눈으로 확인하실 수 있을거에요.<br><br>
							육류의 경우 개별 유통기한이 표시되어 있으며 닭이나 오리같은 가금류의 경우 유통기한이 <br><br>
							짧으므로 유통기한 내에 가장 먼저 요리하세요.<br>
							</td>
						</tr>
					</table>
				</div>
				<div class="list_head center" onclick="view_content('q_3')">
					<div class="list_no">3</div>
					<div class="list_title">결제가 되었는데 주문 취소는 어떻게 할 수 있나요?</div>
				</div>
				<div class="contents_desc" id="q_3" style="display:none;">
					<table  class="content_table">
						<tr valign="top">
							<th>
								<img src="${pageContext.request.contextPath}/image/answer.gif" 
											width="30" height="20">
							</th>
							<td>
							결제후 3일 내에 연락주시면 취소가 가능합니다. 문의게시판이나 고객센터로 연락주세요. 단, 3일이<br><br>
							지난 후에는 수확 및 선별,포장이 이미 진행되기 때문에 결제취소가 불가능하다는 점 알려드립니다. 해당 주소로<br><br>
							상품수령이 어려울 경우, 주소 변경은 가능하니 최대한 빠르게 연락 부탁드립니다.<br> 
							</td>
						</tr>
					</table>
				</div>
				<div class="list_head center" onclick="view_content('q_2')">
					<div class="list_no">2</div>
					<div class="list_title">품절일 경우 주문은 언제 가능한가요?</div>
				</div>
				<div class="contents_desc" id="q_2" style="display:none;">
					<table  class="content_table">
						<tr valign="top">
							<th>
								<img src="${pageContext.request.contextPath}/image/answer.gif" 
											width="30" height="20">
							</th>
							<td>
							저희는 신선한 요리를 제공하기 위해 매주 일정량만 판매하고 있습니다.<br><br>
							품절일 경우는 저희가 미리 준비한 수량이 모두 팔린 경우로 해당주에는 품절 상품의 구매가 <br><br>
							어렵습니다. 하지만 매주 새롭게 판매되오니 다음 주에 구매를 부탁드리겠습니다.<br>
							</td>
						</tr>
					</table>
				</div>
				<div class="list_head center" onclick="view_content('q_1')">
					<div class="list_no">1</div>
					<div class="list_title">요리에 필요한 모든 재료를 보내주나요?</div>
				</div>
				<div class="contents_desc" id="q_1" style="display:none;">
					<table  class="content_table">
						<tr valign="top">
							<th>
								<img src="${pageContext.request.contextPath}/image/answer.gif" 
											width="30" height="20">
							</th>
							<td>
							소금,후추,간장 등 기본 식재료를 제외한 모든 재료를 보내드립니다. 집에 진간장,소금,<br><br>
							쌀을 이용하여 간편하게 요리해보세요.<br>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		
		<div class="empty-row" id="q2"></div>
		<!-- 문의 게시판 -->
		<div class="row area-90 center">
			<div class="row center">
				<h1>문의 게시판</h1>
			</div>
			<div class="row align-right" id="check1">
				<label for="allList" style="font-size: 15px">전체 목록으로</label>
				<input type="checkbox" id="allList" 
						onclick="history.back();">
				&nbsp;&nbsp;
				<label for="myQnA" style="font-size: 15px">내 게시글만 보기</label>
				<input type="checkbox" id="myQnA" 
						onclick="location.href='blist/me?name=aaa';">
			</div>
			<br>
			<div class="row align-right">
				<input type="button" class="input-btn" value="글쓰기" 
							onclick="location.href='bwrite';">
			</div>
			<div class="row center">
				<table border="1" class="user-table area-100 center"> 
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${list}">
							<tr>
								<td>${list.no}</td>
								<td align="left">
									<c:choose>
										<c:when test="${empty list.category}">
											<a href="binfo?no=${list.no}">${list.title}</a>
										</c:when>
										<c:otherwise>
											<a href="binfo?no=${list.no}"
											>[${list.category}] ${list.title}</a>
										</c:otherwise>
									</c:choose>
								</td>
								<td>${list.name}</td>
								<td>${list.auto}</td>
								<td>${list.read}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>				
			</div>

			<!-- 검색창 -->
			<form action="blist">
				<div class="row">
					<select name="type" class="select_box">
						<c:if test="${empty type}">
							<option value="" selected>선택하세요</option>
							<option value="title">제목</option>
							<option value="name">작성자</option>
							<option value="category">문의유형</option>
						</c:if>
						<c:if test="${type=='title'}">
							<option value="">선택하세요</option>
							<option value="title" selected>제목</option>
							<option value="name">작성자</option>
							<option value="category">문의유형</option>
						</c:if>
						<c:if test="${type=='name'}">
							<option value="">선택하세요</option>
							<option value="title">제목</option>
							<option value="name" selected>작성자</option>
							<option value="category">문의유형</option>
						</c:if>
						<c:if test="${type=='category'}">
							<option value="">선택하세요</option>
							<option value="title">제목</option>
							<option value="name">작성자</option>
							<option value="category" selected>문의유형</option>
						</c:if>
					</select>
					<c:choose>
						<c:when test="${empty key}">
							<input type="search" name="key" class="user-input area-20" placeholder="검색어 입력"required>
						</c:when>
						<c:otherwise>
							<input type="search" name="key" class="user-input area-20" value="${key}" required>
						</c:otherwise>
					</c:choose>
					<input type="submit" class="input-btn" value="검색" onclic="search(type, key)">
				</div>
			</form>
			<div class="empty-row"></div>
		</div>
	</div>
</div>

<%@ include file= "/WEB-INF/view/template/footer.jsp" %>
