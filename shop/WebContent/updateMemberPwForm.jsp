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
	
	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
%>
<div class="container">
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div class="jumbotron text-center">
		<h1>비밀번호 변경</h1>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/updateMemberLevelAction.jsp">
		<input type="hidden" name="memberNo" value="<%=memberNo%>">
		<div class="form-group">
		<label for="newPw">변경하실 비밀번호 : </label>
			<input type ="password" class="form-control" placeholder="비밀번호를 입력해주세요" name="newPw" >
		</div>
		<div><button type="submit" class="btn btn-primary">수정</button></div>
	</form>
</div>
</body>
</html>