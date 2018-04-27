<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file= "/WEB-INF/view/template/header.jsp" %>

<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="/myrecipe/css/main.css">
<script type="text/javascript" src="/myrecipe/js/ckeditor/ckeditor.js"></script>

<script>
	$(document).ready(function(){
		var xOffset = 20;
		var yOffset = 50;
		var toggle = false;
		
		$(document).on("click", ".pic", function(e){
			if(!toggle) {
				$("#prev").append("<p id='preview'><img src='"+ $(this).attr("src") + "' width='500px'/></p>");
				$("#preview")
					.css("top",(e.pageY - xOffset) + "px")
					.css("left", (e.pageX - yOffset) + "px")
					.fadeIn("fast");
				toggle = true;
			} else {
				$("#preview").remove();
				toggle = false;
			}
		});
	});

	
	function input() {
	    var max = 2000;
	    var length = 0;
	    var num= 0;
	    var ta = document.querySelector("#content");
	    //console.log(ta.value)
	    length = ta.value.length;
	    
	    for(var i=0; i<length; i++) {
	        if(!(ta.value.charCodeAt(i) >='0' && ta.value.charCodeAt(i)<='126')) {
	            num+=2;
	        } else num+=1;
	    }
	    
	    if(num > max) {
	        if(event.keyCode != '8') {
	            alert("최대 "+max+"글자 만큼만 작성가능합니다.");
	            ta.value = ta.value.substring(0, length-1);
	            return;   
	        }
	    } else {
	        var text = "("+num+ " / "+ max+")";
	        var target = document.querySelector("#limit");
	        target.innerHTML = "<small>"+text+"</small>";
	    }
	}
</script>

<div class="container" style="margin-top: 90px;">
	<div class="page" align="center">
		<div class="area-100 center">
			<div class="row center" style="background-color: rgb(239,239,239)">
				<h1>문의 글 작성하기</h1>
			</div>
			<form action="bedit" method="post" enctype="multipart/form-data">
				<%-- <sec:csrfInput/> --%>
				<input type="hidden" name="board_no" value="${no}">
				<input type="hidden" name="auth" value="${auth}">
				<div class="row center">
					<table class="info-table area-80" border="1">
						<c:if test="${auth=='일반'}">
							<tr>
								<th scope="row" class="title">질문유형</th>
								<td>
									<c:choose>
										<c:when test="${empty bdto.category}">
											<select name="category" class="select_box area-30">
												<option value="" selected>선택하세요</option>
												<option>배송지연/불만</option>
												<option>반품문의</option>
												<option>환불문의</option>
												<option>교환/취소문의</option>
												<option>상품정보문의</option>
												<option>기타문의</option>
											</select>
										</c:when>
										<c:when test="${bdto.category=='배송지연/불만'}">
											<select name="category" class="select_box area-30">
												<option value="" >선택하세요</option>
												<option selected>배송지연/불만</option>
												<option>반품문의</option>
												<option>환불문의</option>
												<option>교환/취소문의</option>
												<option>상품정보문의</option>
												<option>기타문의</option>
											</select>
										</c:when>
										<c:when test="${bdto.category=='반품문의'}">
											<select name="category" class="select_box area-30">
												<option value="" >선택하세요</option>
												<option>배송지연/불만</option>
												<option selected>반품문의</option>
												<option>환불문의</option>
												<option>교환/취소문의</option>
												<option>상품정보문의</option>
												<option>기타문의</option>
											</select>
										</c:when>
										<c:when test="${bdto.category=='환불문의'}">
											<select name="category" class="select_box area-30">
												<option value="" >선택하세요</option>
												<option>배송지연/불만</option>
												<option>반품문의</option>
												<option selected>환불문의</option>
												<option>교환/취소문의</option>
												<option>상품정보문의</option>
												<option>기타문의</option>
											</select>
										</c:when>
										<c:when test="${bdto.category=='교환/취소문의'}">
											<select name="category" class="select_box area-30">
												<option value="" >선택하세요</option>
												<option>배송지연/불만</option>
												<option>반품문의</option>
												<option>환불문의</option>
												<option selected>교환/취소문의</option>
												<option>상품정보문의</option>
												<option>기타문의</option>
											</select>
										</c:when>
										<c:when test="${bdto.category=='상품정보문의'}">
											<select name="category" class="select_box area-30">
												<option value="" >선택하세요</option>
												<option>배송지연/불만</option>
												<option>반품문의</option>
												<option>환불문의</option>
												<option>교환/취소문의</option>
												<option selected>상품정보문의</option>
												<option>기타문의</option>
											</select>
										</c:when>
										<c:when test="${bdto.category=='기타문의'}">
											<select name="category" class="select_box area-30">
												<option value="" >선택하세요</option>
												<option>배송지연/불만</option>
												<option>반품문의</option>
												<option>환불문의</option>
												<option>교환/취소문의</option>
												<option>상품정보문의</option>
												<option selected>기타문의</option>
											</select>
										</c:when>
									</c:choose>
								</td>
							</tr>
						</c:if>
						<tr>
							<th scope="row" class="title">아이디</th>
							<td>
								<input type="email" class="user-input area-40" name="email" value="${bdto.email}" readonly>
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">이름</th>
							<td>
								<input type="text" class="user-input area-40" name="name" value="${bdto.name}" readonly>
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">이메일</th>
							<td>
								<input type="email" class="user-input area-40" name="email" value="${bdto.email}" readonly>
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">제목</th>
							<td>
								<input type="text" class="user-input area-75" name="title" value="${bdto.title}" required>
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">내용</th>
							<td>
								<textarea rows="10" cols="30" name="detail" id="content"
											onkeydown="input();" onkeyup="input();" class="user-area">${bdto.detail}</textarea>
											<script>
												CKEDITOR.replace('content');
											</script><br>
								<div id="limit"></div>
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">파일 첨부</th>
							<td class="addFile" id="prev">
								<input type="file" name="file" id="file" accept="image/gif, image/jpeg, image/png"><br>
								<c:if test="${not empty bdto.filename}">
									<label class="align-left">현재 첨부된 파일 : ${bdto.filename} </label>
									<img src="<c:url value="/file/${bdto.name}/${bdto.filename}"/>" 
										class="pic" width="50" height="50" title="클릭하시면 확대됩니다.">
								</c:if>
								<c:if test="${bdto.fileExist()}">
									<input type="hidden" name="origin" value="${bdto.filename}">
								</c:if>
	<!-- 							<input type="button" id="add" class="input-btn" value="추가" style="float:right;"> -->
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">비밀번호</th>
							<td>
								<input type="password" class="user-input" name="pw" placeholder="비밀번호" required>
							</td>
						</tr>
						<c:if test="${auth=='관리자'}">
						<tr>
							<th scope="row" class="title">공지사항 설정</th>
							<td>
								<input type="checkbox" name="notice" value="공지"> 공지사항으로 설정
							</td>
						</tr>
						</c:if>
					</table>
				</div>
				<div class="btn_area area-80 center">
					<span class="left">
						<input type="button" class="input-btn" value="목록" onclick="history.back();">
					</span>
					<input type="submit" class="input-btn" value="수정">
					<input type="reset" class="input-btn" value="취소">
				</div>
			</form>
		</div>
	</div>

<%@ include file= "/WEB-INF/view/template/footer.jsp" %>