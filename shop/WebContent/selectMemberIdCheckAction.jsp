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
	
	
	// 들어온 ID값으로 DB 조회를 통해 이미 있는 경우 1이 반환되어 가입폼으로 이동, 없는 경우 입력한 ID값을 파라미터로 보내며 가입폼으로 이동
	if(result == null) {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?memberIdCheck="+memberIdCheck);
	} else {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
	}
%>