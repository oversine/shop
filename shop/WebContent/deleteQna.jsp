<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1 && Integer.parseInt(request.getParameter("memberNo")) != loginMember.getMemberNo()) {
		response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
		return;
	}

	if(request.getParameter("qnaNo") == null){
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	// System.out.println(qnaNo);
	
	QnaDao qnaDao = new QnaDao();
	qnaDao.deleteQna(qnaNo);
	
	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
%>	