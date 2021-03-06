<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>

<head>
<style>
		#modDiv{
			 	width : 500px;
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
			
			#reply {
			width:450px;
			}
	</style>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<!-- 번들Cdn -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h1 class="text text-primary">${board.bno }번글 조회중</h1>
		<div class="row">
			<div class="col-md-9">
				<input type="text" class="form-control" value="${board.title }" readonly/>	
			</div>
			<div class="col-md-3">
				<input type="text" class="form-control" value="${board.writer }" readonly/>
			</div>
		</div>
		
		<textarea rows="10" class="form-control" readonly>${board.content }</textarea>
		<div class="row">
			<div class="col-md-3">쓴날짜:</div>
			<div class="col-md-3">${board.regdate }</div>
			<div class="col-md-3">수정날짜:</div>
			<div class="col-md-3">${board.updatedate }</div>
		</div><br/>
		<form action="/board/boardDelete" method="post">
			<input type="hidden" name="bno" value="${board.bno }"/>
			<input type="hidden" name="pageNum" value="${param.pageNum }"/>
			<input type="hidden" name="searchType" value="${param.searchType }"/>
			<input type="hidden" name="keyword" value="${param.keyword }"/>
			<input type="submit" value="글삭제" class="btn btn-danger"/>
		</form>
		
		<form action="/board/boardUpdateForm" method="post">
			
			<input type="hidden" name="bno" value="${board.bno }"/><br/>
			<input type="hidden" name="pageNum" value="${param.pageNum }"/>
			<input type="hidden" name="searchType" value="${param.searchType }"/>
			<input type="hidden" name="keyword" value="${param.keyword }"/>
			<input type="submit" value="글수정" class="btn btn-warning" />
		</form><br/>
		
		<a href="/board/boardList?pageNum=${param.pageNum == null ? 1 : param.pageNum }&searchType=${param.searchType}&keyword=${param.keyword}" class="btn btn-primary">글목록</a>
	
	
	<!-- 여기부터 비동기자바스크립트 처리영역 -->
	<div class="row">
		<ul id="replies">
	
		</ul>
	</div>
	
	<!-- 댓글 작성공간 -->
	<div class="row box-box-success">
			<div class="box-header">
				<h2 class="text-primary">댓글작성</h2>
			</div><!-- header -->
			<div class="box-body">
				<strong>Writer : </strong>
				<input type="text" id="newReplyWriter" placeholder="글쓴이" class="from-control">
				<strong>ReplyText : </strong>
				<input type="text" id="newReplyText" placeholder="댓글내용" class="from-control">
			</div><!-- body -->
			<div class="box-footer">
				<button type="button" class= "btn btn-success" id="replyAddBtn">댓글 추가</button>
			</div><!-- footer -->
		</div><!-- row -->
	
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
	
	
	
	<script>
	var bno = ${board.bno};
	function getAllList(){
	//하나의 글번호에대한 전체댓글조회
		$.getJSON("/replies/all/"+bno,function(data){
			
			let str = "";
			console.log(data);
			
			$(data).each(function(){
				
				let timestamp = this.updateDate;
				let date = new Date(timestamp);
				
				let formattedTime = " 게시일 : " + date.getFullYear()+"년"
									 + (date.getMonth()+1) + "월"
									 + date.getDate() + "일"
									// 시분초 추가하기
									+date.getHours() +"시"
									+date.getMinutes() +"분"
									+date.getSeconds() +"초";
									
			
				str += "<div class='replyLi' data-rno='" + this.rno + "'><strong>@"
					+ this.replyer + "</strong> - " + formattedTime + "<br>"
					+ "<div class='reply'>" + this.reply + "</div>"
					+ "<button type='button' class='btn btn-info'>수정/삭제</button>"
					+ "</div>";  
				});
			
			
			
			$("#replies").html(str);
			
			//var str2 = "<a href='http://www.daum.net'>다음으로이동</a>"
			//$("#test").html(str2);
			});
		}
		getAllList();
		//댓글 달기
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
		// 모달 댓글 삭제
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
		// 하나의 댓글에대한 모달열기 버튼
		$("#replies").on("click",".replyLi button",function(){
			let replytag =$(this).parent();
			console.log(replytag);
			
			let replyContent = $(this).siblings(".reply").text();
			
			let rno = replytag.attr("data-rno");
			console.log(rno);
			
			//let reply = replytag.text();
			//alert(rno+":"+reply);
			$(".modal-title").html(rno); //modal-title부분에 글번호 입력
			$("#reply").val(replyContent);// reply 영역에 리플내용을 기입(수정/삭제)
			$("#modDiv").show("slow");// 버튼 누르면 모달 열림
		});
		
		//모달 댓글 닫기창
		$("#closeBtn").on("click",function(){
			$("#modDiv").hide("slow");
		});
		
		
		
		// 모달 댓글 수정로직
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
	</div>
</body>
</html>