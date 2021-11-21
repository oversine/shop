<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%	
	request.setCharacterEncoding("utf-8");		
	
	// 로그인 회원 관리자 레벨 확인
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
<title>공지사항 작성</title>
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
		<h1>공지사항 작성</h1>
	</div>
	<form id="noticeForm" action ="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method ="post">
		<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
		<div class="form-group">
		<label for="noticeTitle">제목 : </label>
			<input type ="text" class="form-control" placeholder="제목을 입력해주세요" id="noticeTitle" name="noticeTitle" >
		</div>
		<div class="form-group">
		<label for="noticeContent">내용 : </label>
			<textarea class="form-control" rows="5" placeholder="공지사항을 작성해주세요" id="noticeContent" name="noticeContent" ></textarea>
		</div>
		<div>
			<button id="btn" type ="button" class="btn btn-primary">작성</button>
			<button type ="reset" class="btn float-right btn-danger">초기화</button>
		</div>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#noticeTitle').val() == '') {
				alert('제목을 입력하세요');
				return;
			}
			if($('#noticeContent').val() == '') {
				alert('내용을 입력하세요');
				return;
			}
			
			$('#noticeForm').submit();
		});
	</script>
</div>
</body>
</html>