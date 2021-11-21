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
<title>회원 비밀번호 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="css/styles.css" rel="stylesheet" />
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
		<h1>비밀번호 변경</h1>
	</div>
	<form id="updatePwForm" method="post" action="<%=request.getContextPath()%>/updateMemberPwAction.jsp">
		<input type="hidden" name="memberNo" value="<%=memberNo%>">
		<div class="form-group">
		<label for="newPw">변경하실 비밀번호 : </label>
			<input type ="password" class="form-control" placeholder="비밀번호를 입력해주세요" id="newPw" name="newPw" >
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
			if($('#newPw').val() == '') {
				alert('수정하실 비밀번호를 입력하세요');
				return;
			}
			$('#updatePwForm').submit();
		});
	</script>
</div>
</body>
</html>