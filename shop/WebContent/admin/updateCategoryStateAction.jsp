<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 상태 값을 수정해야 할 카테고리 값을 받지 못한 경우 리스트 페이지로 강제 이동
	if(request.getParameter("categoryName") == null){
		response.sendRedirect(request.getContextPath() + "/admin/selectCategoryList.jsp");
		return;
	}
	
	String categoryName = request.getParameter("categoryName");
	String categoryState = request.getParameter("categoryState");
	
	
	// 카테고리 상태 값을 Y로 받은 경우 N으로 변경, Y가 아닌 경우 N이므로 Y로 변경 후 값을 전달해 수정
	if(categoryState.equals("Y") == true) {
		categoryState = "N";
	} else {
		categoryState = "Y";
	}
	
	CategoryDao categoryDao = new CategoryDao();
	Category category = new Category();
	category.setCategoryName(categoryName);
	category.setCategoryState(categoryState);
	
	categoryDao.updateCategoryState(category);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectCategoryList.jsp");
%>