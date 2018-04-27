<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<script src="${pageContext.request.contextPath}/js/passwordcheck.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/login.css">
<div class="container" style="margin-top: 120px">
	<section class="container2">
		<article class="half">
			<h1>My Cooking</h1>
			<div class="tabs">
				<span class="tab signin active"><a href="#Lognin">로그인</a></span> <span
					class="tab signup"><a href="#signup">회원 가입</a></span>
			</div>
			<div class="content">
				<div class="signin-cont cont">
					<form action="login?${_csrf.parameterName}=${_csrf.token}" method="post">
						<input type="email" name="email"
							id="email" class="inpt" required="required"
							placeholder="Your email"> <label for="email"></label> <input
							type="password" name="password" id="password" class="inpt"
							required="required" placeholder="Your password"> <label
							for="password"></label> 
							<input type="checkbox" name="remember"
							id="remember" class="checkbox" value="remember"> <label for="remember">Remember
							me</label>
						<div class="submit-wrap">
							<input type="submit" value="Logn in" class="submit"> <a
								id="passwordfind" href="#" class="more">비밀번호 찾기</a>
						</div>
					</form>
				</div>
				<div class="signup-cont cont">
					<form action="signcheck" method="get">
						<input type="email" name="email" id="name" class="inpt"
							required="required" placeholder="Your email?"> <input
							type="text" name="myname" id="name" class="inpt"
							required="required" placeholder="Your name?">
						<div class="submit-wrap">
							<input type="submit" value="Sign up" class="submit">
							 <a href="tac" class="more">이용 약관</a>
						</div>
					</form>
				</div>
			</div>
		</article>
		<div class="half bg"></div>
	</section>
</div>
<script>
		$('.tabs .tab').click(function() {
			if ($(this).hasClass('signin')) {
				$('.tabs .tab').removeClass('active');
				$(this).addClass('active');
				$('.cont').hide();
				$('.signin-cont').show();
			}
			if ($(this).hasClass('signup')) {
				$('.tabs .tab').removeClass('active');
				$(this).addClass('active');
				$('.cont').hide();
				$('.signup-cont').show();
			}
		});
		$('.container .bg').mousemove(
				function(e) {
					var amountMovedX = (e.pageX * -1 / 30);
					var amountMovedY = (e.pageY * -1 / 9);
					$(this).css('background-position',
							amountMovedX + 'px ' + amountMovedY + 'px');
				});
	</script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
		$(document).ready(function(){
			var error = $(location).attr("search").slice($(location).attr("search").indexOf("=")+1);
			if(error=="loginfalse"){
				swal("로그인 실패","이메일 혹은 비밀번호를 확인해 주세요.");
			}else if(error=="signfalse"){
				swal("중복 확인 결과","중복된 이메일이  확인 되었습니다.");
			}
		});
	</script>
<script>
	$("#passwordfind").click(function(){
		var email = prompt('이메일을 입력하세요', '이메일 입력칸');
		var data = {"email":email};
		console.log(data);
		$.ajax({
			url : "${pageContext.request.contextPath}/passwordfind",
			type : "get",
			data : data,
			async : false,
			sussess : function(result) {
				if(!result){
					swal("이메일 인증 실패","이메일을 확인해 주세요.");
				}else if(result){
					swal("이메일 발송 완료","이메일이 전송 되었습니다.");
				}},
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
			}); });
</script>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>