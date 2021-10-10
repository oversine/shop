<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	// 관리자 회원 후기 삭제 페이지, 관리자 로그인 체크
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

	if(request.getParameter("orderNo") == null){
		response.sendRedirect(request.getContextPath() + "/admin/selectOrderCommentList.jsp");
		return;
	}
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	// System.out.println(noticeNo);
	
	
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	orderCommentDao.deleteOrderComment(orderNo);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectOrderCommentList.jsp");
%>	