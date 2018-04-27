<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>

<script type="text/javascript">
	$(function() {
		//첫번째 텝을 제외하고 나머지 텝들은 숨김
		$(".tab_content").hide();
		$(".tab_content:first").show();
		
		//텝 클릭 시 메뉴 리스트 변경
		$("ul.menutabs li").click(function() {
			$("ul.menutabs li").removeClass("active").css("color", "#333");
			//$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
			$(this).addClass("active").css("color", "blue");
			$(".tab_content").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});
		
		//마우스 리스너(텝에 마우스온 : 빨강 / 마우스리브 : 검정)
		$("ul.menutabs li").mouseenter(function() {
			$(this).addClass("textcolor").css("color", "red");
			$(this).mouseleave(function() {
				$("ul.menutabs li").removeClass("textcolor").css("color", "black");
				$(".active").css("color", "blue");
			});
		});
	});
</script>
<script type="text/javascript">
	$(function() {
		var tab1_co = $("#tab1 #menu").length;
		var tab1_text = $("ul > li[rel='tab1']").text();
		$("ul > li[rel='tab1']").text(tab1_text+' ('+tab1_co+')');
		
		var tab2_co = $("#tab2 #menu").length;
		var tab2_text = $("ul > li[rel='tab2']").text();
		$("ul > li[rel='tab2']").text(tab2_text+' ('+tab2_co+')');
		
		var tab3_co = $("#tab3 #menu").length;
		var tab3_text = $("ul > li[rel='tab3']").text();
		$("ul > li[rel='tab3']").text(tab3_text+' ('+tab3_co+')');
		
		var tab4_co = $("#tab4 #menu").length;
		var tab4_text = $("ul > li[rel='tab4']").text();
		$("ul > li[rel='tab4']").text(tab4_text+' ('+tab4_co+')');
		
		var tab5_co = $("#tab5 #menu").length;
		var tab5_text = $("ul > li[rel='tab5']").text();
		$("ul > li[rel='tab5']").text(tab5_text+' ('+tab5_co+')');
		
		$(".active").css("color", "blue");
	});
</script>
<style>
	.menu_menubar{
		height : 30px;
	}
	.menu_menubar ul li {
 		margin-right: 10px;
		list-style: none;
		color: black;
		background-color: #e7e7e7;
		line-height: 30px; 
		vertical-align: middle; 
		text-align: center;
		font-size: 16px;
		border-radius: 1em;
		box-shadow: 3px 3px;
		justify-content: space-between;
	}
