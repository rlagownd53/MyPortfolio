<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file= "/WEB-INF/view/template/header.jsp" %>

<script src ="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

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
	
	function replydel(no, writer, auth) {
		swal({
			  text: "댓글을 삭제하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete)=>{
			  if (willDelete) {
				  swal({
						text: "삭제되었습니다.",
						showCancelButton: true,
						confirmButtonColor : '#3085d6',
					}).then(function(){
						location.href="replydelete?no="+no+"&writer="+writer+"&auth="+auth;
					});
			  } else {
				  swal({
	 					text: "취소되었습니다.",
	 					showCancelButton: true,
	 					confirmButtonColor : '#3085d6',
	 				}).then(function(){
	 					return;
						location.href="binfo?no="+no+"&auth="+auth;
	 				})
			  }
		});
	}
	
	function replycheck(no, filename, name, reply, auth) {
		swal({
			text: "정말 게시글을 삭제하시겠습니까?",
			icon: "warning",
			buttons : true
		}).then((willDelete)=>{
			  if (willDelete) {
				if(reply>0 && auth !='관리자') {
					  swal("댓글이 달려있는 글은 삭제 할 수 없습니다.");
					  return;
				} else {
					  swal({
							text: "삭제되었습니다.",
							showCancelButton: true,
							confirmButtonColor : '#3085d6',
						}).then(function(){
							location.href="bdelete?no="+no+"&filename="+filename+"&name="+name+"&reply="+reply;
						});
				}
			  } else {
				  swal({
	 					text: "취소되었습니다.",
	 					showCancelButton: true,
	 					confirmButtonColor : '#3085d6',
	 				}).then(function(){
	 					return;
						location.href="binfo?no="+no+"&auth="+auth;
	 				})
			  }
		});
	}
	
</script>

<style>
	/* info 페이지 테이블 */
	.info-table{
	    border-collapse: collapse;
	    margin: 40px auto;
	    border-left: 0;
	    border-right: 0;
	    width : 80%;
	}
	
	.info-table .title {
		width:25%;
	    text-align: center;
	}
	
	.info-table .detail {
		margin:0;
/* 		width: -webkit-fill-available; */
		height: 250px;
	    vertical-align: top;
/* 	    border: 0; */
	}
	
	.info-table tr td {
		width: 100%;
	}
	
	.info-table th, .info-table td{
	    font-size: 20px;
	    padding: 20px;
	}
	/* 게시판 각 페이지의 버튼이 설정된 div 속성 */
	.btn_area {
	    margin: 20px 0px 70px 10px;
	    text-align: right;
	    width: 75%;
	}
	
	.left {
	    float: left;
	    margin-left : 0px;
	}
	
	.input-btn {
		width: 60px;
		height: 50px;
		display: inline-block;
	    padding: 5px;
	    border-radius: 3px;
	    border: 1px solid #ddd;
	    color: graytext;
	    text-decoration: none;
	    line-height: normal;
	}
	.empty{
		display: block;
	    width:100%;
	    height:50px;
    }
</style>


<div class="container" style="margin-top: 90px;">
	<div class="page">
		<div class="empty"></div>
		<div class="center">
			<div class="row" style="background-color: rgb(239,239,239); width: 96%;" align="center">
				<c:choose>
					<c:when test="${bdto.authck=='t'}">
						<h1>공지사항</h1>
					</c:when>
					<c:otherwise>
						<h1>QnA</h1>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="row center">
				<table class="info-table" border="1">
					<tr>
						<th scope="row" class="title">아이디</th>
						<td>
							${bdto.email}
						</td>			
					</tr>
					<tr>
						<th scope="row" class="title">이름</th>
						<td>${bdto.name}</td>			
					</tr>
					<tr>
						<th scope="row" class="title">질문유형/제목</th>
						<td style="word-break: break-all;">
							<c:choose>
								<c:when test="${empty bdto.category}">
									${bdto.title}
								</c:when>
								<c:otherwise>
									[${bdto.category}] ${bdto.title}
								</c:otherwise>
							</c:choose>
						</td>			
					</tr>
					<tr>
						<th scope="row" class="title">이메일</th>
						<td>${bdto.email}</td>			
					</tr>
					<tr>
						<th scope="row" class="title">문의내용</th>
						<td class="detail">${bdto.detail2}</td>			
					</tr>
					<tr>
						<th scope="row" class="title">업로드 파일</th>
						<c:choose>
							<c:when test="${empty bdto.filename}">
								<td>업로드 된 파일 없음</td>
							</c:when>
							<c:otherwise>
								<td id="prev">
									<img src = "<c:url value="/file/${bdto.name}/${bdto.filename}"/>" width ="50" height="50" 
											class="pic" style="vertical-align: middle;">
									<a href="download/${bdto.filename}?name=${bdto.name}">${bdto.filename}</a> (${bdto.filesize} byte)
								</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th scope="row" class="title" id="reply">댓글</th>
						<td style="word-break: break-all;">
							<c:forEach var="rdto" items="${rdto}">
								<p style="display: inline;">${rdto.writer}</p> &nbsp;&nbsp;
								<small>${rdto.reg}</small>
								<c:choose>
									<c:when test="${auth=='관리자' or rdto.writer==bdto.email}">
										<img src="<c:url value="/image/x.jpg"/>" align="right" width="20" height="20"
												onclick="replydel('${rdto.no}','${rdto.writer}','${auth}');">
									</c:when>
								</c:choose>
								<br><br>
								<small>${rdto.detail}</small>
								<hr>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th colspan="2">
							<form action="replywrite" method="post">
								<sec:csrfInput/>
								<input type="hidden" name="writer" value="${cookie.memberEmail.value}">
								<input type="hidden" name="context" value="${bdto.no}">
								<input type="hidden" name="auth" value="${auth}">
								<input type="hidden" name="next" value="${next}">
								<textarea rows="4" cols="100" name="detail" placeholder="댓글을 입력하세요" 
										style="margin-top: 5px; vertical-align: middle; resize: none; width: 90%; height:auto;"></textarea>
								<input type="submit" class="btn btn-primary" value="작성">
							</form>
						</th>
					</tr>
					<tr>
						<th class="title">작성일</th>
						<td>${bdto.auto}</td>			
					</tr>
	 			</table>
			</div>
			<div class="btn_area" style="margin-left: 160px;">
				<span class="left">
					<input type="button" class="input-btn" value="목록" onclick="location.href='blist#q2';">
					<c:choose>
						<c:when test="${auth=='관리자'}">
							<input type="button" class="input-btn" value="답글" 
								onclick="location.href='bwrite?gno=${bdto.gno}&gseq=${bdto.gseq}&depth=${bdto.depth}';">
						</c:when>
					</c:choose>
				</span>
				<c:if test="${ckValue == bdto.email}">
					<input type="button" class="input-btn" value="수정" onclick="location.href='bedit?no=${bdto.no}&auth=${auth}';">
				</c:if>
				<c:if test="${ckValue==bdto.email or auth=='관리자'}">
					<input type="button" class="input-btn" value="삭제"
										onclick="replycheck('${bdto.no}','${bdto.filename}','${bdto.name}','${bdto.reply}','${auth}');">
				</c:if>
			</div>
		</div>
	</div>
	<div class="empty"></div>

<%@ include file= "/WEB-INF/view/template/footer.jsp" %>