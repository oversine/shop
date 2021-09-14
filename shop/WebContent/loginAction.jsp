<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%	
	request.setCharacterEncoding("utf-8");
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	//System.out.println(memberId);
	//System.out.println(memberPw);
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	Member returnMember = memberDao.login(member);
	
	// 로그인 성공시 ID, 비밀번호 값, 실패시 null
	if(returnMember == null) {
		System.out.println("실패");
		response.sendRedirect("./loginForm.jsp");
		return;
	} else {
		System.out.println("성공");
		System.out.println(returnMember.getMemberId() + "<-- id");
		System.out.println(returnMember.getMemberLevel() + "<-- level");
		
		// request, session 등의 내부에 이미 만들어져있는 변수를 JSP내장 객체라고 칭함
		// 나만의 공간에 변수를 생성 (session)
		session.setAttribute("loginMember", returnMember);
		response.sendRedirect("./index.jsp");
		return;
	}
%>