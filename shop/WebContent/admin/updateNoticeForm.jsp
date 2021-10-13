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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	if(request.getParameter("noticeNo") == null){
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeOne(noticeNo);
	
	// System.out.println(notice.getNoticeNo());
%>
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
		<h1>공지사항 수정</h1>
	</div>
	<form id="noticeForm" action ="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method ="post">
			<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
			<div class="form-group">
			<label for="noticeTitle">제목 : </label>
				<input type ="text" class="form-control" id="noticeTitle" value="<%=notice.getNoticeTitle()%>" name="noticeTitle">
			</div>
			<div class="form-group">
			<label for="noticeContent">내용 : </label>
				<textarea class="form-control" rows="5" id="noticeContent" name="noticeContent" ><%=notice.getNoticeContent()%></textarea>
			</div>
			<div>
				<button id="btn" type ="button" class="btn btn-primary">수정</button>
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