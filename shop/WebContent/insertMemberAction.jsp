<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	request.setCharacterEncoding("utf-8");	

	//로그인 상태에서 회원가입 페이지 접근 불가
	if(session.getAttribute("loginMember") != null){
		// 이전 웹 브라우저로 돌아가 다른 곳을 요청하도록 하는 메서드
		response.sendRedirect("./index.jsp");
	}
	
	
	// 문제가 생겨 값이 아예 안들어오거나 공백을 입력받고 넘어온 경우
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberAge") == null || request.getParameter("memberGender") == null || request.getParameter("memberName") == null){
		response.sendRedirect("./index.jsp");
		return;
	}
	
	if(request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberAge").equals("") || request.getParameter("memberGender").equals("") || request.getParameter("memberName").equals("")){
		response.sendRedirect("./insertMemberForm.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	String memberName = request.getParameter("memberName");
	
	// System.out.println(memberId + " <-- memberId");
	// System.out.println(memberPw + " <-- memberPw");
	// System.out.println(memberAge + " <-- memberAge");
	// System.out.println(memberGender + " <-- memberGender");
	// System.out.println(memberName + " <-- memberName");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberAge(memberAge);
	member.setMemberGender(memberGender);
	member.setMemberName(memberName);
	
	MemberDao memberDao = new MemberDao();
	
	memberDao.insertMember(member);
	
	response.sendRedirect("./index.jsp");
%>