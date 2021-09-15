<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	// 로그인 상태에서 회원가입 페이지 접근 불가
	if(session.getAttribute("loginMember") != null){
		// 이전 웹 브라우저로 돌아가 다른 곳을 요청하도록 하는 메서드
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
		<h1>회원가입</h1>
	</div>
	<form action ="<%=request.getContextPath()%>/insertMemberAction.jsp" method ="post">
		<div class="form-group">
		<label for="memberId">Id : </label>
			<input type ="text" class="form-control" placeholder="ID를 입력해주세요" name="memberId" >
		</div>
		<div class="form-group">
		<label for="memberPw">비밀번호 : </label>
			<input type ="password" class="form-control" placeholder="비밀번호를 입력해주세요" name="memberPw" >
		</div>
		<div class="form-group">
		<label for="memberName">이름 : </label>
			<input type ="text" class="form-control" placeholder="이름을 입력해주세요" name="memberName" >
		</div>
		<div class="form-group">
		<label for="memberAge">나이 : </label>
			<input type ="number" class="form-control" placeholder="나이를 입력해주세요" name="memberAge" >
		</div>					
		<div class="form-group">
			<label for="memberGender">성별 : </label>
			<select class="form-control" name = "memberGender">
				<option value = "남">남</option>
				<option value = "여">여</option>
			</select>
		</div>
		<div>
			<button type ="submit" class="btn btn-primary">회원가입</button>
			<button type ="reset" class="btn float-right btn-danger">초기화</button>
		</div>
	</form>
</div>
</body>
</html>