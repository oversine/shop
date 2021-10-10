<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 문의내용 작성 값 공백여부 확인
	if(request.getParameter("memberNo") == null || request.getParameter("updateName") == null || request.getParameter("updateAge") == null || request.getParameter("updateGender") == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		// System.out.println("null");
		return;
	}
	
	if(request.getParameter("memberNo").equals("") || request.getParameter("updateName").equals("") || request.getParameter("updateAge").equals("") || request.getParameter("updateGender").equals("")){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		// System.out.println("none");
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String updatePw = request.getParameter("updatePw");
	String updateName = request.getParameter("updateName");
	int updateAge = Integer.parseInt(request.getParameter("updateAge"));
	String updateGender = request.getParameter("updateGender");
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberPw(updatePw);
	member.setMemberName(updateName);
	member.setMemberAge(updateAge);
	member.setMemberGender(updateGender);

	// System.out.println(member.toString());
	
	memberDao.updateMember(member);
	
	// 문의글 수정 후 해당 문의글로 이동
	response.sendRedirect(request.getContextPath()+"/index.jsp");
%>