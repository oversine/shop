<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	request.setCharacterEncoding("utf-8");	

	// 문제가 생겨 값이 아예 안들어오거나 공백을 입력받고 넘어온 경우
	if(request.getParameter("ebookNo") == null || request.getParameter("memberNo") == null || request.getParameter("ebookPrice") == null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	if(request.getParameter("ebookNo").equals("") || request.getParameter("memberNo").equals("") || request.getParameter("ebookPrice").equals("")){
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
		return;
	}
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int orderPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	
	Order order = new Order();
	order.setEbookNo(ebookNo);
	order.setMemberNo(memberNo);
	order.setOrderPrice(orderPrice);
	
	OrderDao orderDao = new OrderDao();
	orderDao.insertMemberOrder(order);
	
	// 주문을 완료한 뒤 내 주문내역 페이지로 이동
	response.sendRedirect(request.getContextPath() + "/selectOrderListByMember.jsp");
%>