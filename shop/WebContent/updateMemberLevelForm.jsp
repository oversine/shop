<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
%>
<div class="container">
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div class="jumbotron text-center">
		<h1>로그인</h1>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/updateMemberPwAction.jsp">
		<div class="form-group">
			<label for="memberGender">변경하실 회원 레벨 : </label>
			<select class="form-control" name = "memberLevel">
				<option value = "0">0</option>
				<option value = "1">1</option>
			</select>
		</div>
		<div><button type="submit" class="btn btn-primary">수정</button></div>
	</form>
</div>
</body>
</html>