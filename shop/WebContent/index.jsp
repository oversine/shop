<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div class="jumbotron text-center">
	<h1>메인페이지</h1>
	</div>
	<% 
		if(session.getAttribute("loginMember") == null){
	%>
			<div><a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></div>
			<div><a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></div>
	<%		
		} else {
			// 형변환을 사용해 어떤 타입인지 선언필요`
			Member loginMember = (Member)session.getAttribute("loginMember");
	%>	
	<%	
			if(loginMember.getMemberLevel() > 0) {
	%>
				<div><a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자 페이지</a></div>
	<%			
			}
	%>
			<div><%=loginMember.getMemberId()%>님 반갑습니다.</div>
			<div><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></div>
	<%	
		}
	%>
	<!-- 상품 목록 -->
	<%	
	// 검색어
	String ebookTitle = "";
	if(request.getParameter("ebookTitle") != null) {
		ebookTitle = request.getParameter("ebookTitle");
	}
	// System.out.println(memberId + "<-- 검색어");
	
	// 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// System.out.println(currentPage + "<-- Page");
	
	// EbookDao의 조회 메서드를 그대로 사용하기 위한 카테고리 변수 공백값
	String categoryName = "";
	
	final int ROW_PER_PAGE = 20; // 변수 10으로 한번 초기화되면 종료까지 10 유지, 상수 표기법
	int beginRow = (currentPage-1) * ROW_PER_PAGE;
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1; // 1페이지 1, 11 페이지 ((11-1) / 10) * 10 + 1 = 11... 각 시작 번호
	int endPage = startPage + ROW_PER_PAGE - 1;
	
	EbookDao ebookDao = new EbookDao();
	ArrayList<Ebook> ebookList = null;
	
	
	if(ebookTitle.equals("") == true) {
		ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
	} else {
		ebookList = ebookDao.selectEbookListBySearchEbookTitle(beginRow, ROW_PER_PAGE, ebookTitle);
	}
	
	
	%>

	<!-- 전자책 목록 출력 : 카테고리별 출력 -->
	<table class="table table-striped" style="text-align: center;">
		<tr>
			<%	
				int i = 0;
				for(Ebook e : ebookList) {
			%>
					<td>
						<div>
							<a href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/img/<%=e.getEbookImg()%>" width="200" height="200"></a>
						</div>
						<div>
							<%=e.getEbookTitle()%>
						</div>
						<div>
							<%=e.getEbookPrice()%>	
						</div>
					</td>
			<%		
					// 한 전자책을 불러오고 1을 증가시키며 반복하다 5개를 불러온 경우 <tr></tr>을 통해 상품의 줄바꿈처리를 해 5개씩 가로 배열
					i+=1;
					if(i%5 == 0) {
			%>
						</tr><tr>
			<%
					}
				}
			%>
		</tr>
	</table><br>
	
	<!-- 페이징 번호 -->
	<div style="text-align: center;">
		<%	
			if(currentPage > 1){
		%>	
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=1">처음으로</a>
				<a class="btn btn-success" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			int lastPage = ebookDao.selectLastPage(ROW_PER_PAGE, categoryName);
			
			if (endPage > lastPage) { // 총 열 1001로 101페이지 번호가 끝인데 endPage는 110까지 잡혀있는 경우 등, 실제 마지막 번호로 번호 나열을 마치기 위한 조건문 
				endPage = lastPage;
			}
			
			for (int j = startPage; j <= endPage; j++) { // 각 페이지 시작번호 부터 끝번호 까지 반복해 나열
				if(currentPage == j) { // 현재 페이지 번호만을 다르게 표시해 체크함
		%>
					<a class="btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=j%>"><%=j%></a>
		<%
				} else {
		%>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=j%>"><%=j%></a>	
		<%		
				}
			}
			
			
			if(currentPage < lastPage){ // 현재 페이지가 마지막이 아닌 경우에만 다음과 끝 버튼 출력
		%>	
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage+1%>>">다음</a>
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=lastPage%>">끝으로</a>
		<%
				}
		%>		
	</div>
	
	<!-- 검색 -->
	<div style="text-align: center;">
		<form action="<%=request.getContextPath()%>/index.jsp" method="get">
			책 검색 :
			<input type="text" name="ebookTitle">
			<button type="submit" class="btn btn-primary">검색</button>
		</form>
	</div>
</div>
</body>
</html>