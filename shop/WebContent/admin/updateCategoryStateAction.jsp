<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 상태 값을 수정해야 할 카테고리 값을 받지 못한 경우 리스트 페이지로 강제 이동
	if(request.getParameter("categoryName") == null || request.getParameter("categoryState") == null){
		response.sendRedirect(request.getContextPath() + "/admin/selectCategoryList.jsp");
		return;
	}
	
	if(request.getParameter("categoryName").equals("") || request.getParameter("categoryState").equals("")){
		response.sendRedirect(request.getContextPath() + "/admin/selectCategoryList.jsp");
		return;
	}
	
	String categoryName = request.getParameter("categoryName");
	String categoryState = request.getParameter("categoryState");
	
	
	// 카테고리 상태 값을 Y로 받은 경우 N으로 변경, Y가 아닌 경우 N이므로 Y로 변경 후 값을 전달해 수정 후 리스트로 이동
	if(categoryState.equals("Y") == true) {
		categoryState = "N";
	} else {
		categoryState = "Y";
	}
	
	// 카테고리 관리 페이지에서 변경한 경우 해당 카테고리의 모든 전자책들 상태를 같이 변경해줌 
	CategoryDao categoryDao = new CategoryDao();
	EbookDao ebookDao = new EbookDao();
	
	Category category = new Category();
	Ebook ebook = new Ebook();
	
	category.setCategoryName(categoryName);
	category.setCategoryState(categoryState);
	ebook.setCategoryName(categoryName);
	ebook.setCategoryState(categoryState);
	
	categoryDao.updateCategoryState(category);
	ebookDao.updateEbookCategoryState(ebook);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectCategoryList.jsp");
%>