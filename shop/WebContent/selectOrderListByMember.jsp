<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	int memberNo = loginMember.getMemberNo();
	// System.out.println(memberNo + "<-- memberNo");
	
	OrderDao orderDao = new OrderDao();
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderListByMember(memberNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
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
		<h1>내 주문내역</h1>
	</div>
		<table class="table table-striped" style="text-align: center;">
		<thead>
			<tr>
				<th>주문번호</th>
				<th>전자책</th>
				<th>가격</th>
				<th>주문일자</th>
				<th>상품후기</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(OrderEbookMember oem : list) {
			%>
				<tr>
					<td><%=oem.getOrder().getOrderNo()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/selectOrderOne.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>"><%=oem.getEbook().getEbookTitle()%></a></td>
					<td><%=oem.getOrder().getOrderPrice()%></td>
					<td><%=oem.getOrder().getCreateDate()%></td>
			<%
				// 상품후기 작성 여부 체크, DB 조회를 통해 후기를 이미 작성한 경우 1값이 반환되어 else 결과, 작성하지 않아 0인 경우 후기 작성 가능
				if(orderCommentDao.selectCheckCommentReview(oem.getOrder().getOrderNo(), oem.getEbook().getEbookNo()) == 0) {
			%>
					<td><a href="<%=request.getContextPath()%>/insertOrderCommentForm.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>&ebookNo=<%=oem.getEbook().getEbookNo()%>">주문후기</a></td>
			<%
				} else {
			%>
				<td>상품후기 입력완료</td>
			<%
				}
			%>		
				</tr>
			<%
				}
			%>
		</tbody>
		</table>
</div>
</body>
</html>