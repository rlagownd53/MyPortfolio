<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.*" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<script src="${pageContext.request.contextPath}/js/app.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<title>Insert title here</title>
</head>
<body>
	<section class="main">
		<section class="screen">
			<div class="problem_wrap">
			</div>
			<aside class="result">
			</aside>
		</section>
		<footer>
			<input type="button" value="제출" onclick="send()">
		</footer>
	</section>
</body>

<script>
	$(function(){
		var foo = new Array();
		var s;
		$.ajax({
			url: "${pageContext.request.contextPath}/DB/database.json",
			dataType: "json",
			success:function(result) {
				$.each(result, function(index,list){
					console.log(list["problem_text"]);
					$(".problem_wrap").append("<div class='problem"+index+"' style='margin: 30 0;'>");
					$('.problem'+index).append(index+1+". ");
					$('.problem'+index).append(list["problem_text"]+"<br>");
					$('.problem'+index).append("<div class='answer"+index+"'>");
					//$('.answer'+index).append(list["choices"]+"<br>");
				 	if(list["choices"]!=null) {
						s = list["choices"].substring(1,list["choices"].length-1);
						foo = s.split(',');
						for(i=0; i<foo.length; i++) {
							$('.answer'+index).append(
									"<input type='radio' name='problem"+index+"' value='"+i+"'>"+foo[i]+"&nbsp;&nbsp;");						
						}
					}else {
						console.log("1");
						$('.answer'+index).append(
								"<input type='text' name='problem"+index+"'>");
					}
				});
			}
		});
	});
	function send() {
		alert($(".problem1").val());
	}
</script>
</html>	