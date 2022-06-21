<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>ajax 테스트</h2>
	<ul id="replies">
	
	</ul>
	
	<!--  <ul id="test">
	
	</ul>-->
	
	<button id="testBtn">테스트</button>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script type="text/javascript">
	let bno=58;
	
	function getAllList(){

	$.getJSON("/replies/all/"+bno,function(data){
		
		let str = "";
		console.log(data);
		
		$(data).each(function(){
			//console.log("-----------")
			//console.log(this);
			str += "<li data-rno='"+this.rno+"' class='replyLi'>"+this.rno+":"+this.reply+"</li>";
		})
		
		console.log(str);
		
		$("#replies").html(str);
		
		//var str2 = "<a href='http://www.daum.net'>다음으로이동</a>"
		//$("#test").html(str2);
		});
	}
	getAllList();
	
	//$("#testBtn").on("click",function(){
		//let strTest = "<a href='http://www.naver.com'>네이버로이동</a>";
		
		//$("#test").html(strTest);
	//})
	
	
	
	
	
	</script>
	
</body>

</html>