</style>
<div class="container" align="center" style="margin-top:5%">
	<div class="container">
	<br>
	<h1><span>Menu List !</span></h1>
		<div id="container" class="menu_menubar" align="center">
			<ul class="menutabs col-md-12 list-inline"> 
				<li rel="tab1" value="" class="active col-md-2" style="margin-left:50px;">전체 메뉴</li>
				<li rel="tab2" value="추천" class="col-md-2">추천 메뉴</li>
				<li rel="tab3" value="밥" class="col-md-2">밥</li>
				<li rel="tab4" value="국" class="col-md-2"><strong>국</strong></li>
				<li rel="tab5" value="찌개" class="col-md-2"><strong>찌개</strong></li>
			</ul>
		</div>
		<hr>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<div class="tab_category">
					<c:forEach var="mdto" items="${mdto}">
					<c:if test="${mdto.stat=='판매중'}">
						<c:forEach var="mfdto" items="${mfdto}">
						<c:if test="${mfdto.menu_no==mdto.menu_no && mfdto.imgtype=='mainimg'}">
							<div class="center width-30 in_block col-md-4 text-center">
								<div id="menu" class="line-black center margin-10 width-200p height-250p">
									<a href="order?no=${mdto.menu_no}"> 
									<img src="${pageContext.request.contextPath}/menuimg/${mdto.name}/${mfdto.filename}" width="200" height="150">
									<h6>
										<c:if test="${mdto.stock == 0}">(품절)</c:if>
										<c:choose>
											<c:when test="${mdto.stat_grade=='일반'}">`
											</c:when>
											<c:otherwise>(${mdto.stat_grade} 상품)
											</c:otherwise>
										</c:choose>
									</h6>
									<h4><label>${mdto.name}</label></h4>
									<h4><label>${mdto.price} 원</label></h4>
									</a>
								</div>
							</div>
						</c:if>
						</c:forEach>
					</c:if>
					</c:forEach>
				</div>
			</div>
			<div id="tab2" class="tab_content">
				<div class="tab_category">
					<c:forEach var="mdto" items="${mdto}">
						<c:set var="type" value="${mdto.stat_grade}"></c:set>
						<c:if test="${type=='인기' or type=='베스트'}">
							<c:forEach var="mfdto" items="${mfdto}">
							<c:if test="${mfdto.menu_no==mdto.menu_no && mfdto.imgtype=='mainimg'}">
								<div class="center width-30 in_block col-md-4 text-center">
									<div id="menu" class="line-red center margin-10 width-200p height-250p">
										<a href="order?no=${mdto.menu_no}"> 
										<img src="${pageContext.request.contextPath}/menuimg/${mdto.name}/${mfdto.filename}" width="200" height="150">
										<h6>
											<c:if test="${mdto.stock == 0}">(품절)</c:if>
											<c:choose>
												<c:when test="${mdto.stat_grade=='일반'}">`
												</c:when>
												<c:otherwise>(${mdto.stat_grade} 상품)
												</c:otherwise>
											</c:choose>
										</h6>
										<h4><label>${mdto.name}</label></h4>
										<h4><label>${mdto.price} 원</label></h4>
										</a>
									</div>
								</div>
							</c:if>
						</c:forEach>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div id="tab3" class="tab_content">
				<div class="tab_category">
					<c:forEach var="mdto" items="${mdto}">
						<c:set var="type" value="${mdto.type}"></c:set>
						<c:if test="${type=='밥'}">
							<c:forEach var="mfdto" items="${mfdto}">
							<c:if test="${mfdto.menu_no==mdto.menu_no && mfdto.imgtype=='mainimg'}">
								<div class="center width-30 in_block col-md-4 text-center">
									<div id="menu" class="line-red center margin-10 width-200p height-250p">
										<a href="order?no=${mdto.menu_no}"> 
										<img src="${pageContext.request.contextPath}/menuimg/${mdto.name}/${mfdto.filename}" width="200" height="150">
										<h6>
											<c:if test="${mdto.stock == 0}">(품절)</c:if>
											<c:choose>
												<c:when test="${mdto.stat_grade=='일반'}">`
												</c:when>
												<c:otherwise>(${mdto.stat_grade} 상품)
												</c:otherwise>
											</c:choose>
										</h6>
										<h4><label>${mdto.name}</label></h4>
										<h4><label>${mdto.price} 원</label></h4>
										</a>
									</div>
								</div>
							</c:if>
						</c:forEach>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div id="tab4" class="tab_content">
				<div class="tab_category">
					<c:forEach var="mdto" items="${mdto}">
						<c:set var="type" value="${mdto.type}"></c:set>
						<c:if test="${type=='국'}">
							<c:forEach var="mfdto" items="${mfdto}">
							<c:if test="${mfdto.menu_no==mdto.menu_no && mfdto.imgtype=='mainimg'}">
								<div class="center width-30 in_block col-md-4 text-center">
									<div id="menu" class="line-red center margin-10 width-200p height-250p">
										<a href="order?no=${mdto.menu_no}"> 
										<img src="${pageContext.request.contextPath}/menuimg/${mdto.name}/${mfdto.filename}" width="200" height="150">
										<h6>
											<c:if test="${mdto.stock == 0}">(품절)</c:if>
											<c:choose>
												<c:when test="${mdto.stat_grade=='일반'}">`
												</c:when>
												<c:otherwise>(${mdto.stat_grade} 상품)
												</c:otherwise>
											</c:choose>
										</h6>
										<h4><label>${mdto.name}</label></h4>
										<h4><label>${mdto.price} 원</label></h4>
										</a>
									</div>
								</div>
							</c:if>
						</c:forEach>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div id="tab5" class="tab_content">
				<div class="tab_category">
					<c:forEach var="mdto" items="${mdto}">
						<c:set var="type" value="${mdto.type}"></c:set>
						<c:if test="${type=='찌개'}">
							<c:forEach var="mfdto" items="${mfdto}">
								<c:if test="${mfdto.menu_no==mdto.menu_no && mfdto.imgtype=='mainimg'}">
									<div class="center width-30 in_block col-md-4 text-center">
										<div id="menu" class="line-red center margin-10 width-200p height-250p">
											<a href="order?no=${mdto.menu_no}"> 
											<img src="${pageContext.request.contextPath}/menuimg/${mdto.name}/${mfdto.filename}" width="200" height="150">
											<h6>
												<c:if test="${mdto.stock == 0}">(품절)</c:if>
												<c:choose>
													<c:when test="${mdto.stat_grade=='일반'}">`
													</c:when>
													<c:otherwise>(${mdto.stat_grade} 상품)
													</c:otherwise>
												</c:choose>
											</h6>
											<h4><label>${mdto.name}</label></h4>
											<h4><label>${mdto.price} 원</label></h4>
											</a>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
		
<hr>

<%@ include file= "/WEB-INF/view/template/footer.jsp" %>
