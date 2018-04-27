<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file= "/WEB-INF/view/template/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="/myrecipe/css/main.css">
<script type="text/javascript" src="/myrecipe/js/ckeditor/ckeditor.js"></script>
<script src ="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
	.empty{
		display: block;
	    width:100%;
	    height:50px; 
	}
	.btn_area {
		margin: 20px 0px 70px 10px;
	    text-align: right;
	    width: 75%;
	}
</style>
<script>
// 	var cnt = 1;
// 	$(document).ready(function(){
// 		$("#add").on("click", function(){
// 			if(cnt==3) {
// 				alert("파일 첨부는 최대 3개까지 가능합니다.");				
// 			} else {
// 				cnt = cnt+1;
// 				var id = "img"+cnt;
// 				var input = $("<input/>").attr({id:"file"+cnt, type:"file", name:"file"});
// 				var img = $("<img>").attr({src:"/myrecipe/image/x.jpg", 
// 						id:id, style:"vertical-align: middle;",width:"20", height:"20", onclick:"del('"+id+"')"});
// 				var br = $("<br>").attr({id:"br"+cnt})
// 				$(".addFile").append(br).append(img).append(input);
// 			}
// 		});
// 	});
	
// 	function del(id) {
// 		if(id=='img2') {
// 			$("#br2").remove();
// 			$("#"+id).remove();
// 			$("#file2").remove();
// 			cnt-=1;
// 		}else {
// 			$("#br3").remove();
// 			$("#"+id).remove();
// 			$("#file3").remove();
// 			cnt-=1;
// 		}
// 	}
	
	function input() {
	    var max = 2000;
	    var length = 0;
	    var num= 0;
	    var ta = document.querySelector("#content");
	    console.log(ta.text)
	    length = ta.value.length;
	    
	    for(var i=0; i<length; i++) {
	        if(!(ta.value.charCodeAt(i) >='0' && ta.value.charCodeAt(i)<='126')) {
	            num+=2;
	        } else num+=1;
	    }
	    
	    if(num > max) {
	        if(event.keyCode != '8') {
	            swal("최대 "+max+"글자 만큼만 작성가능합니다.");
	            ta.value = ta.value.substring(0, length-1);
	            return;   
	        }
	    } else {
	        var text = "("+num+ " / "+ max+")";
	        var target = document.querySelector("#limit");
	        target.innerHTML = "<small>"+text+"</small>";
	    }
	}
	
	function titleinput() {
		var max = 200;
		var length = 0;
		var num = 0 ;
		var title = document.querySelector("#title");
		length = title.value.length;

		for(var i=0; i<length; i++) {
			if(!(title.value.charCodeAt(i)>='0' && title.value.charCodeAt(i)<='126')) {
				num+=2;
			} else num+=1;
		}
		
		console.log("num = "+num);
		if(num>max) {
			if(event.keyCode != '8') {
				swal("제목은 한글 기준 최대 "+max+"글자 만큼만 작성가능합니다.");
				title.value = title.value.substring(0, length-1);
				return;
			}
		} 
	}
</script>

<div class="container" style="margin-top : 90px;">
	<div class="page" align="center">
		<div class="area-100 center">
			<div class="row center" style="background-color: rgb(239,239,239)">
				<c:choose>
					<c:when test="${writeauth=='관리자'}">
						<h1>공지사항</h1>
					</c:when>
					<c:otherwise>
						<h1>나의 상품문의</h1>
					</c:otherwise>
				</c:choose>
			</div>
			<form action="bwrite" method="post" name="form" enctype="multipart/form-data">
				<input type="hidden" name="auth" value="${auth}">
				<input type="hidden" name="gno" value="${bdto.gno}">
				<input type="hidden" name="gseq" value="${bdto.gseq}">
				<input type="hidden" name="depth" value="${bdto.depth}">
				<c:choose>
					<c:when test="${auth=='일반'}">
						<input type="hidden" name="authck" value="f">
					</c:when>
					<c:otherwise>
						<input type="hidden" name="authck" value="t">
					</c:otherwise>
				</c:choose>
				<div class="row center">
					<table class="user-table area-80">
						<c:choose>
							<c:when test="${auth!='관리자'}">
								<tr>
									<th scope="row" class="title">질문유형</th>
									<td>
										<select name="category" class="select_box area-30" required>
											<option value="">선택하세요</option>
											<option>배송지연/불만</option>
											<option>반품문의</option>
											<option>환불문의</option>
											<option>교환/취소문의</option>
											<option>상품정보문의</option>
											<option>기타문의</option>
										</select>
									</td>
								</tr>
							</c:when>
						</c:choose>
						<tr>
							<th scope="row" class="title">아이디</th>
							<td>
								<input type="email" class="user-input area-60" name="email" value="${mdto.email}" readonly>
	<!-- 							<input type="email" class="user-input area-90" name="email" required> -->
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">이름</th>
							<td>
								<input type="text" class="user-input area-60" name="name" value="${mdto.name}" readonly>
	<!-- 							<input type="text" class="user-input area-90" name="name"> -->
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">이메일</th>
							<td>
								<input type="email" class="user-input area-60" name="email" value="${mdto.email}" readonly>
	<!-- 							<input type="email" class="user-input area-90" name="email"> -->
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">제목</th>
							<td>
								<input type="text" class="user-input area-60" name="title" id="title"
										placeholder="제목" onkeydown="titleinput();" onkeyup="titleinput();"  required>
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">내용</th>
							<td>
								<textarea rows="10" cols="30" name="detail" id="content"
											onkeydown="input();" onkeyup="input();" class="user-area"></textarea>
											<script>
												CKEDITOR.replace('content');
											</script><br>
								<div id="limit"></div>
							</td>
						</tr>
						<tr>
							<th scope="row" class="title">파일 첨부</th>
							<td class="addFile">
								<input type="file" name="file" id="file" accept="image/gif, image/jpeg, image/png">
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
				<div class="btn_area">
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