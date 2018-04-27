<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ include file = "/WEB-INF/view/template/header.jsp" %>



<div class="page">
	<div class="row center line-red">
		<form action="pw" method="post">
			<input type="hidden" name="next" value="${next}">
			<input type="password" class="user-input area-80" placeholder="비밀번호 입력">
			<input type="submit" class="input-btn" value="입력">
		</form>
	</div>
</div>


<%@ include file = "/WEB-INF/view/template/footer.jsp" %>