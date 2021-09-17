<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%@ page import = "java.util.*" %>
<%	
	request.setCharacterEncoding("utf-8");		
	
	// 로그인 회원 관리자 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 목록</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div class="jumbotron text-center">
		<h1>카테고리 목록</h1>
	</div>
	<table class="table table-striped" style="text-align: center;">
		<thead>
			<tr>
				<th>카테고리</th>
				<th>카테고리 사용 여부</th>
				<th>updateDate</th>
				<th>createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Category c : categoryList) { // 카테고리 테이블 데이터 최대 개수만큼 반복
			%>
				<tr>
					<td><%=c.getCategoryName()%></td>
					<!-- 선택한 카테고리명과 현재 상태값 전달-->
					<td>
						<a class="btn btn btn-primary" href="<%=request.getContextPath()%>/admin/updateCategoryStateAction.jsp?categoryName=<%=c.getCategoryName()%>&categoryState=<%=c.getCategoryState()%>"><%=c.getCategoryState()%></a></td>
					<td><%=c.getUpdateDate()%></td>
					<td><%=c.getCreateDate()%></td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<div>
		<a class="btn btn-primary" href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가</a>
	</div>
</div>	
</body>
</html>