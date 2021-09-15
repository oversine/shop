<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인증 방어 코드 : 로그인 전 상태만 해당 페이지 열람 가능
	// session.getAttribute("loginMember") --> null
	if(session.getAttribute("loginMember") != null) {
		System.out.println("로그인 상태입니다.");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div class="jumbotron text-center">
		<h1>로그인</h1>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
		<div class="form-group">
		<label for="memberId">Id : </label>
			<input type ="text" class="form-control" placeholder="ID를 입력해주세요" name="memberId" >
		</div>
		<div class="form-group">
		<label for="memberPw">비밀번호 : </label>
			<input type ="password" class="form-control" placeholder="비밀번호를 입력해주세요" name="memberPw" >
		</div>
		<div><button type="submit" class="btn btn-primary">로그인</button></div>
	</form>
</div>
</body>
</html>