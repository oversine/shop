<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
		
	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
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
<title>회원정보 수정</title>
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
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div class="jumbotron text-center">
		<h1>회원정보 변경</h1>
	</div>
	<%
		// 현재 비밀번호 일치 여부 체크를 위한 변수
		int result = 0;
		if(request.getParameter("result") != null) {
			result = Integer.parseInt(request.getParameter("result"));
		}
		
		// 비밀번호 일치를 확인하지 않은 초기 확
		if(result == 0) {
	%>
			<!-- 비밀번호 일치여부 확인 폼 -->
			<form id="MemberPwCheckForm" action="<%=request.getContextPath()%>/selectMemberPwCheckAction.jsp" method="post">
				<input type="hidden" name="memberNo" value="<%=memberNo%>">
				<div class="form-group">
				<label for="memberId">현재 비밀번호 : </label>
					<input type ="text" class="form-control" placeholder="비밀번호를 입력해주세요" id="memberPwCheck" name="memberPwCheck">
				</div>
				<button id="btn" type="button" class="btn btn-primary">확인</button>
			</form><br>
	<% 
		}
		
		if(result == 1) {
	%>	
			<form id="updateForm" method="post" action="<%=request.getContextPath()%>/updateMemberAction.jsp">
				<input type="hidden" name="memberNo" value="<%=memberNo%>">
				<div class="form-group">
				<label for="updatePw">변경하실 비밀번호 : </label>
					<input type ="password" class="form-control" placeholder="비밀번호를 입력해주세요" id="updatePw" name="updatePw" >
				</div>
				<div class="form-group">
				<label for="updateRePw">변경 비밀번호 재입력 : </label>
					<input type ="password" class="form-control" placeholder="비밀번호를 입력해주세요" id="updateRePw" name="updateRePw" >
				</div>
				<div class="form-group">
				<label for="memberId">Id : </label>
					<input type ="text" class="form-control" value="<%=member.getMemberId()%>" readonly="readonly" >
				</div>
				<div class="form-group">
				<label for="updateName">이름 : </label>
					<input type ="text" class="form-control" value="<%=member.getMemberName()%>" id="updateName" name="updateName">
				</div>
				<div class="form-group">
				<label for="updateAge">나이 : </label>
					<input type ="number" class="form-control" value="<%=member.getMemberAge()%>" id="updateAge" name="updateAge">
				</div>
				<div class="form-group">
					<label for="updateGender">성별 : </label>
					<select class="form-control" id = "updateGender" name = "updateGender">
						<option value = "남">남</option>
						<option value = "여">여</option>
					</select>
				</div>
				<div><button id="btn2" type="button" class="btn btn-primary">수정</button></div>
			</form>
	
	<%
		}
	%>
	
	<script>
		$('#btn').click(function(){
			if($('#memberPwCheck').val() == '') {
				alert('현재 비밀번호를 입력하세요');
				return;
			}
			$('#MemberPwCheckForm').submit();
		});
	
		$('#btn2').click(function(){
			if($('#updatePw').val() != $('#updateRePw').val()) {
				alert('변경 비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
				return;
			}
			if($('#updateName').val() == '') {
				alert('수정하실 이름을 입력하세요');
				return;
			}
			if($('#updateAge').val() == '') {
				alert('수정하실 나이를 입력하세요');
				return;
			}
			$('#updateForm').submit();
		});
	</script>
</div>
</body>
</html>