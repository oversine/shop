<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");

	int orderNo = Integer.parseInt(request.getParameter("No"));
	
	if(request.getParameter("orderNo") == null){
		response.sendRedirect(request.getContextPath() + "/admin/selectOrderList.jsp");
		return;
	}
	
	OrderDao orderDao = new OrderDao();
	orderDao.deleteOrder(orderNo);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectOrderList.jsp");
%>