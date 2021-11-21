<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");		

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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="css/styles.css" rel="stylesheet" />
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
	<%
		// ID값 중복 체크를 위한 변수
		String memberIdCheck = "";
		if(request.getParameter("memberIdCheck") != null) {
			memberIdCheck = request.getParameter("memberIdCheck");
		}
	%>
	<!-- 아이디 사용가능 중복여부 확인 폼 -->
	<form id="insertMemberIdCheckForm" action="<%=request.getContextPath()%>/selectMemberIdCheckAction.jsp" method="post">
		<div class="form-group">
		<label for="memberId">Id : </label>
			<input type ="text" class="form-control" placeholder="ID를 입력해주세요" id="memberIdCheck" name="memberIdCheck">
		</div>
		<button id="btn" type="button" class="btn btn-primary">중복 검사</button>
	</form><br>
	
	<!-- 회원가입 폼 -->
	<form id="joinForm" action ="<%=request.getContextPath()%>/insertMemberAction.jsp" method ="post">
		<div class="form-group">
			<input type ="text" class="form-control" placeholder="ID를 입력해주세요" id="memberId" name="memberId" readonly="readonly" value="<%=memberIdCheck%>">
		</div>
		<div class="form-group">
		<label for="memberPw">비밀번호 : </label>
			<input type ="password" class="form-control" placeholder="비밀번호를 입력해주세요" id="memberPw" name="memberPw" >
		</div>
		<div class="form-group">
		<label for="memberName">이름 : </label>
			<input type ="text" class="form-control" placeholder="이름을 입력해주세요" id="memberName" name="memberName" >
		</div>
		<div class="form-group">
		<label for="memberAge">나이 : </label>
			<input type ="number" class="form-control" placeholder="나이를 입력해주세요" id="memberAge" name="memberAge" >
		</div>					
		<div class="form-group">
			<label for="memberGender">성별 : </label>
			<select class="form-control" id = "memberGender" name = "memberGender">
				<option value = "남">남</option>
				<option value = "여">여</option>
			</select>
		</div>
		<div>
			<button id="btn2" type ="button" class="btn btn-primary">회원가입</button>
			<button type ="reset" class="btn float-right btn-danger">초기화</button>
		</div>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#memberIdCheck').val() == '') {
				alert('ID를 입력하세요');
				return;
			}
			$('#insertMemberIdCheckForm').submit();
		});
	
		$('#btn2').click(function(){
			if($('#memberId').val() == '') {
				alert('Id를 입력하세요');
				return;
			}
			if($('#memberPw').val() == '') {
				alert('비밀번호를 입력하세요');
				return;
			}
			if($('#memberName').val() == '') {
				alert('이름을 입력하세요');
				return;
			}
			if($('#memberAge').val() == '') {
				alert('나이를 입력하세요');
				return;
			}
			
			$('#joinForm').submit();
		});
	</script>
</div>
</body>
</html>