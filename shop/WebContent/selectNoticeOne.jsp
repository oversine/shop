<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%	
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(request.getParameter("noticeNo") == null){
		response.sendRedirect(request.getContextPath() + "/selectNoticeList.jsp");
		return;
	}
	
	if(request.getParameter("noticeNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/selectNoticeList.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 공지사항</title>
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
		NoticeDao noticeDao = new NoticeDao();
		Notice notice = noticeDao.selectNoticeOne(noticeNo);
	%>
	<div>
	<table class="table table-bordered table-dark table-striped">
		<tr>
			<td>공지사항 번호</td>
			<td><%=notice.getNoticeNo()%></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=notice.getNoticeTitle()%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=notice.getNoticeContent()%></td>
		</tr>
		<tr>
			<td>생성일</td>
			<td><%=notice.getCreateDate()%></td>
		</tr>
		<tr>
			<td>수정일</td>
			<td><%=notice.getUpdateDate()%></td>
		</tr>
		<% 
			// 로그인을 하지 않았거나 관리자가 아닌 경우 삭제 및 수정 불가
			if(loginMember != null && loginMember.getMemberLevel() > 0) {
		%>
			<tr>
			<td colspan="2">
				<a class="btn float-right btn-danger" href="<%=request.getContextPath()%>/admin/deleteNotice.jsp?noticeNo=<%=notice.getNoticeNo()%>">삭제</a>
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=notice.getNoticeNo()%>">수정</a>
			</td>
			</tr>
		<%
			}
		%>
	</table>
	</div>
</div>
</body>
</html>