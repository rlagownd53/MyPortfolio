<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("input[type='file']").on('change', function(){
	        readURL(this);
	    });
	});
	
	function readURL(input) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
	    reader.onload = function (e) {
	    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
// 	    		alert(input.name);
			    var tar = input.name;
		    	if(tar == 'mainimg'){
		    		$("#mainimg").attr('src', e.target.result);
		    	}else if(tar == 'foodimg'){
		    		$("#foodimg").attr('src', e.target.result);
		    	}else if(tar == 'recipeimg'){
		    		$("#recipeimg").attr('src', e.target.result);
		    	}
	        }
		reader.readAsDataURL(input.files[0]);
	    }
	}
	
</script>

<style>
	input #menuinput{width: "120px";}
</style>

<div class="container" style="margin-top: 80px;">
	<div style="min-height: 600px;">
		<div align="center">
			<h1>상품 수정 화면</h1>
		</div>
		<div align="center" style="margin: auto;">
			<form id="mupdate" action="mupdate" method="POST" enctype="multipart/form-data">
				<div class="col-md-10" style="float: unset; display: flex;">
					<div class="col-md-4 center-block">
						<p>메인 이미지</p>
						<c:forEach var="mfdto" items="${mfdto}">
							<c:if test="${mfdto.imgtype == 'mainimg'}">
								<img id="mainimg" src="${pageContext.request.contextPath}/menuimg/${mdto.name}/${mfdto.filename}" height="150" width="150">
							</c:if>
						</c:forEach>
						<p><input type="file" id="imgInp" name="mainimg"></p>
					</div>
					<div class="col-md-4 center-block">
						<p>재료 이미지</p>
						<c:forEach var="mfdto" items="${mfdto}">
							<c:if test="${mfdto.imgtype == 'foodimg'}">
								<img id="foodimg" src="${pageContext.request.contextPath}/menuimg/${mdto.name}/${mfdto.filename}" height="150" width="150">
							</c:if>
						</c:forEach>
						<p><input type="file" id="imgInp" name="foodimg"></p>
					</div>
					<div class="col-md-4 center-block">
						<p>레시피 이미지</p>
						<c:forEach var="mfdto" items="${mfdto}">
							<c:if test="${mfdto.imgtype == 'recipeimg'}">
								<img id="recipeimg" src="${pageContext.request.contextPath}/menuimg/${mdto.name}/${mfdto.filename}" height="150" width="150">
							</c:if>
						</c:forEach>
						<p><input type="file" id="imgInp" name="recipeimg"></p>
					</div>
				</div>
				
				<div class="col-md-6 center-block" style="float: unset;">
					메뉴 상세 정보<br>
					 <table class="table table-striped table-hover">
						<tbody>
							<tr>
								<th>메뉴 명 :</th>
								<th><input type="text" name="name" value="${mdto.name}"></th>
							</tr>
							<tr>
								<th>메뉴 종류 :</th>
								<th>
								<select name="type" >
									<option value="${mdto.type}">${mdto.type}(저장값)</option>
							        <option value="밥">밥</option>
							        <option value="국">국</option>
							        <option value="찌개">찌개</option>
							    </select>
								</th>
							</tr>
							<tr>
								<th>가격 :</th>
								<th><input type="number" name="price" value="${mdto.price}"></th>
							</tr>
							<tr>
								<th>옵션1 :</th>
								<th><input type="text" name="op1_name" placeholder="고기 추가" value="${mdto.op1_name}"></th>
							</tr>
							<tr>
								<th>옵션1 가격 :</th>
								<th><input type="number" name="op1_price" value="${mdto.op1_price}"></th>
							</tr>
							<tr>
								<th>옵션2 :</th>
								<th><input type="text" name="op2_name" placeholder="야채 추가" value="${mdto.op2_name}"></th>
							</tr>
							<tr>
								<th>옵션2 가격 :</th>
								<th><input type="number" name="op2_price" value="${mdto.op2_price}"></th>
							</tr>
							<tr>
								<th>옵션3 :</th>
								<th><input type="text" name="op3_name" placeholder="양념 추가" value="${mdto.op3_name}"></th>
							</tr>
							<tr>
								<th>옵션3 가격 :</th>
								<th><input type="number" name="op3_price" value="${mdto.op3_price}"></th>
							</tr>
							<tr>
								<th>상태 :</th>
								<th>
								<input type="radio" name="stat" value="판매중" checked="checked">판매중 
								<input type="radio" name="stat" value="판매중지">판매중지
								</th>
							</tr>
							<tr>
								<th>상품 등급 :</th>
								<th>
								<select name="stat_grade">
									<option value="${mdto.stat_grade}">${mdto.stat_grade} 상품(저장값)</option>
							        <option value="일반">일반 상품</option>
							        <option value="인기">인기 상품</option>
							        <option value="베스트">베스트 상품</option>
							    </select>
								</th>
							</tr>
						</tbody>
					</table>
					<br> <input type="hidden" name="no" value="${mdto.menu_no}">
					<div align="center">
						<input type="submit" value="수정하기">
						<input type="button" value="취소" onclick="location.href='mmodi'">
					</div>
				</div>
				
			</form>
		</div>
	</div>


<%@ include file="/WEB-INF/view/template/footer.jsp"%>