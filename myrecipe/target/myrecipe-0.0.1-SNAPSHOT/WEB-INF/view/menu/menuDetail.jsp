<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>디자인</title>
<style>
	div {
		border: 1px;
		border-color: darkgreen;
		border-style: solid;
	}
	.c {
		margin: 20px;
		width: auto;
		height: auto;
		background-color: darkgrey;
		display: inline-block;
	}
</style>

</head>
<body>
	<div align="center">
		<h1>상품 상세정보</h1>
	</div>
	<div class="item_body">
		<div align="center">
			<div class="c" width="500">
				메뉴 이미지 <br> <img height="250" width="250">
			</div>
			<div class="c" align="left">
				<form id="menuAdd" action="menuAdd" method="POST">
					메뉴 상세 정보<br> 
					<label>메뉴 명 : </label> 		<input type="text"name="name" value="${mdto.name}"> 
					<br> 
					<label>메뉴 종류 : </label>		<input type="text"name="type" value="${mdto.type}"> 
					<br> 
					<label>가격 : </label> 		<input type="number" name="price" value="${mdto.price}"> 
					<br> 
					<label>옵션1 :</label> 		<input type="text" name="op1" placeholder="" value="없음"> 
					<br> 
					<label>옵션1 가격 : </label>	<input type="number" name="op1_price" placeholder="" value="0"> 
					<br>
					<label>옵션2 : </label> 		<input type="text" name="op2" placeholder="" value="없음"> 
					<br>
					<label>옵션2 가격 : </label> 	<input type="number" name="op2_price" placeholder="" value="0">
					<br> 
					<label>옵션3 : </label> 		<input type="text" name="op3" placeholder="" value="없음">
					<br> 
					<label>옵션3 가격 : </label> 	<input type="number" name="op3_price" placeholder="" value="0"> 
					<br> 
					<label>상태 : </label> 		
					<input type="radio" name="stat" value="sell" checked="checked">판매중 
					<input type="radio" name="stat" value="soldout">판매중지
					<br><br>
					<input type="hidden" name="stat_grade" value="일반">
					<div align="center">
						<input type="submit" value="등록"> 
						<a href="menuList">
						<input type="button" value="취소"></a>
					</div>

				</form>
			</div>
		</div>

		<br>
		<br>

		<div>
			재료 : <br> 마늘, 간장, 고추장, 고기, 설탕 등
		</div>

		<br>
		<br>

		<div>레시피</div>
		
	</div>

</body>
</html>