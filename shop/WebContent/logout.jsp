<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 기존 사용제 세션을 새로운 세션으로 갱신시켜 기존 정보 삭제
	response.sendRedirect(request.getContextPath() + "/index.jsp");
%>