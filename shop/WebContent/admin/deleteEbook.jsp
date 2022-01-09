<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	// 관리자 전자책 삭제 페이지, 관리자 로그인 체크
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}	

	if(request.getParameter("ebookNo") == null){
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
		return;
	}
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	EbookDao ebookDao = new EbookDao();
	ebookDao.deleteEbook(ebookNo);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectOrderList.jsp");
%>