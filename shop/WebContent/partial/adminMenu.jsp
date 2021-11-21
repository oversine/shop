<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<ul class="nav nav-tabs nav-justified">
		<!-- 회원 관리 : 목록, 수정(등급, 비밀번호), 강제탈퇴-->
		<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">회원관리</a></li>
		<!-- 카테고리 관리 : 목록, 추가, 사용유무 수정 -->
		<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp">카테고리 관리</a></li>
		<!-- 전차책 관리 : 목록, 추가(이미지 추가), 수정, 삭제 -->
		<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">전자책 관리</a></li>
		<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp">주문 관리</a></li>
		<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/admin/selectOrderCommentList.jsp">상품평 관리</a></li>
		<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/selectNoticeList.jsp">공지게시판 관리</a></li>
		<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/selectQnaList.jsp">QnA게시판 관리</a></li>
	</ul>