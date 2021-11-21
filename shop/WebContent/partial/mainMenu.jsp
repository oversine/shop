<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!-- Responsive navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">Book Store</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/selectNoticeList.jsp">공지사항</a></li>
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/selectQnaList.jsp">QnA</a></li>
						<%
						// 관리자가 N을 체크해 비활성화 하지 않은 카테고리명 하나를 DB조회를 통해 가져옴
							CategoryDao categoryDao = new CategoryDao();
							String categoryName = categoryDao.selectCategory();
						%>
						<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/selectEbookList.jsp?categoryName=<%=categoryName%>">전자책 구매</a></li>
						<% 
							if(session.getAttribute("loginMember") != null) {
						%>
								<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/selectMemberOne.jsp?memberNo=<%=loginMember.getMemberNo()%>">회원정보 수정</a></li>
						<%		
							}
						%>                        
                    </ul>
                </div>
            </div>
        </nav>
