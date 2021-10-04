<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeTitle") == null || request.getParameter("noticeContent") == null){
		response.sendRedirect(request.getContextPath() + "/admin/selectNoticeForm.jsp");
		return;
	}
	
	if(request.getParameter("noticeNo").equals("") || request.getParameter("noticeTitle").equals("") || request.getParameter("noticeContent").equals("")){
		response.sendRedirect(request.getContextPath() + "/admin/selectNoticeForm.jsp");
		return;
	}
	
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// System.out.println(noticeNo + "<-- action noticeNo");
	// System.out.println(noticeTitle);
	// System.out.println(noticeContent);
	
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);

	noticeDao.updateNotice(notice);
	
	// 공지사항 수정 완료시 해당 공지사항으로 이동
	response.sendRedirect(request.getContextPath()+"/selectNoticeOne.jsp?noticeNo="+noticeNo);
%>