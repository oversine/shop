<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%	
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	if(request.getParameter("ebookNo") == null){
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
		return;
	}
	
	if(request.getParameter("ebookNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
		return;
	}
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자책 상세</title>
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
	<%
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	%>
	<div>
	<table class="table table-bordered table-dark table-striped">
		<tr>
			<td>책 번호</td>
			<td><%=ebook.getEbookNo()%></td>
		</tr>
		<tr>
			<td>ISBN</td>
			<td><%=ebook.getEbookISBN()%></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td><%=ebook.getCategoryName()%></td>
		</tr>
		<tr>
			<td>도서명</td>
			<td><%=ebook.getEbookTitle()%></td>
		</tr>
		<tr>
			<td>작가명</td>
			<td><%=ebook.getEbookAuthor()%></td>
		</tr>
		<tr>
			<td>출판회사</td>
			<td><%=ebook.getEbookCompany()%></td>
		</tr>
		<tr>
			<td>페이지 수</td>
			<td><%=ebook.getEbookPageCount()%></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><%=ebook.getEbookPrice()%></td>
		</tr>
		<tr>
			<td>이미지</td>
			<td><img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg()%>" style="width:50%; height:auto;"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=ebook.getEbookSummary()%></td>
		</tr>
		<tr>
			<td>판매현황</td>
			<td><%=ebook.getEbookState()%></td>
		</tr>
		<tr>
			<td>생성일</td>
			<td><%=ebook.getCreateDate()%></td>
		</tr>
		<tr>
			<td>수정일</td>
			<td><%=ebook.getUpdateDate()%></td>
		</tr>
		<tr>
			<td colspan="2">
				<a class="btn float-right btn-danger" href="<%=request.getContextPath()%>/admin/deleteEbook.jsp?ebookNo=<%=ebook.getEbookNo()%>">삭제</a>
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/admin/updateEbookForm.jsp?ebookNo=<%=ebook.getEbookNo()%>">수정</a>
			</td>
		</tr>
	</table>
	</div>
</div>
</body>
</html>