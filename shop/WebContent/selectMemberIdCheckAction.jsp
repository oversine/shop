<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");	
	
	// ID값 공백, NULL 확인
	if(request.getParameter("memberIdCheck") == null || request.getParameter("memberIdCheck").equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	
	String memberIdCheck = request.getParameter("memberIdCheck");	
	
	// System.out.println(memberIdCheck);
	
	MemberDao memberDao = new MemberDao();
	String result = memberDao.selectMemberId(memberIdCheck);
	
	// System.out.println(result);
	
	if(result == null) {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?memberIdCheck="+memberIdCheck);
	} else {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
	}
%>