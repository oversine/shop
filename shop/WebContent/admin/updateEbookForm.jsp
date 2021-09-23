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
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	EbookDao ebookDao = new EbookDao();
	Ebook ebook = ebookDao.selectEbookOne(ebookNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<!-- enctype="multipart/form-data" : 액션으로 글자값이 아닌 기계어 코드를 넘길때 사용 -->
	<form action="<%=request.getContextPath()%>/admin/updateEbookAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
			<div class="form-group">
				<label for="ebookPirce">가격 : </label>
					<input type ="text" class="form-control" value="<%=ebook.getEbookPrice()%>" name="ebookPrice">
			</div>
			<div class="form-group">
				<label for="ebookImg">이미지 변경 :</label>
					<input type="file" class="form-control-file border" name="ebookImg">
			</div>
			<div>
				<button type ="submit" class="btn btn-primary">수정</button>
				<button type ="reset" class="btn float-right btn-danger">초기화</button>
			</div>
		</form>
	</div>
</body>
</html>