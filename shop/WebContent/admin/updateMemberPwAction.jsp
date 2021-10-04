<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 변경할 비밀번호 값을 입력하지 않고 공백상태로 시도한 경우 수정 폼 페이지로 강제 이동
	if(request.getParameter("memberNo") == null || request.getParameter("newPw") == null){
		response.sendRedirect(request.getContextPath() + "/admin/updateMemberPwForm.jsp");
		return;
	}
	
	if(request.getParameter("memberNo").equals("") || request.getParameter("newPw").equals("")){
		response.sendRedirect(request.getContextPath() + "/admin/updateMemberPwForm.jsp");
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