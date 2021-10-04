<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%@ page import="java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 신규 공지사항 목록 5개
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> newNoticeList = noticeDao.selectNewNoticeList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<h1>관리자 페이지</h1>
	<div><%=loginMember.getMemberId()%>님 반갑습니다.</div>
	<div><a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지사항 작성</a></div>
	<div><a href="<%=request.getContextPath()%>/index.jsp">메인으로 이동</a></div>
	
	<table class="table table-striped" style="text-align: center;">
		<%
			for(Notice n : newNoticeList) {
		%>
			<tr>
				<td><%=n.getNoticeNo()%></td>
				<td><a href="<%=request.getContextPath()%>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
				<td><%=n.getUpdateDate()%></td>
			</tr>
		<%
			}
		%>
	</table>
</div>
</body>
</html>