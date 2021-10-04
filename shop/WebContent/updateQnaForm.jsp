<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(request.getParameter("memberNo") == null || request.getParameter("qnaNo") == null){
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// 로그인을 하지 않았거나 해당 글을 작성한 회원이 아닌 경우 메인 화면으로 이동
	if(loginMember == null || loginMember.getMemberNo() != memberNo) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	QnaDao qnaDao = new QnaDao();
	Qna qna = qnaDao.selectQnaOne(qnaNo);
	
	// System.out.println(qna.getQnaNo());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
		<h1>문의글 수정</h1>
	</div>
	<form id="updateQnaForm" action ="<%=request.getContextPath()%>/updateQnaAction.jsp" method ="post">
			<input type="hidden" name="qnaNo" value="<%=qna.getQnaNo()%>">
			<div class="form-group">
			<label for="qnaTitle">제목 : </label>
				<input type ="text" class="form-control" id="qnaTitle" value="<%=qna.getQnaTitle()%>" name="qnaTitle">
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
				<textarea class="form-control" rows="5" id="qnaContent" name="qnaContent" ><%=qna.getQnaContent()%></textarea>
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
				<button id="btn" type ="button" class="btn btn-primary">수정</button>
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
				
				$('#updateQnaForm').submit();
			});
		</script>
</div>
</body>
</html>