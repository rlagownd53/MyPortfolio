<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file= "/WEB-INF/view/template/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">

<div class="page">
	<div class="empty-row"></div>
	<div class="area-100 center line-black">
		<div class="row center line-red">
			<table class="info-table area-70" border="1">
				<tr>
					<th class="title">아이디</th>
					<td>${bdto.email}</td>			
				</tr>
				<tr>
					<th class="title">이름</th>
					<td>${bdto.name}</td>			
				</tr>
				<tr>
					<th class="title">질문유형/제목</th>
					<td>
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
					<th class="title">이메일</th>
					<td>${bdto.email}</td>			
				</tr>
				<tr>
					<th class="title">문의내용</th>
					<td class="detail">${bdto.detail2}</td>			
				</tr>
				<tr>
					<th class="title">작성일</th>
					<td>${bdto.auto}</td>			
				</tr>
			</table>
		</div>
		<div class="btn_area area-70 center">
			<span class="left">
				<input type="button" class="input-btn" value="목록" onclick="location.href='blist';">
			</span>
			<input type="button" class="input-btn" value="수정" onclick="pw?next=edit">
			<input type="button" class="input-btn" value="삭제" onclick="pw?no=${bdto.no}&next=delete">
		</div>
	</div>
</div>


<%@ include file= "/WEB-INF/view/template/footer.jsp" %>