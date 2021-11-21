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
	
	if(request.getParameter("ebookNo") == null || request.getParameter("ebookNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
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
<title>전자책 수정</title>
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
	
	<!-- enctype="multipart/form-data" : 액션으로 글자값이 아닌 기계어 코드를 넘길때 사용 -->
	<form id="updateEbookForm" action="<%=request.getContextPath()%>/admin/updateEbookAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
		<input type="hidden" name="deleteEbookImg" value="<%=ebook.getEbookImg()%>">
			<div class="form-group">
				<label for="ebookPirce">가격 : </label>
					<input type ="text" class="form-control" value="<%=ebook.getEbookPrice()%>" id="ebookPrice" name="ebookPrice">
			</div>
			<div class="form-group">
				<label for="ebookImg">이미지 변경 :</label>
					<input type="file" class="form-control-file border" id="ebookImg" name="ebookImg">
			</div>
			<div>
				<button id="btn" type="button" class="btn btn-primary">수정</button>
				<button type="reset" class="btn float-right btn-danger">초기화</button>
			</div>
		</form>
		
		<script>
			$('#btn').click(function(){
				if($('#ebookPrice').val() == '') {
					alert('가격을 입력하세요');
					return;
				}
				$('#updateEbookForm').submit();
			});
		</script>
</div>
</body>
</html>