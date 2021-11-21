<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<%@ page import ="vo.*"%>
<%
	if(session.getAttribute("loginMember") == null) {
%>		
		<!-- Responsive navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></li>
						<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></li>              
                    </ul>
                </div>
            </div>
        </nav>
<%		
	} else {		
		Member loginMember = (Member)session.getAttribute("loginMember");
%>		
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<div class="container">
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
<%		
					if(loginMember.getMemberLevel() > 0) {
%>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자 페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지사항 작성</a></li>	
<%		
					} else {
%>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp">내 주문현황</a></li>
<%
					}
%>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>
					</ul>
				</div>
			</div>	
		</nav>
<%
	}
%>	
