<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	if(request.getParameter("newPw") == null){
		response.sendRedirect(request.getContextPath() + "/updateMemberPwForm.jsp");
		return;
	}

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String newPw = request.getParameter("newPw");
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberPw(newPw);
	
	memberDao.updateMemberPwByAdimin(member);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>