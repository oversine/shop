<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- request 대신 사용됨 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 파일 이름 중복 방지 라이브러리 -->
<%	
	request.setCharacterEncoding("utf-8");		

	MultipartRequest mr = new MultipartRequest(request, "/var/lib/tomcat9/webapps/shop/image", 1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	// 문제가 생겨 값이 아예 안들어오거나 공백을 입력받고 넘어온 경우
	if(mr.getParameter("ebookNo") == null || mr.getParameter("categoryName") == null || mr.getParameter("ebookTitle") == null || mr.getParameter("ebookAuthor") == null || mr.getParameter("ebookCompany") == null || mr.getParameter("ebookPageCount") == null || mr.getParameter("ebookPrice") == null || mr.getParameter("ebookSummary") == null || mr.getParameter("ebookState") == null){
			response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
			return;
	}
		
	if(mr.getParameter("ebookNo").equals("") || mr.getParameter("categoryName").equals("") || mr.getParameter("ebookTitle").equals("") || mr.getParameter("ebookAuthor").equals("") || mr.getParameter("ebookCompany").equals("") || mr.getParameter("ebookPageCount").equals("") || mr.getParameter("ebookPrice").equals("") || mr.getParameter("ebookSummary").equals("") || mr.getParameter("ebookState").equals("")){
			response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
			return;
	}
	
	int ebookNo = Integer.parseInt(mr.getParameter("ebookNo"));
	String categoryName = mr.getParameter("categoryName");
	String ebookTitle = mr.getParameter("ebookTitle");
	String ebookAuthor = mr.getParameter("ebookAuthor");
	String ebookCompany = mr.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(mr.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(mr.getParameter("ebookPrice"));
	String ebookSummary = mr.getParameter("ebookSummary");
	String ebookState = mr.getParameter("ebookState");
	String ebookImg = mr.getFilesystemName("ebookImg");
	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	ebook.setCategoryName(categoryName);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	ebook.setEbookState(ebookState);
	ebook.setEbookImg(ebookImg);
	
	EbookDao ebookDao = new EbookDao();
	ebookDao.updateEbook(ebook);
	
	
	// 이전 이미지 파일명을 받아오고, 실행된 홈페이지의 서버의 물리 경로 주소를 받아옴
	String fileName = mr.getParameter("deleteEbookImg");
	System.out.println(fileName);
	
	String directory = this.getServletContext().getRealPath("/image/");
	
	// 경로명 뒤에 파일명을 붙여 해당 파일이 존재하는 경우에 이미지를 삭제해주는 코드
	File file = new File(directory+fileName);
	System.out.println(file);
	
	if(file.exists()) {
		file.delete();
		System.out.println("이전 이미지 삭제");
	}
	
	// 이미지 or 가격 수정 후 해당 상세 페이지로 이동
	response.sendRedirect(request.getContextPath() + "/admin/selectEbookOne.jsp?ebookNo=" + ebookNo);
%>