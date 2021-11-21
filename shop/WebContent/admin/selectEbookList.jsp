<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매 전자책 리스트</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="css/styles.css" rel="stylesheet" />
</head>
<body>
<div class="container">
<%	
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// EbookDao의 조회 메서드를 그대로 사용해 전체 전자책 목록 페이징하기 위한 변수 고정 공백값
	String ebookTitle = "";
	
	// 카테고리 선택 시 페이지로 다시 넘어오게 될 변수값
	String categoryName = "";

	if(request.getParameter("categoryName") != null) {
		categoryName = request.getParameter("categoryName");
	}
	
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
	
	// 카테고리 선택을 위한 배열 생성
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// 전체 or 특정 카테고리 리스트 출력을 위한 배열
	EbookDao ebookDao = new EbookDao();
	ArrayList<Ebook> ebookList = null;
	
	// 초기, 전체 카테고리 선택 시 전체 리스트 / 카테고리 선택 시 해당 카테고리 리스트
	if(categoryName.equals("")) {
		ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
	} else {
		ebookList = ebookDao.selectEbookListByCategory(categoryName, beginRow, ROW_PER_PAGE);
		// System.out.println(ebookList);
	}
%>
	<div>
		<jsp:include page="/partial/memberMenu.jsp"></jsp:include>
	</div>
	
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	
	<div class="jumbotron text-center">
		<h1>전자책 관리</h1>
	</div>
	
	<!-- 카테고리 목록에서 특정 카테고리 선택시 onchange="this.form.submit()" 를 통해 선택 직후 submit 처리되어 카테고리 값이 해당 페이지로 전달됨 -->
	<form action="<%=request.getContextPath()%>/admin/selectEbookList.jsp">
		<select name="categoryName" class="custom-select" onchange="this.form.submit()">
		<option value="" style="display:none">카테고리 목록</option>
		<option value="">전체목록</option>
			<%
				for(Category c : categoryList) {
					if(c.getCategoryState().equals("Y")) {
			%>
					<option value="<%=c.getCategoryName()%>"><%=c.getCategoryName()%></option>
			<%	
					}
				}
			%>
		</select>
	</form>
	
	<!-- 전자책 목록 출력 : 카테고리별 출력 -->
	<table class="table table-striped" style="text-align: center;">
		<thead>
			<tr>
				<th>전자책 번호</th>
				<th>카테고리</th>
				<th>도서명</th>
				<th>도서 판매현황</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Ebook e : ebookList) {
			%>
				<tr>
					<td><%=e.getEbookNo()%></td>
					<td><%=e.getCategoryName()%></td>
					<td>
						<a href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a>
					</td>
					<td><%=e.getEbookState()%></td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<div>
		<a class="btn btn-primary" href="<%=request.getContextPath()%>/admin/insertEbookForm.jsp">판매 전자책 추가</a>
	</div><br>
	
	<!-- 페이징 번호 -->
	<div style="text-align: center;">
		<%	
			if(currentPage > 1){
		%>	
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=1&categoryName=<%=categoryName%>">처음으로</a>
				<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">이전</a>
		<%
			}
			int lastPage = ebookDao.selectLastPage(ROW_PER_PAGE, categoryName, ebookTitle);
			
			if (endPage > lastPage) { // 총 열 1001로 101페이지 번호가 끝인데 endPage는 110까지 잡혀있는 경우 등, 실제 마지막 번호로 번호 나열을 마치기 위한 조건문 
				endPage = lastPage;
			}
			
			for (int i=startPage; i <= endPage; i++) { // 각 페이지 시작번호 부터 끝번호 까지 반복해 나열
				if(currentPage == i) { // 현재 페이지 번호만을 다르게 표시해 체크함
		%>
					<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&categoryName=<%=categoryName%>"><%=i%></a>
		<%
				} else {
		%>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&categoryName=<%=categoryName%>"><%=i%></a>	
		<%		
				}
			}
			
			
			if(currentPage < lastPage){ // 현재 페이지가 마지막이 아닌 경우에만 다음과 끝 버튼 출력
		%>	
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">다음</a>
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=lastPage%>&categoryName=<%=categoryName%>">끝으로</a>
		<%
				}
		%>		
	</div>
</div>	
</body>
</html>