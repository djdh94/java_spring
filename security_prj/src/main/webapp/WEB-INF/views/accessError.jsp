<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>접근실패</h1>
	<!-- 403에러가 떳을시 보여주는 메세지 -->
	<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h2>
	
	<!-- 컨트롤러에서 "접근거부"라는 메시지를 보내줌 -->
	<h2><c:out value="${errorMessage }"></c:out></h2>
</body>
</html>