<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	// 관리자 회원 강제 탈퇴 페이지, 관리자 로그인 체크
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	MemberDao memberDao = new MemberDao();
	memberDao.deleteMemberByKey(memberNo);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>