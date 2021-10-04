<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");	

	// 문의내용 작성 값 공백여부 확인
	if(request.getParameter("memberNo") == null || request.getParameter("memberId") == null || request.getParameter("qnaCategory").equals("") || request.getParameter("qnaTitle") == null || request.getParameter("qnaContent") == null || request.getParameter("qnaSecret") == null){
		response.sendRedirect(request.getContextPath()+"/insertQnaForm.jsp");
		// System.out.println("null");
		return;
	}
	
	if(request.getParameter("memberNo").equals("") || request.getParameter("memberId").equals("") || request.getParameter("qnaCategory").equals("") || request.getParameter("qnaTitle").equals("") || request.getParameter("qnaContent").equals("") || request.getParameter("qnaSecret").equals("")){
		response.sendRedirect(request.getContextPath()+"/insertQnaForm.jsp");
		// System.out.println("none");
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberId = request.getParameter("memberId");
	String qnaCategory = request.getParameter("qnaCategory");
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaSecret = request.getParameter("qnaSecret");
	
	QnaDao qnaDao = new QnaDao();
	Qna qna = new Qna();
	qna.setMemberNo(memberNo);
	qna.setMemberId(memberId);
	qna.setQnaCategory(qnaCategory);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContent(qnaContent);
	qna.setQnaSecret(qnaSecret);
	
	// System.out.println(qna.toString());
	
	qnaDao.insertQna(qna);
	
	// 문의글 작성 후 문의 내역 리스트 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
%>