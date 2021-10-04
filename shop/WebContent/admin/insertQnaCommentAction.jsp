<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	request.setCharacterEncoding("utf-8");	
	
	// 문제가 생겨 값이 아예 안들어오거나 공백을 입력받고 넘어온 경우
	if(request.getParameter("qnaNo") == null || request.getParameter("memberNo") == null || request.getParameter("memberId") == null || request.getParameter("qnaComment") == null){
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	if(request.getParameter("qnaNo").equals("") || request.getParameter("memberNo").equals("") || request.getParameter("memberId").equals("") || request.getParameter("qnaComment").equals("")){
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberId = request.getParameter("memberId");
	String qnaCommentContent = request.getParameter("qnaComment");
	
	QnaComment qnaComment = new QnaComment();
	qnaComment.setQnaNo(qnaNo);
	qnaComment.setQnaCommentContent(qnaCommentContent);
	qnaComment.setMemberNo(memberNo);
	qnaComment.setMemberId(memberId);
	
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	qnaCommentDao.insertQnaComment(qnaComment);
	
	// 정상적으로 추가 완료시 문의글 상세 페이지로 이동 
	response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp?qnaNo="+qnaNo);
%>