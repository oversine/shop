<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || request.getParameter("orderNo") == null || request.getParameter("ebookNo") == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	// System.out.println(orderNo);
	// System.out.println(ebookNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 후기 작성</title>
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
	<div class="jumbotron text-center">
		<h1>상품 후기</h1>
	</div>
	<form id="insertOrderCommentForm" action="<%=request.getContextPath()%>/insertOrderCommentAction.jsp" method="post">
		<div class="form-group">
		<label for="orderNo">주문 번호 : </label>
			<input type ="text" class="form-control" value="<%=orderNo%>" name="orderNo" readonly="readonly" >
		</div>
		<div class="form-group">
		<label for="ebookNo">책 번호 : </label>
			<input type ="text" class="form-control" value="<%=ebookNo%>" name="ebookNo" readonly="readonly" >
		</div>	
		<div class="form-group">
		<label for="orderComment">후기 : </label>
			<textarea class="form-control" rows="5" placeholder="상품의 후기를 작성해주세요" id="orderComment" name="orderComment" ></textarea>
		</div>
		<div class="form-group">
			<label for="orderScore">상품 점수 : </label>
			<select class="form-control" name = "orderScore">
				<option value = "0">0</option>
				<option value = "1">1</option>
				<option value = "2">2</option>
				<option value = "3">3</option>
				<option value = "4">4</option>
				<option value = "5">5</option>
			</select>
		</div>
		<div><button id="btn" type="button" class="btn btn-primary">작성</button></div>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#orderComment').val() == '') {
				alert('후기를 입력하세요');
				return;
			}
			$('#insertOrderCommentForm').submit();
		});
	</script>
</div>
</body>
</html>