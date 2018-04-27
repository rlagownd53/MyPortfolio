<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ include file= "/WEB-INF/view/template/header.jsp" %>

<link rel="stylesheet" type="text/css" href="/recipe/css/main.css">


<script>
	function input() {
	    var max = 2000;
	    var length = 0;
	    var num= 0;
	    var ta = document.querySelector("textarea");
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
	    //console.log(typeof length);
	    //console.log(length);
	}
</script>

<div class="page" align="center">
	<div class="area-100 center">
		<div class="row center" style="background-color: rgb(239,239,239)">
			<h1>문의 글 작성하기</h1>
		</div>
		<form action="bwrite" name="write_form" method="post">
			<div class="row center">
				<table class="user-table">
					<tr>
						<th>질문유형</th>
						<td>
							<select name="category" class="select_box area-30">
								<option value="">선택하세요</option>
								<option>배송지연/불만</option>
								<option>반품문의</option>
								<option>환불문의</option>
								<option>교환/취소문의</option>
								<option>상품정보문의</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>
							<input type="email" class="user-input area-90" name="email" placeholder="아이디" required>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input type="text" class="user-input area-90" name="name" placeholder="이름" required>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input type="email" class="user-input area-90" name="email" placeholder="이메일" required>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" class="user-input area-90" name="title" placeholder="제목" required>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea rows="10" cols="30" name="detail" style="width:650px; height:350px;" 
										onkeydown="input();" onkeyup="input();" class="user-area"></textarea><br>
							<div id="limit"></div>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" class="user-input" name="pw" placeholder="비밀번호" required>
						</td>
					</tr>
				</table>
			</div>
			<div class="btn_area area-70 center">
				<span class="left">
					<input type="button" class="input-btn" value="목록" onclick="history.back();">
				</span>
				<input type="submit" class="input-btn" value="등록">
				<input type="reset" class="input-btn" value="취소">
			</div>
		</form>
	</div>
</div>


<%@ include file= "/WEB-INF/view/template/footer.jsp" %>