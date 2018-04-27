<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file= "/WEB-INF/view/template/header.jsp" %>

<script src ="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

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
	
	/* 제목을 눌러 글의 내용을 볼 때(관리자 권한을 가진 계정만 모든 글을 볼 수 있고 일반회원은 자기 글만) */
	function checkname(id1, id2, auth ,authck) {
		if(id2==""){
			swal({
				text: "비회원은 이용할 수 없습니다.",
				type: 'warning',
				showCancelButton: true,
				confirmButtonColor : '#3085d6',
			}).then(function(){
				location.href="login";
			});
			return false;
		} else if(id1==id2 || auth=='관리자' || authck=='t') {
			return true;
		} else {
			swal({
				text: "비밀글은 작성자만 볼 수 있습니다.",
				type: 'warning'
			});
			return false;
		}
	}

	/* 글쓰기 버튼 눌렀을때  */
	function checkauth(auth) {
		if(auth=="") auth=null;
		if(auth==null) {
			swal({
				text: "비회원은 로그인 후 글쓰기를 하실 수 있습니다.",
				type: 'warning',
				showCancelButton: true,
				confirmButtonColor : '#3085d6',
			}).then(function(){
				location.href="login";
			})
		}else {
			location.href="bwrite";
		}
	}
</script>

<style>
	.contents_wrapper {
		border-top: 2px solid red;
	    border-bottom: 1px solid;
	}
	
	.contents_desc {
		margin-left: 50px;
	    padding: 20px 20px 20px 20px;
	}
	
	.content_table {
		width: 80%;
		background-color: rgb(255, 238, 244);
		margin-left: 140px;
		text-align: center;
	}
	
	.list_head {
		width: 100%;
		padding: 10px;
		text-align: center;
		cursor: pointer;
		vertical-align: middle;
	}
	
	.list_no {
		width: 10%;
	    display: inline-block;
	    font-size: 20px;
	}
	.content_head {
		padding: 10px;
		text-align: center;
		border-bottom: 1px solid;	
	}
	
	.list_content {
		padding: 0;
	    text-align: left;
	}
	
	.list_title {
		width: 80%;
	    display: inline-block;
	    margin-left: 5px;
	/*     text-align: left; */
	}
	.align-right{
	    display: flex;
	    flex-direction: row-reverse;
	    flex-wrap: wrap;
	}
	.q_nav {
		display: inline-block;
	}
	.q_nav:hover {
		cursor: pointer;
	}
	select {
		height: 40px;
	}
	.user-input {
		padding:10px;
	    font-size:15px;
	    outline:white;
	    border:1px solid black;
	    border-radius : 10px;
	}
	.empty{
		display: block;
	    width:100%;
	    height:50px; 
	}
	.table > thead > tr > th {
		text-align: center;	
	}
	.table > tbody > tr > td {
		vertical-align: middle;	
	}
	.title {
		text-align: center;	
	}
	.center { 
		margin: 0 auto;
	}
	
	.board_nav {
		width: 100%; 
		height: 3em;
		background-color: rgba(255,244,244,0.5);
		letter-spacing: 3px;
		padding: 5px;
	}
	
	.board_nav_font {
		font-size: 25px;
		font-style: italic;
		font-weight: lighter;
		vertical-align: middle;	
	}
</style>


