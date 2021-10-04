<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	request.setCharacterEncoding("utf-8");	

	// 문제가 생겨 값이 아예 안들어오거나 공백을 입력받고 넘어온 경우
	if(request.getParameter("noticeTitle") == null || request.getParameter("noticeContent") == null){
		response.sendRedirect(request.getContextPath() + "/admin/insertNoticeForm.jsp");
		return;
	}
	
	if(request.getParameter("noticeTitle").equals("") || request.getParameter("noticeContent").equals("")){
		response.sendRedirect(request.getContextPath() + "/insertNoticeForm.jsp");
		return;
	}
	
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));

	// System.out.println(noticeTitle + " <-- noticeTitle");
	// System.out.println(noticeContent + " <-- noticeContent");

	Notice notice = new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setMemberNo(memberNo);
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.insertNotice(notice);
	
	// 공지사항 작성 완료시 관리자 페이지로 이동해 신규 공지사항 리스트에서 확인
	response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
%>