<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
    
	<!-- Carousel
    ================================================== -->
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner" role="listbox">
			<div class="item active">
				<img class="first-slide"
					src="${pageContext.request.contextPath}/image/main/4.png"
					alt="First slide">
				<div class="container">
					<div class="carousel-caption">
						<h1>남는 요리재료 걱정 마세요</h1>
						<p>
							정량화된 요리재료를 가지고 만드니 남을 걱정이 없습니다.
						</p>
						<p>
							<a class="btn btn-lg btn-primary" href="mlist" role="button">주문하러가기</a>
						</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img class="second-slide"
					src="${pageContext.request.contextPath}/image/main/2.jpg"
					alt="Second slide">
				<div class="container">
					<div class="carousel-caption">
						<h1>이제 직접 만들어서 드세요.</h1>
						<p>간단한 레시피를 통해 직접 만들어서 드실수 있습니다.</p>
						<p>
							<a class="btn btn-lg btn-primary" href="mlist" role="button">주문하러가기</a>
						</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img class="third-slide"
					src="${pageContext.request.contextPath}/image/main/3.jpg"
					alt="Third slide">
				<div class="container">
					<div class="carousel-caption">
						<h1>풍성한 식사.</h1>
						<p>여러가지 요리를 직접 조리해 맛있는 식사를 하실수 있습니다.</p>
						<p>
							<a class="btn btn-lg btn-primary" href="mlist" role="button">주문하러가기</a>
						</p>
					</div>
				</div>
			</div>
		</div>
		<a class="left carousel-control" href="#myCarousel" role="button"
			data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#myCarousel" role="button"
			data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
	<!-- /.carousel -->


	<!-- Marketing messaging and featurettes
    ================================================== -->
	<!-- Wrap the rest of the page in another container to center all the content. -->

	<div class="container marketing">
		<!-- START THE FEATURETTES -->
		<hr class="featurette-divider">

		<div class="row featurette">
			<div class="col-md-7">
				<h2 class="featurette-heading">
					맛있는 요리를<br>
					<span class="text-muted">직접 조리할수 있습니다.</span>
				</h2>
				<p class="lead">
				간편 레시피를 보고 직접 조리하세요.<br>
				레시피를 보고 즐거운 요리로 행복한 저녁식사를 가능하게 합니다.
				</p>
			</div>
			<div class="col-md-5">
				<img class="featurette-image img-responsive center-block"
					src="${pageContext.request.contextPath}/image/main/main2/5.jpg" alt="Generic placeholder image">
			</div>
		</div>

		<hr class="featurette-divider">

		<div class="row featurette">
			<div class="col-md-7 col-md-push-5">
				<h2 class="featurette-heading">
					남는 식재료 걱정<span class="text-muted"><br>
					이제는 걱정하지 마세요!</span>
				</h2>
				<p class="lead">정량에 맞춘 요리재료로
					남는 식재료로 인한 걱정을 덜어드립니다.
				</p>
			</div>
			<div class="col-md-5 col-md-pull-7">
				<img class="featurette-image img-responsive center-block"
					src="${pageContext.request.contextPath}/image/main/main2/7.jpg" alt="Generic placeholder image">
			</div>
		</div>

		<hr class="featurette-divider">

		<div class="row featurette">
			<div class="col-md-7">
				<h2 class="featurette-heading">
					신선한 재료<span class="text-muted"><br>
					특별한 저녁을 맞이하세요.</span>
				</h2>
				<p class="lead">엄선된 재료로 풍성하고 맛있는 식사를 가능하게 해드립니다.</p>
			</div>
			<div class="col-md-5">
				<img class="featurette-image img-responsive center-block"
					src="${pageContext.request.contextPath}/image/main/main2/6.jpg" alt="Generic placeholder image">
			</div>
		</div>

		<hr class="featurette-divider">

		<!-- /END THE FEATURETTES -->
<%@ include file="/WEB-INF/view/template/footer.jsp"%>