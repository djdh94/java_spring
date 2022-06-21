<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/board/boardInsert" method="post">
		제목:<input type="text" name="title"/>
		글쓴이:<input type="text" name="writer"/><br/>
		내용:<textarea rows="20" cols="100" name="content"></textarea><br/>
		<input type="submit"/>
	</form>
</body>
</html>