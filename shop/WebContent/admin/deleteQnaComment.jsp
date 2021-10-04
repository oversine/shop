<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	// 관리자 회원 문의 답변 삭제 페이지, 관리자 로그인 체크
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

	if(request.getParameter("qnaCommentNo") == null || request.getParameter("qnaNo") == null){
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	int qnaCommentNo = Integer.parseInt(request.getParameter("qnaCommentNo"));
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	// System.out.println(qnaCommentNo);
	// System.out.println(qnaNo);
	
	
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	qnaCommentDao.deleteQnaComment(qnaCommentNo);
	
	response.sendRedirect(request.getContextPath()+"/selectQnaOne.jsp?qnaNo="+qnaNo);
%>	