<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import ="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");	

	// 후기 작성 값 공백여부 확인
	if(request.getParameter("orderNo") == null || request.getParameter("ebookNo") == null || request.getParameter("orderComment") == null || request.getParameter("orderScore") == null){
		response.sendRedirect(request.getContextPath()+"/selectOrderListByMember.jsp");
		// System.out.println("null");
		return;
	}
	
	if(request.getParameter("orderNo").equals("") || request.getParameter("ebookNo").equals("") || request.getParameter("orderComment").equals("") || request.getParameter("orderScore").equals("")){
		response.sendRedirect(request.getContextPath()+"/selectOrderListByMember.jsp");
		// System.out.println("none");
		return;
	}
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	String comment = request.getParameter("orderComment");	
	int orderScore = Integer.parseInt(request.getParameter("orderScore"));
	
	
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	OrderComment orderComment = new OrderComment();
	orderComment.setOrderNo(orderNo);
	orderComment.setEbookNo(ebookNo);
	orderComment.setOrderComment(comment);
	orderComment.setOrderScore(orderScore);
	
	// System.out.println(orderComment.toString());	

	orderCommentDao.insertOrderComment(orderComment);
	
	// 주문 후기 작성 후 내 주문내역 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/selectOrderListByMember.jsp");
%>