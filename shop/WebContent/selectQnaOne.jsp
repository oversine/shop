<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	request.setCharacterEncoding("utf-8");		

	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	if(request.getParameter("qnaNo") == null){
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	if(request.getParameter("qnaNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글</title>
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
	<%
		QnaDao qnaDao = new QnaDao();
		Qna qna = qnaDao.selectQnaOne(qnaNo);
	%>
	<div>
	<table class="table table-bordered table-dark table-striped">
		<tr>
			<td>글 번호</td>
			<td><%=qna.getQnaNo()%></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td><%=qna.getQnaCategory()%></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=qna.getQnaTitle()%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=qna.getQnaContent()%></td>
		</tr>
		<tr>
			<td>비밀글 여부</td>
			<td><%=qna.getQnaSecret()%></td>
		</tr>
		<tr>
			<td>ID</td>
			<td><%=qna.getMemberId()%></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><%=qna.getCreateDate()%></td>
		</tr>
		<tr>
			<td>수정일</td>
			<td><%=qna.getUpdateDate()%></td>
		</tr>
		<%
			// 작성한 회원이나 관리자는 문의글 삭제 및 수정 가능
			if(loginMember != null && loginMember.getMemberNo() == qna.getMemberNo() || loginMember != null && loginMember.getMemberLevel() > 0) {
		%>
		<tr>
			<td colspan="2">
				<a class="btn float-right btn-danger" href="<%=request.getContextPath()%>/deleteQna.jsp?qnaNo=<%=qna.getQnaNo()%>&&memberNo=<%=qna.getMemberNo()%>">삭제</a>
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/updateQnaForm.jsp?qnaNo=<%=qna.getQnaNo()%>&&memberNo=<%=qna.getMemberNo()%>">수정</a>
			</td>
		</tr>
		<%
			}
		%>	
		<tr>
			<td colspan="2">
			<div>
				<%
					// 관리자 문의글 답변 작성
					if(loginMember != null && loginMember.getMemberLevel() > 0) {
				%>
				<form id="qnaCommentForm" action="<%=request.getContextPath()%>/admin/insertQnaCommentAction.jsp" method="post">
					<div class="form-group">
					<input type="hidden" name="qnaNo" value="<%=qna.getQnaNo()%>">
					<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
					<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
					<label for="qnaComment">답변 : </label>
						<textarea class="form-control" rows="5" placeholder="답변을 작성해주세요" id="qnaComment" name="qnaComment" ></textarea>
					</div>
					<div>
						<button id="btn" type ="button" class="btn btn-primary">작성</button>
					</div>
				</form>
				
				<script>
					$('#btn').click(function(){
						if($('#qnaComment').val() == '') {
							alert('답변을 입력하세요');
							return;
						}
						
						$('#qnaCommentForm').submit();
					});
				</script>
				<%
					}
				%>
			</div>
			</td>
		</tr>
	</table>
	</div>	
	<%	
		QnaCommentDao qnaCommentDao = new QnaCommentDao();
		QnaComment qnaComment = new QnaComment();
		
		qnaComment = qnaCommentDao.selectQnaCommentOne(qnaNo);
	%>	
		<!-- 관리자 답변 내역 -->
	<%	
		// 해당 문의글에 대한 답변이 작성된 경우 출력
		if(qnaComment != null) {
	%>		
		<div>
		<table class="table table-bordered table-dark table-striped">
		<thead>
			<tr>
				<th>작성자</th>
				<th>답변</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=qnaComment.getMemberId()%></td>
				<td><%=qnaComment.getQnaCommentContent()%></td>
				<td><%=qnaComment.getUpdateDate()%></td>
				<% 
					// 관리자만 문의 답변 삭제 가능
					if(loginMember != null && loginMember.getMemberLevel() > 0) {
				%>
						<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteQnaComment.jsp?qnaCommentNo=<%=qnaComment.getQnaCommentNo()%>&&qnaNo=<%=qna.getQnaNo()%>">삭제</a></td>
				<%
					}
				%>
			</tr>
		</tbody>
		</table>
		</div>
	<%
		}
	%>
</div>
</body>
</html>