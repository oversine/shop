<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMember(memberNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 등급 수정 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div>
		<jsp:include page="/partial/memberMenu.jsp"></jsp:include>
	</div>

	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div class="jumbotron text-center">
		<h1>회원 등급 변경</h1>
	</div>
	<form id="updateLevelForm" method="post" action="<%=request.getContextPath()%>/admin/updateMemberLevelAction.jsp">
		<input type="hidden" name="memberNo" value="<%=memberNo%>">
		<div class="form-group">
			<label for="memberLevel">변경하실 회원 레벨 : </label>
			<select class="form-control" name="memberLevel">
				<option value = "0">0</option>
				<option value = "1">1</option>
			</select>
		</div>
		<div class="form-group">
		<label for="memberId">Id : </label>
			<input type ="text" class="form-control" value="<%=member.getMemberId()%>" readonly="readonly" >
		</div>
		<div class="form-group">
		<label for="memberName">이름 : </label>
			<input type ="text" class="form-control" value="<%=member.getMemberName()%>" readonly="readonly" >
		</div>
		<div class="form-group">
		<label for="memberAge">나이 : </label>
			<input type ="number" class="form-control" value="<%=member.getMemberAge()%>" readonly="readonly" >
		</div>
		<div class="form-group">
		<label for="memberGender">성별 : </label>
			<input type ="text" class="form-control" value="<%=member.getMemberGender()%>" readonly="readonly" >
		</div>					
		<div><button id="btn" type="button" class="btn btn-primary">수정</button></div>
	</form>
	
	<script>
		$('#btn').click(function(){
			$('#updateLevelForm').submit();
		});
	</script>
</div>
</body>
</html>