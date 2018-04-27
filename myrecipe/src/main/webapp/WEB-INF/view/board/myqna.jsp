<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "/WEB-INF/view/template/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/js/jquery.tablesorter/jquery.tablesorter.js"></script>
<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script src ="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
    .table > thead > tr > th {
		text-align: center;	
	}
	.title {
		text-align: center;	
	}
</style>

<div class="container" style="margin-top: 90px;">
	<div class="row text-center" style="margin-bottom: 100px;">
 		<h1>내 문의 목록</h1>
 	</div>
    <div class="row">
        <table class="table">
            <thead>
                <tr>
                    <th id="no">번호</th>
                    <th id="title">제목</th>
                    <th id="reg">작성일</th>
                    <th id="reply">답변</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="list" items="${list}">
                	<tr>
	                    <td class="title">${list.no}</td>
	                    <td>
	                    	<c:choose>
	                    		<c:when test="${list.authck=='f'}">
	                    			<a href="binfo?no=${list.no}&auth=일반">${list.title2}</a>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<a href="binfo?no=${list.no}&auth=관리자">${list.title2}</a>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	<c:if test="${not empty list.filename}">
	                    		<img src="<c:url value="/image/board_file.jpg"/>" width="20" height="20">
	                    	</c:if>
	                    </td>
	                    <td class="title">${list.reg}</td>
	                    <td class="title">
	                    	<c:choose>
	                    		<c:when test="${list.replyck=='y'}">
	                    			<small>답변 완료</small>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<small>답변 대기중</small>
	                    		</c:otherwise>
	                    	</c:choose>
	                    </td>
                	</tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="row text-center">
	   	<nav>
	        <ul class="pagination">
	            <li>
	                <c:if test="${startBlock>1}">
	                    <a href="myqna?page=${startBlock-1}" aria-label="Previous">
	                        <span aria-hidden="true">&laquo;</span>
	                    </a>
	                </c:if>
	            </li>
	            <c:forEach var="i" begin="${startBlock}" end="${endBlock}" step="1">
	                <c:choose>
	                    <c:when test="${i == pageNo}">
	                        <li><a href="#">${i}</a></li>
	                    </c:when>
	                    <c:otherwise>
	                        <li><a href="myqna?page=${i}">${i}</a></li>
	                    </c:otherwise>
	                </c:choose>
	            </c:forEach>
	            <c:if test="${endBlock < blockTotal}">   
	                <li>
	                    <a href="myqna?page=${endBlock+1}" aria-label="Next">
	                        <span aria-hidden="true">&raquo;</span>
	                    </a>	
	                </li>
	             </c:if>
	        </ul>
		</nav>
	</div>
   


			




<%@ include file = "/WEB-INF/view/template/footer.jsp" %>