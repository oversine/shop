<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	request.setCharacterEncoding("utf-8");	
	
	// 문제가 생겨 값이 아예 안들어오거나 공백을 입력받고 넘어온 경우
	if(request.getParameter("categoryName") == null || request.getParameter("categoryState") == null){
		response.sendRedirect(request.getContextPath() + "/admin/insertCategoryForm.jsp");
		return;
	}
	
	if(request.getParameter("categoryName").equals("") || request.getParameter("categoryState").equals("")){
		response.sendRedirect(request.getContextPath() + "/admin/insertCategoryForm.jsp");
		return;
	}
	
	String categoryName = request.getParameter("categoryName");
	String categoryState = request.getParameter("categoryState");
	
	// System.out.println(categoryName + " <-- categoryName");
	// System.out.println(categoryState + " <-- categoryState");
	
	Category category = new Category();
	category.setCategoryName(categoryName);
	category.setCategoryState(categoryState);
	
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.insertCategory(category);
	
	// 정상적으로 추가 완료시 카테고리 리스트 페이지로 이동 
	response.sendRedirect(request.getContextPath() + "/admin/selectCategoryList.jsp");
%>