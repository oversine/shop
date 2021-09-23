<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<div>
	<ul class="list-group list-group-horizontal">
		<!-- 회원 관리 : 목록, 수정(등급, 비밀번호), 강제탈퇴-->
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">[회원관리]</a></li>
		<!-- 카테고리 관리 : 목록, 추가, 사용유무 수정 -->
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp">[전자책 카테고리 관리]</a></li>
		<!-- 전차책 관리 : 목록, 추가(이미지 추가), 수정, 삭제 -->
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">[전자책 관리]</a></li>
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="">[주문 관리]</a></li>
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="">[상품평 관리]</a></li>
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="">[공지게시판 관리]</a></li>
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="">[QnA게시판 관리]</a></li>
	</ul>
</div>