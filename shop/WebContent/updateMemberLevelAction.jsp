<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath() + "/updateMemberLevelForm.jsp");
		return;
	}

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberLevel(memberLevel);
	
	memberDao.updateMemberPwByAdimin(member);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>