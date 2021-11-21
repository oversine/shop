<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면</title>
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
	<%	
	// 검색어
	String ebookTitle = "";
	if(request.getParameter("ebookTitle") != null) {
		ebookTitle = request.getParameter("ebookTitle");
	}
	// System.out.println(ebookTitle + "<-- 메인 화면 책 검색 키워드");
	
	// 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// System.out.println(currentPage + "<-- Page");
	
	// EbookDao의 조회 메서드를 그대로 사용해 전체 전자책 목록 페이징하기 위한 카테고리 변수 고정 공백값
	String categoryName = "";
	
	final int ROW_PER_PAGE = 15; // 변수 10으로 한번 초기화되면 종료까지 10 유지, 상수 표기법
	int beginRow = (currentPage-1) * ROW_PER_PAGE;
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1; // 1페이지 1, 11 페이지 ((11-1) / 10) * 10 + 1 = 11... 각 시작 번호
	int endPage = startPage + ROW_PER_PAGE - 6;
	
	EbookDao ebookDao = new EbookDao();
	NoticeDao noticeDao = new NoticeDao();
	
	ArrayList<Ebook> ebookList = null;
	
	
	// 인기 목록 5개
	ArrayList<Ebook> popularEbookList = ebookDao.selectPopularEbookList();
	// 신규책 목록 5개
	ArrayList<Ebook> newEbookList = ebookDao.selectNewEbookList();
	
	// 신규 공지사항 목록 5개
	ArrayList<Notice> newNoticeList = noticeDao.selectNewNoticeList();
	
	
	// 전자책 검색 결과 키워드 공백인 초기의 경우 전체 리스트, 검색 시도시 해당 키워드 결과 리스트 
	if(ebookTitle.equals("") == true) {
		ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
	} else {
		ebookList = ebookDao.selectEbookListBySearchEbookTitle(categoryName, beginRow, ROW_PER_PAGE, ebookTitle);
	}
	%>

	<div class="row">
		<div class="col-lg-6">
			<div class="card mb-4">
				<div class="card-header">신규 상품 목록</div>
				<div class="table-responsive">
					<table class="card-table table" style="text-align: center;">
						<tr>
							<%	
								int a = 0;
								for(Ebook e : newEbookList) {
							%>
									<td>
										<div>
											<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
										</div>
										<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
										<div>
											<%=e.getEbookPrice()%>	
										</div>
									</td>
							<%
								}
							%>
						</tr>
					</table>
				</div>
			</div>
		</div>
		
		<div class="col-lg-6">
			<div class="card mb-4">
				<div class="card-header">신규 공지사항</div>
				<div class="table-responsive">
					<table class="table table-striped" style="text-align: center;">
						<%
							for(Notice n : newNoticeList) {
						%>
							<tr>
								<td><%=n.getNoticeNo()%></td>
								<td><a href="<%=request.getContextPath()%>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
								<td><%=n.getUpdateDate()%></td>
							</tr>
						<%
							}
						%>
					</table>					
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<div class="card mb-4">
				<div class="card-header">인기 상품 목록</div>
				<div class="table-responsive">
					<table class="card-table table" style="text-align: center;">
						<tr>
							<%	
								int b = 0;
								for(Ebook e : popularEbookList) {
							%>
									<td>
										<div>
											<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
										</div>
										<div><a href=""><%=e.getEbookTitle()%></a></div>
										<div>
											<%=e.getEbookPrice()%>	
										</div>
									</td>
							<%		
								}
							%>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>	
	
	<div class="row">
		<div class="col-lg-12">
			<div class="card mb-4">
				<div class="card-header">전체 상품 목록</div>
				<div class="table-responsive">
					<!-- 전자책 목록 출력 -->
					<table class="card-table table" style="text-align: center;">
						<tr>
							<%	
								int i = 0;
								for(Ebook e : ebookList) {
							%>
									<td>
										<div>
											<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
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
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 페이징 번호 -->
	<div style="text-align: center;">
		<%	
			if(currentPage > 1){
		%>	
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=1&ebookTitle=<%=ebookTitle%>">처음으로</a>
				<a class="btn btn-success" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage-1%>&ebookTitle=<%=ebookTitle%>">이전</a>
		<%
			}
			int lastPage = ebookDao.selectLastPage(ROW_PER_PAGE, categoryName, ebookTitle);
			
			if (endPage > lastPage) { // 총 열 1001로 101페이지 번호가 끝인데 endPage는 110까지 잡혀있는 경우 등, 실제 마지막 번호로 번호 나열을 마치기 위한 조건문 
				endPage = lastPage;
			}
			
			for (int j = startPage; j <= endPage; j++) { // 각 페이지 시작번호 부터 끝번호 까지 반복해 나열
				if(currentPage == j) { // 현재 페이지 번호만을 다르게 표시해 체크함
		%>
					<a class="btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=j%>&ebookTitle=<%=ebookTitle%>"><%=j%></a>
		<%
				} else {
		%>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=j%>&ebookTitle=<%=ebookTitle%>"><%=j%></a>	
		<%		
				}
			}
			
			
			if(currentPage < lastPage){ // 현재 페이지가 마지막이 아닌 경우에만 다음과 끝 버튼 출력
		%>	
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage+1%>&ebookTitle=<%=ebookTitle%>">다음</a>
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=lastPage%>&ebookTitle=<%=ebookTitle%>">끝으로</a>
		<%
				}
		%>		
	</div><br>
	
	<!-- 검색 -->
	<div style="text-align: center;">
		<form id="mainSearchEbookForm" action="<%=request.getContextPath()%>/index.jsp" method="get">
			책 검색 :
			<input type="text" id="ebookTitle" name="ebookTitle">
			<button id="btn" type="button" class="btn btn-primary">검색</button>
		</form>
		
		<script>
			$('#btn').click(function(){
				if($('#ebookTitle').val() == '') {
					alert('검색할 책 제목을 입력하세요');
					return;
				}
				$('#mainSearchEbookForm').submit();
			});
		</script>
	</div>
</div>
</body>
</html>