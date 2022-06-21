<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>${board.bno }번글 수정페이지 입니다.</h1>
	<form action="/board/boardUpdate" method="post">
		<input type="hidden" name="bno" value="${board.bno }"/>
		<input type="hidden" name="pageNum" value="${param.pageNum }"/>
		<input type="hidden" name="searchType" value="${param.searchType }"/>
		<input type="hidden" name="keyword" value="${param.keyword }"/>
		<input type="text" name="title" value="${board.title }"/>
		<input type="text" name="writer" value="${board.writer }" readonly/><br/>
		<textarea cols="100" rows="20" name="content">${board.content }</textarea><br/>
		<input type="submit" value="수정하기"/>
		</form>
</body>
</html>