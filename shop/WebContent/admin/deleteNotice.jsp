<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	// 관리자 공지사항 삭제 페이지, 관리자 로그인 체크
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

	if(request.getParameter("noticeNo") == null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// System.out.println(noticeNo);
	
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.deleteNotice(noticeNo);
	
	response.sendRedirect(request.getContextPath()+"/admin/adminIndex.jsp");
%>	