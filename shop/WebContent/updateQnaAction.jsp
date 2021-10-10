<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 문의내용 작성 값 공백여부 확인
	if(request.getParameter("qnaNo") == null || request.getParameter("qnaCategory") == null || request.getParameter("qnaTitle") == null || request.getParameter("qnaContent") == null || request.getParameter("qnaSecret") == null){
		response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
		// System.out.println("null");
		return;
	}
	
	if(request.getParameter("qnaNo").equals("") || request.getParameter("qnaCategory").equals("") || request.getParameter("qnaTitle").equals("") || request.getParameter("qnaContent").equals("") || request.getParameter("qnaSecret").equals("")){
		response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
		// System.out.println("none");
		return;
	}
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	String qnaCategory = request.getParameter("qnaCategory");
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaSecret = request.getParameter("qnaSecret");
	
	QnaDao qnaDao = new QnaDao();
	Qna qna = new Qna();
	qna.setQnaNo(qnaNo);
	qna.setQnaCategory(qnaCategory);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContent(qnaContent);
	qna.setQnaSecret(qnaSecret);

	// System.out.println(qna.toString());
	
	qnaDao.updateQna(qna);
	
	// 문의글 수정 후 해당 문의글로 이동
	response.sendRedirect(request.getContextPath()+"/selectQnaOne.jsp?qnaNo="+qnaNo);
%>