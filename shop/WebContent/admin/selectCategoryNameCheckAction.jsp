<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");	
	
	// 카테고리명 값 공백, NULL 확인 후 없는 경우 입력 페이지로 강제 이동
	if(request.getParameter("categoryNameCheck") == null || request.getParameter("categoryNameCheck").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp");
		return;
	}
	
	String categoryNameCheck = request.getParameter("categoryNameCheck");	
	
	// System.out.println(categoryNameCheck);
	
	CategoryDao categoryDao = new CategoryDao();
	String result = categoryDao.selectCategoryName(categoryNameCheck);
	
	// System.out.println(result);
	
	// 입력된 카테고리로 DB 조회를 끝내고 DB에 같은 값이 있는 경우 result에 해당 값이 반환되고, 없는 경우 null이 반환되므로 null인 경우 입력된 카테고리 값을 파라미터로 다시 전달해 중복체크 구현
	if(result == null) {
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp?categoryNameCheck="+categoryNameCheck);
	} else {
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp");
	}
%>