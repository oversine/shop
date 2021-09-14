<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.Member"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/submenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<h1>메인페이지</h1>
	<% 
		if(session.getAttribute("loginMember") == null){
	%>
			<div><a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></div>
			<div><a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></div>
	<%		
		} else {
			// 형변환을 사용해 어떤 타입인지 선언필요
			Member loginMember = (Member)session.getAttribute("loginMember");
	%>
			<div><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></div>
	<%	
		}
	%>
</body>
</html>