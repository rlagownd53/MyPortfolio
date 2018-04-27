<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/view/admin/adminnav.jsp"%>

<style>
 	#myTable { 
 		font-size: 20px;
 		padding: 10px;
 	} 
	nav {
		text-align: center;
	}
</style>

<div class="col-lg-9" style="padding-top: 90px">
	<table id="myTable" class="tablesorter">
		<thead>
			<tr>
		       <th>게시글 번호</th>
		       <th>회원 아이디</th>
		       <th>회원 이름</th>
		       <th>질문 유형</th>
		       <th>작성일</th>
		       <th>답변</th>
		    </tr>
	    </thead>
		<tbody>
			<c:if test="${not empty n}">
				<br>
				<h2>현재 답변 대기 목록(${replycnt}건)</h2>						
				<h4 id="reply"><a href="mncomplete" style="float: right;">답글 완료 목록 보기</a></h4>
				<br>
			</c:if>
			<c:forEach var="bdto" items="${bdto}">
				<tr align="center">
					<td>${bdto.no}</td>
					<td>${bdto.email}</td>
					<td>${bdto.name}</td>
					<td>${bdto.category}</td>
					<td>${bdto.date}</td>
					<td>
						<input type="button" value="답변" 
							onclick="location.href='binfo?no=${bdto.no}&auth=관리자'">								
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<nav>
		<ul class="pagination">
		    <li>
		    	<c:if test="${startBlock>1}">
			    	<a href="mnqlist?page=${startBlock-1}#reply" aria-label="Previous">
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
					<li><a href="mnqlist?page=${i}#reply">${i}</a></li>
				</c:otherwise>
			</c:choose>
		    </c:forEach>
		    <c:if test="${endBlock < blockTotal}">
			<li>
				<a href="mnqlist?page=${endBlock+1}#reply" aria-label="Next">
	    				<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		    </c:if>
		</ul>
	</nav>
</div>
