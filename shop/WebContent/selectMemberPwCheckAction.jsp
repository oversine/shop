<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");	
	
	// No, Pw값 공백, NULL 확인
	if(request.getParameter("memberPwCheck") == null || request.getParameter("memberPwCheck").equals("")){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	if(request.getParameter("memberNo") == null || request.getParameter("memberNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberPwCheck = request.getParameter("memberPwCheck");	
	
	// System.out.println(memberIdCheck);
	
	MemberDao memberDao = new MemberDao();
	int result = memberDao.selectMemberPw(memberNo, memberPwCheck);
	
	System.out.println(result);
	
	
	// 들어온 ID값으로 DB 조회를 통해 이미 있는 경우 1이 반환되어 가입폼으로 이동, 없는 경우 입력한 ID값을 파라미터로 보내며 가입폼으로 이동
	if(result == 0) {
		response.sendRedirect(request.getContextPath()+"/selectMemberOne.jsp?memberNo="+memberNo);
	} else {
		response.sendRedirect(request.getContextPath()+"/selectMemberOne.jsp?memberNo="+memberNo+"&&result="+result);
	}
%>