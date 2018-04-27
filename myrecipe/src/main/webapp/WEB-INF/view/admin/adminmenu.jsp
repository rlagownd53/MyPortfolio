<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/adminmenu.css">
	<%@ include file="/WEB-INF/view/admin/adminnav.jsp"%>
		<div class="col-lg-9" style="padding-top: 50px">
			<div class="divarea">
				<div class="area-unit">
					<div class="unit table-responsive col-xs-6">
						<h3>요약 정보</h3>
						<table class="table table-condensed table-bordered">
							<tr>
								<th>날짜</th>
								<td class="text-center">${orderlist.today}</td>
							</tr>
							<tr>
								<th>신규 주문</th>
								<td class="text-center">${orderlist.neworder}건</td>
							</tr>
							<tr>
								<th>미답변 문의</th>
								<td class="text-center">${noreply}건</td>
							</tr>
							<tr>
								<th>오늘 매출</th>
								<td class="text-center">${orderlist.tmoney}원</td>
							</tr>
							<tr>
								<th>이번달 매출</th>
								<td class="text-center">${orderlist.tmmoney}원</td>
							</tr>
							<tr>
								<th>저번달 매출</th>
								<td class="text-center">${orderlist.lmmoney}원</td>
							</tr>
						</table>
					</div>
					<div class="unit col-xs-6">
						<h3>신규 가입자 현황</h3>
						<div class="chart-container" style="position: relative; height:25vh; width:25vw">
							<canvas id="myChart"></canvas>
						</div>
					</div>
				</div>
				<div class="area-unit">
					<div class="unit col-xs-6">
						<h3>매출 현황</h3>
						<div class="chart-container" style="position: relative; height:25vh; width:25vw">
							<canvas id="myChart2"></canvas>
						</div>
					</div>
					<div class="unit col-xs-6">
						<h3>메뉴별 판매 현황</h3>
						<div class="chart-container" style="position: relative; height:25vh; width:25vw">
							<canvas id="myChart3"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	var ctx = document.getElementById('myChart').getContext('2d');
	var tojoin = ${memberdto.tojoin};
	var lastjoin = ${memberdto.lastjoin};
	var tolastjoin = ${memberdto.tolastjoin};
	ctx.canvas.width = 60;
	ctx.canvas.height = 50;
	var chart = new Chart(ctx, {
		// The type of chart we want to create
		type : 'line',

		// The data for our dataset
		data : {
			labels : ["7월", "8월", "9월",""],
			datasets : [ {
				label : "신규 가입자 현황",
				borderColor : 'rgb(255, 99, 132)',
				data : [tolastjoin, lastjoin, tojoin,10],
			} ]
		},
		// Configuration options go here
		options : {
			        elements: {
			            line: {
			                tension: 0, // disables bezier curves
			            }
			        }
		}
	});
</script>
	<script>
	var ctx = document.getElementById('myChart2').getContext('2d');
	ctx.canvas.width = 60;
	ctx.canvas.height = 50;
	var tmmoney = ${orderlist.tmmoney};
	var lmmoney = ${orderlist.lmmoney};
	var tolmmoney = ${orderlist.tolmmoney};
	var chart = new Chart(ctx, {
		// The type of chart we want to create
		type : 'bar',

		// The data for our dataset
		data : {
			labels : [ "7월", "8월", "9월" ],
			datasets : [ {
				label : "매출현황",
				backgroundColor: ['rgba(255, 99, 132,0.5)','rgba(255, 159, 64, 0.5)','rgba(255, 205, 86, 0.5)'],
				data : [ tolmmoney, lmmoney, tmmoney ],
			} ]
		},

		// Configuration options go here
		options : {}
	});
</script>
	<script>
	var ctx = document.getElementById('myChart3').getContext('2d');
	ctx.canvas.width = 60;
	ctx.canvas.height = 50;
	var myDoughnutChart = new Chart(ctx, {
	    type: 'doughnut',
	    data: {
	    	labels : [ "${menu[0].menu_name}:[${menu[0].menu_count}]", "${menu[1].menu_name}:[${menu[1].menu_count}]", "${menu[2].menu_name}:[${menu[2].menu_count}]" ],
			datasets : [ {
				data : [ ${menu[0].menu_count}, ${menu[1].menu_count}, ${menu[2].menu_count} ],
				backgroundColor: ['rgba(255, 0, 0,0.8)','rgba(0, 255, 0, 0.8)','rgba(0, 0, 255, 0.8)']
			} ]},
			options : {}
	});
</script>
