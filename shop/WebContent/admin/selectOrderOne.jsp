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
	
	if(request.getParameter("orderNo") == null){
		response.sendRedirect(request.getContextPath() + "/admin/selectOrderList.jsp");
		return;
	}
	
	if(request.getParameter("orderNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/admin/selectOrderList.jsp");
		return;
	}
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<%
		OrderDao orderDao = new OrderDao();
		OrderEbookMember oem = orderDao.selectOrderOne(orderNo);
	%>
	<div>
	<table class="table table-bordered table-dark table-striped">
		<tr>
			<td>주문 번호</td>
			<td><%=oem.getOrder().getOrderNo()%></td>
		</tr>
		<tr>
			<td>책 번호</td>
			<td><%=oem.getEbook().getEbookNo()%></td>
		</tr>
		<tr>
			<td>전자책</td>
			<td><a href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=oem.getEbook().getEbookNo()%>"><%=oem.getEbook().getEbookTitle()%></a></td>
		</tr>
		<tr>
			<td>회원 번호</td>
			<td><%=oem.getMember().getMemberNo()%></td>
		</tr>
		<tr>
			<td>ID</td>
			<td><%=oem.getMember().getMemberId()%></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=oem.getMember().getMemberName()%></td>
		</tr>
		<tr>
			<td>나이</td>
			<td><%=oem.getMember().getMemberAge()%></td>
		</tr>
		<tr>
			<td>성별</td>
			<td><%=oem.getMember().getMemberGender()%></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><%=oem.getOrder().getOrderPrice()%></td>
		</tr>
		<tr>
			<td>생성일</td>
			<td><%=oem.getOrder().getCreateDate()%></td>
		</tr>
		<tr>
			<td>수정일</td>
			<td><%=oem.getOrder().getUpdateDate()%></td>
		</tr>
		<tr>
			<td colspan="2">
				<a class="btn float-right btn-danger" href="<%=request.getContextPath()%>/admin/deleteOrder.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>">삭제</a>
			</td>
		</tr>
	</table>
	</div>
</div>
</body>
</html>