<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	if(request.getParameter("memberPw") == null){
		response.sendRedirect(request.getContextPath() + "/updateMemberPwForm.jsp");
		return;
	}

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberPw = request.getParameter("memberPw");
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberPw(memberPw);
	
	memberDao.updateMemberPwByAdimin(member);
%>