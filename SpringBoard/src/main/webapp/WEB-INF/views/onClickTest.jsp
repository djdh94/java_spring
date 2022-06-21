<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<ul id="replies">
	</ul>
	<button id="requestBtn">댓글 로딩해오기</button>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
	
	let bno=58;
	
	$("#requestBtn").on("click",function(){
		$.getJSON("/replies/all/"+bno,function(data){
			let str="";
			$(data).each(function(){
				
				
			str += "<li data-rno='"+this.rno+"' class='replyLi'>"+this.rno+":"+this.reply+"</li>";
			console.log(str);
			console.log("--------------")
			})
			$("#replies").html(str);
		})
	})
	</script>
</body>
</html>