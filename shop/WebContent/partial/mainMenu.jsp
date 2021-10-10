<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<div>
	<ul class="list-group list-group-horizontal">
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="<%=request.getContextPath()%>/index.jsp">[메인으로 이동]</a></li>
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="<%=request.getContextPath()%>/selectNoticeList.jsp">[공지사항]</a></li>
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="<%=request.getContextPath()%>/selectQnaList.jsp">[QnA]</a></li>
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="<%=request.getContextPath()%>/selectEbookList.jsp?categoryName=외국어">[전자책 구매]</a></li>
		<li class="list-group-item list-group-item-action list-group-item-secondary"><a href="<%=request.getContextPath()%>/selectMemberOne.jsp">[회원정보 수정]</a></li>
	</ul>
</div>