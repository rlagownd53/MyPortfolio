<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/view/admin/adminnav.jsp"%>

<style>
	#myTable{
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
		       <th>답변 여부</th>
		       <th>작성일</th>
		    </tr>
	    </thead>
		<tbody>
			<c:if test="${empty n}">
				<br>
				<h2>답변 완료 목록(${replycnt}건)</h2>
				<h4 id="reply"><a href="mnqlist" id="finish" 
					onclick="focus('finish');" style="float:right;">답글 대기 목록 보기</a></h4>
				<br>
			</c:if>
			<c:forEach var="bdto" items="${bdto}">
				<tr align="center">
					<td><a href="binfo?no=${bdto.no}&auth='관리자'">${bdto.no}</a></td>
					<td>${bdto.email}</td>
					<td>${bdto.name}</td>
					<td>답변 완료</td>
					<td>${bdto.reg}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<nav>
		<ul class="pagination">
		    <li>
		    	<c:if test="${startBlock>1}">
			    	<a href="mncomplete?page=${startBlock-1}#reply" aria-label="Previous">
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
					<li><a href="mncomplete?page=${i}#reply">${i}</a></li>
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

<!-- <div class="center"> -->
<!-- 	<div class="divarea"> -->
<!-- 		<div class="area-unit"> -->
<!-- 			<div class="unit table-responsive col-md-6"> -->
<!-- 				<table id="myTable" class="tablesorter"> -->
<!-- 					<thead> -->
<!-- 						<tr align="center"> -->
<!-- 					       <th id="no">게시글 번호</th> -->
<!-- 					       <th id="email">회원 아이디</th> -->
<!-- 					       <th id="name">회원 이름</th> -->
<!-- 					       <th id="reply">답변 여부</th> -->
<!-- 					       <th id="reg">작성일</th> -->
<!-- 					    </tr> -->
<!-- 				    </thead> -->
<!-- 					<tbody> -->
<%-- 						<c:if test="${empty n}"> --%>
<!-- 							<br> -->
<!-- 							<h5 id="reply"><a href="mnqlist" id="finish"  -->
<!-- 								onclick="focus('finish');" style="float:right;">답글 대기 목록 보기</a></h5> -->
<%-- 							<h4>답변 완료 목록(${replycnt}건)</h4> --%>
<%-- 						</c:if> --%>
<%-- <%-- 						<h3>답변 완료 목록(${replycnt}건)</h3> --%> 
<%-- 						<c:forEach var="bdto" items="${bdto}"> --%>
<!-- 							<tr align="center"> -->
<%-- 								<td><a href="binfo?no=${bdto.no}&auth='관리자'">${bdto.no}</a></td> --%>
<%-- 								<td>${bdto.email}</td> --%>
<%-- 								<td>${bdto.name}</td> --%>
<!-- 								<td>답변 완료</td> -->
<%-- 								<td>${bdto.reg}</td> --%>
<!-- 							</tr> -->
<%-- 						</c:forEach> --%>
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 				<div class="paging-wrap" align="center"> -->
<%-- 					<c:if test="${startBlock>1}"> --%>
<!-- 						<div class="paging-unit"> -->
<%-- 							<a href="${url}&page=${startBlock}#reply">&lt;</a> --%>
<!-- 						</div> -->
<%-- 					</c:if> --%>
<%-- 					<c:forEach var="i" begin="${startBlock}" end="${endBlock}" step="1"> --%>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${i == pageNo}"> --%>
<!-- 								<div class="paging-unit active"> -->
<%-- 									${i} --%>
<!-- 								</div>        			 -->
<%-- 			  				</c:when> --%>
<%-- 							<c:otherwise> --%>
<!-- 								<div class="paging-unit"> -->
<%-- 									<a href="mnqlist?page=${i}#reply">${i}</a> --%>
<!-- 								</div> -->
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<%-- 					</c:forEach> --%>

<%-- 					<c:if test="${endBlock < blockTotal}"> --%>
<!-- 						<div class="paging-unit"> -->
<%-- 							<a href="mnqlist?page=${endBlock+1}#reply">&gt;</a> --%>
<!-- 						</div> -->
<%-- 					</c:if> --%>
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div>	 -->
<!-- </div> -->
<script>
  $(document).ready(function() {
   $("#myTable").tablesorter( {
		sortList: [[0,1]],
		headers:{
		1:{sorter:"Integer"},
		debug:true
	   }}
	); 
})
</script>

