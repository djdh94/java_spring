<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>member 주소</h1>

		<sec:authorize access="isAuthenticated()">
		<!-- 로그인 한(인증된) 사용자인 경우 -->
			<a href="/customLogout">로그아웃</a>
		</sec:authorize>
		
	
</body>
</html>