<div class="container"  style="margin-top: 90px">
	<div class="center text-center">
		<br>
		<div class="board_nav center">
			<div style="display: inline;"><span class="board_nav_font"><a href="#q1">자주 묻는 질문(FAQ)</a></span> &nbsp; &frasl; &nbsp;</div>
			<div style="display: inline;"><span class="board_nav_font"><a href="#q2">문의 게시판</a></span></div>
		</div>
		<div class="row center">
			<div class="page_header center">
				<h1>자주 묻는 질문(FAQ)</h1>
				<h4>고객님들께서 자주하시는 질문을 모아 두었습니다.</h4>
			</div>
			<div class="empty"></div>
			<div class="contents_wrapper">
				<div class="content_head center">
					<div class="list_no">번호</div>
					<div class="list_title">제목</div>
				</div>
				<div class="list_content">
					<div class="list_head center" onclick="view_content('q_7')">
						<div class="list_no">7</div>
						<div class="list_title bg-success">배송 가능 지역은 어디인가요?</div>
					</div>
					<div class="contents_desc" id="q_7" style="display:none;">
						<table class="content_table">
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
						<div class="list_title bg-info">언제 배송되나요?</div>
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
						<div class="list_title bg-warning">교환 및 환불은 어떻게 할 수 있나요?</div>
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
						<div class="list_title bg-success">유통기한은 어떻게 되나요?</div>
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
						<div class="list_title bg-info">결제가 되었는데 주문 취소는 어떻게 할 수 있나요?</div>
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
						<div class="list_title bg-warning">품절일 경우 주문은 언제 가능한가요?</div>
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
						<div class="list_title bg-success">요리에 필요한 모든 재료를 보내주나요?</div>
					</div>
					<div class="contents_desc" id="q_1" style="display:none;">
						<table  class="content_table">
							<tr valign="top">
								<th>
									<img src="${pageContext.request.contextPath}/image/answer.gif" 
												width="30" height="20">
								</th>
								<td>
								소금,후추,간장 등 기본 식재료를 제외한 모든 재료를 보내드립니다.<br><br>
								집에 진간장,소금, 쌀을 이용하여 간편하게 요리해보세요.<br>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
			
		<div class="empty" id="q2"></div>
		<!-- 문의 게시판 -->
		<div class="row center">
			<div class="row center">
				<h1>문의 게시판</h1>
			</div>
			<div class="row align-right" id="check1">
				<label for="allList" style="font-size: 15px; margin-left: 10px;">전체 목록으로</label>
				<input type="checkbox" id="allList" 
						onclick="location.href='blist#q2'">
			</div>
			<br><br>
			<div class="q_nav_wrap container">
				<div class="row">
					<div class="q_nav col-md-2" onclick="location.href='blist?cg=1#q2';"><h3><span class="label label-info">배송지연/불만</span></h3></div>
					<div class="q_nav col-md-2" onclick="location.href='blist?cg=2#q2';"><h3><span class="label label-info">반품문의</span></h3></div>
					<div class="q_nav col-md-2" onclick="location.href='blist?cg=3#q2';"><h3><span class="label label-info">환불문의</span></h3></div>
					<div class="q_nav col-md-2" onclick="location.href='blist?cg=4#q2';"><h3><span class="label label-info">교환/취소문의</span></h3></div>
					<div class="q_nav col-md-2" onclick="location.href='blist?cg=5#q2';"><h3><span class="label label-info">상품정보문의</span></h3></div>
					<div class="q_nav col-md-2" onclick="location.href='blist?cg=6#q2';"><h3><span class="label label-info">기타문의</span></h3></div>
				</div>
			</div>
			<div class="row center" style="margin-top: 30px;">
				<table class="table"> 
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
							<tr class="title">
								<td>${list.no}</td>
								<td align="left">
									<c:forEach var="i" begin="1" end="${list.depth}" step="1">
										&nbsp;&nbsp;&nbsp;&nbsp;
									</c:forEach>
									
									<c:choose>
										<c:when test="${list.depth>0}">
											<img src="<c:url value="/image/re.gif"/>" width="20", height="10" 
											style="vertical-align: middle;">
											<img src="<c:url value="/image/board_lock.png"/>" width="30", height="30" 
											style="vertical-align: middle;">
										</c:when>
										<c:otherwise>
											<img src="<c:url value="/image/board_lock.png"/>" width="30", height="30" 
											style="vertical-align: middle;">
										</c:otherwise>
									</c:choose>

									<c:choose>
										<c:when test="${list.authck=='t'}">
											<a href="binfo?no=${list.no}&auth=${auth}">
												${list.title2}</a>
										</c:when>
										<c:otherwise>
											<a href="binfo?no=${list.no}&auth=${auth}"
												onclick="return checkname('${list.email}', '${ckValue}', '${auth}', '${list.authck}');">
												[${list.category}] ${list.title2}</a>
										</c:otherwise>
									</c:choose>
									
									<c:choose>
										<c:when test="${not empty list.filename}">
											<img src="<c:url value="/image/board_file.jpg"/>" width="20" height="20">
										</c:when>
									</c:choose>
									<c:choose>
										<c:when test="${list.reply>0}">[${list.reply}]</c:when>
										<c:otherwise></c:otherwise>
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
	
			<div class="row pull-right">
				<input type="button" class="btn btn-primary" value="글쓰기" 
											onclick="checkauth('${ckValue}');">
			</div>
			<nav>
				<ul class="pagination">
				    <li>
				    	<c:if test="${startBlock>1}">
					    	<a href="${url}page=${startBlock-1}#q2" aria-label="Previous">
					        	<span aria-hidden="true">&laquo;</span>
					      	</a>
				      	</c:if>
				    </li>
				    <c:forEach var="i" begin="${startBlock}" end="${endBlock}" step="1">
				    	<c:choose>
	        				<c:when test="${i == pageNo}">
				    			<li class="active"><a href="#">${i}</a></li>
				    		</c:when>
							<c:otherwise>
								<li><a href="${url}page=${i}#q2">${i}</a></li>
						  	</c:otherwise>
						</c:choose>
		        	</c:forEach>
					<c:if test="${endBlock < blockTotal}">   
				    	<li>
				    		<a href="${url}page=${endBlock+1}#q2" aria-label="Next">
				    			<span aria-hidden="true">&raquo;</span>
				    		</a>	
						</li>
				     </c:if>
				</ul>
			</nav>
				
			<div class="empty"></div>
			<!-- 검색창 -->
			<form action="blist#q2" class="form-group">
				<input type="hidden" name="cg" value="${cg}">
				<div class="row">
					<select name="type" class="select_box" id="sch" required>
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
					<input type="submit" class="btn btn-primary" value="검색">
				</div>
			</form>
		</div>
	</div>
<div class="empty"></div>
<div class="empty"></div>

<%@ include file= "/WEB-INF/view/template/footer.jsp" %>
