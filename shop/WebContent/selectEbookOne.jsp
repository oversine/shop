<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	request.setCharacterEncoding("utf-8");		

	if(request.getParameter("ebookNo") == null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	if(request.getParameter("ebookNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<%
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	%>
	<div>
	<table class="table table-bordered table-dark table-striped">
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
			<td colspan="2">
			<div>
				<!-- 주문 입력 폼, 비로그인, 로그인 여부 구분 -->
				<%
					Member loginMember = (Member)session.getAttribute("loginMember");
					if (ebook.getEbookState().equals("품절") || ebook.getEbookState().equals("절판") || ebook.getEbookState().equals("구편절판")) {
				%>
						<div>현재 책을 구매하실 수 없습니다.</div>
				<%		
					} else if(loginMember == null) {
				%>		
						<div>
							로그인 후에 주문이 가능합니다. 
							<a class="btn btn-primary" href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a>
						</div>	
				<%		
					} else {
				%>
				<form id="orderForm" method="post" action="<%=request.getContextPath()%>/insertOrderAction.jsp">
					<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
					<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
					<input type="hidden" name="ebookPrice" value="<%=ebook.getEbookPrice()%>">
					<button id="btn" type="button" class="btn btn-primary">주문하기</button>
				</form>
				<script>
					$('#btn').click(function(){
						$('#orderForm').submit();
					});
				</script>
				<%
					}
				%>
			</div>
			</td>
		</tr>
	</table>
	</div>

	<div>
		<h2>상품 후기</h2>
		<!-- 상품 별점의 평균 -->
		<div>
		<%
			OrderCommentDao orderCommentDao = new OrderCommentDao();
			double avgScore = orderCommentDao.selectOrderScoreAvg(ebookNo);
		%>
			<div class="form-group">
				<label for="avgScore">평균 별점 : </label>
				<input type ="text" class="form-control" readonly="readonly" value="<%=avgScore%>">
			</div>
		</div>
		
		<!-- 상품 후기 페이징 -->
		<div>
		<%	
			int commentCurrentPage = 1;
			if(request.getParameter("commentCurrentPage") != null) { 
		  		 commentCurrentPage = Integer.parseInt(request.getParameter("commentCurrentPage"));
				}
			int commentRowPerPage = 10; 
			int beginRow = (commentCurrentPage-1) * commentRowPerPage;
			int startPage = ((commentCurrentPage - 1) / commentRowPerPage) * commentRowPerPage + 1; // 1페이지 1, 11 페이지 ((11-1) / 10) * 10 + 1 = 11... 각 시작 번호
			int endPage = startPage + commentRowPerPage - 1;
			
			ArrayList<OrderComment> orderCommentList = orderCommentDao.selectOrderList(ebookNo, beginRow, commentRowPerPage);
		%>
		<!-- 상품 후기 리스트 -->
		<table class="table table-bordered table-dark table-striped">
		<thead>
			<tr>
				<th>후기</th>
				<th>평점</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
		<% 
			for(OrderComment oc : orderCommentList) {
		%>
			<tr>
				<td><%=oc.getOrderComment()%></td>
				<td><%=oc.getOrderScore()%></td>
				<td><%=oc.getUpdateDate()%></td>
			</tr>
		<% 
			}
		%>
		</tbody>
		</table>
		
		<!-- 페이징 번호 -->
		<div>
		<%	
			if(commentCurrentPage > 1){
		%>	
				<a class="btn btn-secondary" href="./selectEbookOne.jsp?commentCurrentPage=1&ebookNo=<%=ebookNo%>">처음으로</a>
				<a class="btn btn-success" href="./selectEbookOne.jsp?commentCurrentPage=<%=commentCurrentPage-1%>&ebookNo=<%=ebookNo%>">이전</a>
		<%
			}
			int lastPage = orderCommentDao.selectCommentLastPage(ebookNo, commentRowPerPage);
			
			if (endPage > lastPage) { // 총 열 1001로 101페이지 번호가 끝인데 endPage는 110까지 잡혀있는 경우 등, 실제 마지막 번호로 번호 나열을 마치기 위한 조건문 
				endPage = lastPage;
			}
			
			for (int i=startPage; i <= endPage; i++) { // 각 페이지 시작번호 부터 끝번호 까지 반복해 나열
				if(commentCurrentPage == i) { // 현재 페이지 번호만을 다르게 표시해 체크함
		%>
					<a class="btn btn-secondary" href="./selectEbookOne.jsp?commentCurrentPage=<%=i%>&ebookNo=<%=ebookNo%>"><%=i%></a>
		<%
				} else {
		%>
					<a class="btn btn-outline-secondary" href="./selectEbookOne.jsp?commentCurrentPage=<%=i%>&ebookNo=<%=ebookNo%>"><%=i%></a>	
		<%		
				}
			}
			
			
			if(commentCurrentPage < lastPage){ // 현재 페이지가 마지막이 아닌 경우에만 다음과 끝 버튼 출력
		%>	
				<a class="btn btn-primary" href="./selectEbookOne.jsp?commentCurrentPage=<%=commentCurrentPage+1%>&ebookNo=<%=ebookNo%>">다음</a>
				<a class="btn btn-secondary" href="./selectEbookOne.jsp?commentCurrentPage=<%=lastPage%>&ebookNo=<%=ebookNo%>">끝으로</a>
		<%
				}
		%>				
		</div>
		</div>
	</div>
</div>
</body>
</html>