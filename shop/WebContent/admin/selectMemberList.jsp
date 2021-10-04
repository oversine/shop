<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%@ page import = "java.util.*" %>
<%	
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// ID 검색 시 해당 변수값에 검색을 시도한 ID 입력 값 들어옴
	String memberId = "";
	if(request.getParameter("memberId") != null) {
		memberId = request.getParameter("memberId");
	}
	// System.out.println(memberId + "<-- 검색어");
	
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
	
	
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = null;
	
	// 검색을 하지 않은 초기 페이지에서는 전체 회원 리스트, 검색을 행한 경우 해당 키워드를 사용한 쿼리문의 결과 배열
	if(memberId.equals("") == true) {
		memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
	} else {
		memberList = memberDao.selectMemberListAllBySearchMemberId(beginRow, ROW_PER_PAGE, memberId);
		// System.out.println(memberList);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div class="jumbotron text-center">
		<h1>회원 목록</h1>
	</div>
	<table class="table table-striped" style="text-align: center;">
		<thead>
			<tr>
				<th>회원 번호</th>
				<th>ID</th>
				<th>등급</th>
				<th>이름</th>
				<th>나이</th>
				<th>성별</th>
				<th>수정일자</th>
				<th>생성일자</th>
				<th>등급수정</th>
				<th>비밀번호 수정</th>
				<th>회원탈퇴</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Member m : memberList) {
			%>
				<tr>
					<td><%=m.getMemberNo()%></td>
					<td><%=m.getMemberId()%></td>
					<td>
						<% 
							if(m.getMemberLevel() == 0) {
						%>
								<span>회원</span>
						<%
							} else if (m.getMemberLevel() == 1) {
						%>
								<span>관리자</span>
						<%		
							}
						%>
					</td>
					<td><%=m.getMemberName()%></td>
					<td><%=m.getMemberAge()%></td>
					<td><%=m.getMemberGender()%></td>
					<td><%=m.getUpdateDate()%></td>
					<td><%=m.getCreateDate()%></td>
					<td>
						<a class="btn btn btn-primary" href="<%=request.getContextPath()%>/admin/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo()%>">수정</a>
					</td>
					<td>
						<a class="btn btn btn-primary" href="<%=request.getContextPath()%>/admin/updateMemberPwForm.jsp?memberNo=<%=m.getMemberNo()%>">수정</a>
					</td>
					<td>
						<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberNo=<%=m.getMemberNo()%>">탈퇴</a>
					</td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table><br>
	
	<!-- 페이징 번호 -->
	<div style="text-align: center;">
		<%	
			if(currentPage > 1){
		%>	
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=1&memberId=<%=memberId%>>">처음으로</a>
				<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage-1%>&memberId=<%=memberId%>">이전</a>
		<%
			}
			int lastPage = memberDao.selectLastPage(ROW_PER_PAGE, memberId);
			
			if (endPage > lastPage) { // 총 열 1001로 101페이지 번호가 끝인데 endPage는 110까지 잡혀있는 경우 등, 실제 마지막 번호로 번호 나열을 마치기 위한 조건문 
				endPage = lastPage;
			}
			
			for (int i=startPage; i <= endPage; i++) { // 각 페이지 시작번호 부터 끝번호 까지 반복해 나열
				if(currentPage == i) { // 현재 페이지 번호만을 다르게 표시해 체크함
		%>
					<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=i%>&memberId=<%=memberId%>"><%=i%></a>
		<%
				} else {
		%>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=i%>&memberId=<%=memberId%>"><%=i%></a>	
		<%		
				}
			}
			
			
			if(currentPage < lastPage){ // 현재 페이지가 마지막이 아닌 경우에만 다음과 끝 버튼 출력
		%>	
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage+1%>&memberId=<%=memberId%>">다음</a>
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=lastPage%>&memberId=<%=memberId%>">끝으로</a>
		<%
				}
		%>		
		</div><br>
		
		<!-- memberId로 검색 -->
		<div style="text-align: center;">
			<form id="searchMemberIdForm" action="<%=request.getContextPath()%>/admin/selectMemberList.jsp" method="get">
				ID 검색 :
				<input type="text" id="memberId" name="memberId">
				<button id="btn" type="button" class="btn btn-primary">검색</button>
			</form>
		</div>
		
		<script>
			$('#btn').click(function(){
				if($('#memberId').val() == '') {
					alert('검색할 ID를 입력하세요');
					return;
				}
				$('#searchMemberIdForm').submit();
			});
		</script>
</body>
</html>