<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<style>
		#modDiv{
			 	width : 300px;
			 	height : 100px;
			 	background-color : green;
			 	position : absolute;
			 	top : 50%;
			 	left : 50%;
			 	margin-top : -50px;
			 	margin-left : -150px;
			 	padding : 10px;
			 	z-index : 1000;
			}
	</style>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<!-- 번들Cdn -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>ajax 댓글 등록 테스트</h2>
	
	<div>
		<div>
			댓글 글쓴이 <input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
			댓글 내용 <input type="text" name="reply" id="newReplyText">
		</div>
		<ul id="replies">
	
		</ul>
		<button id="replyAddBtn">댓글추가</button>
	</div>
	
	<!-- modal -->
	<div id="modDiv" style="display:none;">
		<div class="modal-title"></div>
		<div>
			<input type="text" id="reply">
		</div>
		<div>
			<button type="button" id="replyModBtn">수정</button>
			<button type="button" id="replyDelBtn">삭제</button>
			<button type="button" id="closeBtn">닫기</button>
		</div>
	</div>
	

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script type="text/javascript">
	let bno=45052;
	
	function getAllList(){

		$.getJSON("/replies/all/"+bno,function(data){
			
			let str = "";
			console.log(data);
			
			$(data).each(function(){
				//console.log("-----------")
				//console.log(this);
				str += "<li data-rno='" + this.rno + "' class='replyLi'>"
				+ this.rno + ":" + this.reply
				+ "<button>수정/삭제</button></li>"; 
			})
			
			console.log(str);
			
			$("#replies").html(str);
			
			//var str2 = "<a href='http://www.daum.net'>다음으로이동</a>"
			//$("#test").html(str2);
			});
		}
		getAllList();
	
	
	
	$("#replyAddBtn").on("click",function(){
		let replyer = $("#newReplyWriter").val();
		let reply = $("#newReplyText").val();
		
		$.ajax({
			type : 'post',
			url : '/replies',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Overrid" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({
				bno : bno,
				replyer : replyer,
				reply : reply
				
			}),
			
			success : function(result){
 				if(result == 'SUCCESS'){
					alert("등록 되었습니다.");
					let replyer = $("#newReplyWriter").val('');
					let reply = $("#newReplyText").val('');
					getAllList();
				}
			}
			
		});
		
	});
	
	$("#replyDelBtn").on("click",function(){
		let rno=$(".modal-title").html();
		
		$.ajax({
			type : 'delete',
			url : '/replies/'+rno,
			header :{
				"X-HTTP-Method-Overrid" : "DELETE"
			},
			dataType : 'text',
			success : function(result){
				console.log("result:"+result);
				if(result == 'SUCCESS'){
					alert("삭제됬습니다.");
					$("#modDiv").hide("slow");
					getAllList();
				}
			}
		})
	})
	$("#replies").on("click",".replyLi button",function(){
		let replytag =$(this).parent();
		console.log(replytag);
		
		let rno = replytag.attr("data-rno");
		console.log(rno);
		
		let reply = replytag.text();
		//alert(rno+":"+reply);
		$(".modal-title").html(rno); //modal-title부분에 글번호 입력
		$("#reply").val(reply);// reply2 영역에 리플내용을 기입(수정/삭제)
		$("#modDiv").show("slow");// 버튼 누르면 모달 열림
	});
	
	$("#closeBtn").on("click",function(){
		$("#modDiv").hide("slow");
	});
	
	
	
	// 수정로직
	$("#replyModBtn").on("click",function(){
		let rno = $(".modal-title").html();
		let reply=$("#reply").val();
		
		$.ajax({
			type : 'put',
			url : '/replies/'+rno,
			header : { 
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			contentType : "application/json",
			dataType : 'text',
			data : JSON.stringify({reply:reply}),
			success : function(result){
				console.log("result: " + result);
				if(result=='SUCCESS'){
					alert("수정됬습니다");
					$("#modDiv").hide("slow");
					getAllList();
				}
			}
		});
	});
	
	</script>

</body>
</html>