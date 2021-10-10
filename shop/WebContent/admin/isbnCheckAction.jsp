<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");	
	
	// 값 공백, NULL 확인
	if(request.getParameter("isbnCheck") == null || request.getParameter("isbnCheck").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		return;
	}
	
	String isbnCheck = request.getParameter("isbnCheck");	
	
	System.out.println(isbnCheck);
	
	EbookDao ebookDao = new EbookDao();
	String result = ebookDao.selectEbookIsbn(isbnCheck);
	
	System.out.println(result);
	
	
	// 들어온 ID값으로 DB 조회를 통해 이미 있는 경우 1이 반환되어 가입폼으로 이동, 없는 경우 입력한 ID값을 파라미터로 보내며 가입폼으로 이동
	if(result == null) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp?isbnCheck="+isbnCheck);
	} else {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
	}
%>