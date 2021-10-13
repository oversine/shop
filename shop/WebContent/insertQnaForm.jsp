<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%	
	request.setCharacterEncoding("utf-8");		
	
	// 로그인 여부 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 작성</title>
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
		<h1>문의글 작성</h1>
	</div>
	<form id="qnaForm" action ="<%=request.getContextPath()%>/insertQnaAction.jsp" method ="post">
		<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<div class="form-group">
		<label for="qnaTitle">제목 : </label>
			<input type ="text" class="form-control" placeholder="제목을 입력해주세요" id="qnaTitle" name="qnaTitle" >
		</div>
		<div class="form-group">
			<label for="qnaCategory">카테고리 : </label>
			<select class="form-control" id = "qnaCategory" name = "qnaCategory">
				<option value = "전자책관련">전자책관련</option>
				<option value = "개인정보관련">개인정보관련</option>
				<option value = "기타">기타</option>
			</select>
		</div>
		<div class="form-group">
		<label for="qnaContent">내용 : </label>
			<textarea class="form-control" rows="5" placeholder="내용을 작성해주세요" id="qnaContent" name="qnaContent" ></textarea>
		</div>
		<div class="form-check">
		 <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="qnaSecret" value="Y">비밀글 작성
		 </label>
		</div>
		<div class="form-check">
  		<label class="form-check-label">
   			<input type="radio" class="form-check-input" name="qnaSecret" value="N" checked>외부 공개 허용
  		</label>
		</div><br>
		<div>
			<button id="btn" type ="button" class="btn btn-primary">작성</button>
			<button type ="reset" class="btn float-right btn-danger">초기화</button>
		</div>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#qnaTitle').val() == '') {
				alert('제목을 입력하세요');
				return;
			}
			if($('#qnaContent').val() == '') {
				alert('내용을 입력하세요');
				return;
			}
			
			$('#qnaForm').submit();
		});
	</script>
</div>
</body>
</html>