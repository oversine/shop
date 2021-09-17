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
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
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
	<form action="<%=request.getContextPath()%>/admin/selectCategoryNameCheckAction.jsp" method="post">
		<div class="form-group">
		<label for="categoryName">카테고리 : </label>
			<input type ="text" class="form-control" placeholder="카테고리를 입력해주세요" name="categoryNameCheck">
		</div>
		<button type="submit" class="btn btn-primary">중복 검사</button>
	</form><br>
	
	<!-- 카테고리 추가 폼 -->
	<form action ="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method ="post">
		<div class="form-group">
			<input type ="text" class="form-control" name="categoryName" readonly="readonly" value="<%=categoryNameCheck%>">
		</div>				
		<div class="form-group">
			<label for="categoryState">카테고리 사용여부 : </label>
			<select class="form-control" name = "categoryState">
				<option value = "Y" selected>Y</option>
				<option value = "N">N</option>
			</select>
		</div>
		<div>
			<button type ="submit" class="btn btn-primary">카테고리 추가</button>
		</div>
	</form>
</div>
</body>
</html>