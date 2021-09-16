<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	MemberDao memberDao = new MemberDao();
	memberDao.deleteMemberByKey(memberNo);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>