<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%	
	request.setCharacterEncoding("utf-8");		
	
	// 로그인 회원 관리자 레벨 확인
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
<title>카테고리 추가 페이지</title>
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
		<h1>카테고리 추가</h1>
	</div>
	<%
		// 초기값을 공백으로 설정해 처음 들어오거나 실패한 경우 하단 카테고리 값 공백 상태, 중복확인 수행 후 정상적으로 넘어온 경우 해당 입력값이 채워짐 
		String categoryNameCheck = "";
		if(request.getParameter("categoryNameCheck") != null) {
			categoryNameCheck = request.getParameter("categoryNameCheck");
		}
	%>
	<!-- 카테고리명 중복여부 확인 폼 -->
	<form id="categoryCheckForm" action="<%=request.getContextPath()%>/admin/selectCategoryNameCheckAction.jsp" method="post">
		<div class="form-group">
		<label for="categoryName">카테고리 : </label>
			<input type ="text" class="form-control" placeholder="카테고리를 입력해주세요" id="categoryNameCheck" name="categoryNameCheck">
		</div>
		<button id="btn" type="button" class="btn btn-primary">중복 검사</button>
	</form><br>
	
	<!-- 카테고리 추가 폼 -->
	<form id="insertCategoryForm" action ="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method ="post">
		<div class="form-group">
			<input type ="text" class="form-control" id="categoryName" name="categoryName" readonly="readonly" value="<%=categoryNameCheck%>">
		</div>				
		<div class="form-group">
			<label for="categoryState">카테고리 사용여부 : </label>
			<select class="form-control" id="categoryState" name = "categoryState">
				<option value = "Y" selected>Y</option>
				<option value = "N">N</option>
			</select>
		</div>
		<div>
			<button id="btn2" type="button" class="btn btn-primary">카테고리 추가</button>
		</div>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#categoryNameCheck').val() == '') {
				alert('카테고리명을 입력하세요');
				return;
			}
			$('#categoryCheckForm').submit();
		});
	
		$('#btn2').click(function(){
			if($('#categoryName').val() == '') {
				alert('카테고리명을 입력하세요');
				return;
			}
			$('#insertCategoryForm').submit();
		});
	</script>
</div>
</body>
</html>