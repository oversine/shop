<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- request 대신 사용됨 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 파일 이름 중복 방지 라이브러리 -->
<%	
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	MultipartRequest mr = new MultipartRequest(request, "C:/Users/subin/Downloads/git/shop/WebContent/image", 1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	// 문제가 생겨 값이 아예 안들어오거나 공백을 입력받고 넘어온 경우
	if(mr.getParameter("ebookNo") == null || mr.getParameter("ebookPrice") == null){
			response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
			return;
	}
		
	if(mr.getParameter("ebookNo").equals("") || mr.getParameter("ebookPrice").equals("")){
			response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
			return;
	}
	
	int ebookNo = Integer.parseInt(mr.getParameter("ebookNo"));
	int ebookPrice = Integer.parseInt(mr.getParameter("ebookPrice"));
	String ebookImg = mr.getFilesystemName("ebookImg");
	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookImg(ebookImg);
	
	EbookDao ebookDao = new EbookDao();
	ebookDao.updateEbook(ebook);
	
	response.sendRedirect(request.getContextPath() + "/admin/selectEbookOne.jsp?ebookNo=" + ebookNo);
%>