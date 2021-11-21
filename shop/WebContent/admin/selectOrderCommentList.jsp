<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	request.setCharacterEncoding("utf-8");		
	
	// 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// System.out.println(currentPage + "<-- Page");
		
	final int ROW_PER_PAGE = 10; // 변수 10으로 한번 초기화되면 종료까지 10 유지, 상수 표기법
	int beginRow = (currentPage-1) * ROW_PER_PAGE;
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1; // 1페이지 1, 11 페이지 ((11-1) / 10) * 10 + 1 = 11... 각 시작 번호
	int endPage = startPage + ROW_PER_PAGE - 1;
	
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	ArrayList<OrderComment> list = orderCommentDao.selectOrderAllList(beginRow, ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 후기</title>
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
	
	<div class="jumbotron text-center">
		<h1>회원 후기 확인 게시판</h1>
	</div>
	<table class="table table-striped" style="text-align: center;">
		<thead>
			<tr>
				<th>주문번호</th>
				<th>전자책 번호</th>
				<th>평점</th>
				<th>후기</th>
				<th colspan="2">작성일</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(OrderComment orderComment : list) {
			%>
				<tr>
					<td><%=orderComment.getOrderNo()%></td>
					<td>
						<a href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=orderComment.getEbookNo()%>"><%=orderComment.getEbookNo()%></a>
					</td>
					<td><%=orderComment.getOrderScore()%></td>
					<td><%=orderComment.getOrderComment()%></td>
					<td><%=orderComment.getUpdateDate()%></td>
					<td>
						<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteOrderComment.jsp?orderNo=<%=orderComment.getOrderNo()%>">삭제</a>
					</td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
	
	<!-- 페이징 번호 -->
	<div style="text-align: center;">
		<%	
			if(currentPage > 1){
		%>	
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectOrderCommentList.jsp?currentPage=1">처음으로</a>
				<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectOrderCommentList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			int lastPage = orderCommentDao.selectCommentAllLastPage(ROW_PER_PAGE);
			
			if (endPage > lastPage) { // 총 열 1001로 101페이지 번호가 끝인데 endPage는 110까지 잡혀있는 경우 등, 실제 마지막 번호로 번호 나열을 마치기 위한 조건문 
				endPage = lastPage;
			}
			
			for (int i = startPage; i <= endPage; i++) { // 각 페이지 시작번호 부터 끝번호 까지 반복해 나열
				if(currentPage == i) { // 현재 페이지 번호만을 다르게 표시해 체크함
		%>
					<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectOrderCommentList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
				} else {
		%>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/admin/selectOrderCommentList.jsp?currentPage=<%=i%>"><%=i%></a>	
		<%		
				}
			}
			
			
			if(currentPage < lastPage){ // 현재 페이지가 마지막이 아닌 경우에만 다음과 끝 버튼 출력
		%>	
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/admin/selectOrderCommentList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectOrderCommentList.jsp?currentPage=<%=lastPage%>">끝으로</a>
		<%
				}
		%>		
	</div>
</div>
</body>
</html>