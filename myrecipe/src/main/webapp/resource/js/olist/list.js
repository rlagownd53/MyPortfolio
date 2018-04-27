$(document).ready(function() {
$("#new").click(function(){
	var text = $(this).text();
	if(text==="전체 선택"){
		$(this).text("전체 해제");
		$("input:checkbox[id=newcheck]").attr("checked",true);
		$("#choice1").children(".ch1").children().css('background-color', 'lightgrey');
	}else{
		$("input:checkbox[id='newcheck']").attr("checked",false);
		$(this).text("전체 선택");
		$("#choice1").children(".ch1").children().css('background-color', 'white');
	}	
});	
$("#shipping").click(function(){
	var text = $(this).text();
	if(text==="전체 선택"){
		$("input:checkbox[id=newcheck2]").attr("checked",true);
		$(this).text("전체 해제");
		$("#choice2").children(".ch2").children().css('background-color', 'lightgrey');
	}else{
		$("input:checkbox[id=newcheck2]").attr("checked",false);
		$(this).text("전체 선택");
		$("#choice2").children(".ch2").children().css('background-color', 'white');
	}	
});	
$("input:checkbox").click(function(){
	$(this).prev("td").nextAll("td").css('background-color', 'lightgrey');
});
})