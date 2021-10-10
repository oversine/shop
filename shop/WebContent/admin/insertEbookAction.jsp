<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- request 대신 사용됨 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 파일 이름 중복 방지 라이브러리 -->
<%
	request.setCharacterEncoding("utf-8");	
	
	MultipartRequest mr = new MultipartRequest(request, "C:/Users/subin/Downloads/git/shop/WebContent/image", 1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	// System.out.println(mr.getParameter("ebookIsbn"));
	// System.out.println(mr.getParameter("categoryName"));
	// System.out.println(mr.getParameter("ebookTitle"));
	// System.out.println(mr.getParameter("ebookAuthor"));
	// System.out.println(mr.getParameter("ebookCompany"));
	// System.out.println(mr.getParameter("ebookPageCount"));
	// System.out.println(mr.getParameter("ebookPrice"));
	// System.out.println(mr.getFilesystemName("ebookImg"));
	// System.out.println(mr.getParameter("ebookSummary"));
	// System.out.println(mr.getParameter("ebookState"));
	
	// 문제가 생겨 값이 아예 안들어오거나 공백을 입력받고 넘어온 경우
	if(mr.getParameter("ebookIsbn") == null || mr.getParameter("categoryName") == null || mr.getParameter("ebookTitle") == null || mr.getParameter("ebookAuthor") == null || mr.getParameter("ebookCompany") == null || mr.getParameter("ebookPageCount") == null || mr.getParameter("ebookPrice") == null || mr.getFilesystemName("ebookImg") == null || mr.getParameter("ebookSummary") == null || mr.getParameter("ebookState") == null){
		response.sendRedirect(request.getContextPath() + "/admin/insertEbookForm.jsp");
		return;
	}
	
	if(mr.getParameter("ebookIsbn").equals("") || mr.getParameter("categoryName").equals("") || mr.getParameter("ebookTitle").equals("") || mr.getParameter("ebookAuthor").equals("") || mr.getParameter("ebookCompany").equals("") || mr.getParameter("ebookPageCount").equals("") || mr.getParameter("ebookPrice").equals("") || mr.getFilesystemName("ebookImg").equals("") || mr.getParameter("ebookSummary").equals("") || mr.getParameter("ebookState").equals("")){
		response.sendRedirect(request.getContextPath() + "/admin/insertEbookForm.jsp");
		return;
	}
	
	String ebookIsbn = mr.getParameter("ebookIsbn");
	String categoryName = mr.getParameter("categoryName");
	String ebookTitle = mr.getParameter("ebookTitle");
	String ebookAuthor = mr.getParameter("ebookAuthor");
	String ebookCompany = mr.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(mr.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(mr.getParameter("ebookPrice"));
	String ebookImg = mr.getFilesystemName("ebookImg");
	String ebookSummary = mr.getParameter("ebookSummary");
	String ebookState = mr.getParameter("ebookState");

	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookIsbn);
	ebook.setCategoryName(categoryName);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookImg(ebookImg);
	ebook.setEbookSummary(ebookSummary);
	ebook.setEbookState(ebookState);
	
	System.out.println(ebook.toString());
	
	EbookDao ebookDao = new EbookDao();
	ebookDao.insertEbook(ebook);
	
	
	response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
%>