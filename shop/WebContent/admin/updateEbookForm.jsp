<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	request.setCharacterEncoding("utf-8");		

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	if(request.getParameter("ebookNo") == null || request.getParameter("ebookNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
		return;
	}
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	EbookDao ebookDao = new EbookDao();
	Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	
	// 카테고리 선택을 위한 배열 생성
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자책 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="css/styles.css" rel="stylesheet" />
</head>
<body>
	<div class="container">
	<div>
		<jsp:include page="/partial/memberMenu.jsp"></jsp:include>
	</div>
	
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	
	<!-- enctype="multipart/form-data" : 액션으로 글자값이 아닌 기계어 코드를 넘길때 사용 -->
	<form id="updateEbookForm" action="<%=request.getContextPath()%>/admin/updateEbookAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
		<input type="hidden" name="deleteEbookImg" value="<%=ebook.getEbookImg()%>">
			<div class="form-group">
				<label for="categoryName">도서 카테고리 : </label>
				<select class="form-control" id = "categoryName" name = "categoryName">
					<%
						for(Category c : categoryList) {
					%>
							<option value="<%=c.getCategoryName()%>"><%=c.getCategoryName()%></option>
					<%		
						}
					%>
				</select>
			</div>
			<div class="form-group">
			<label for="ebookTitle">도서명 : </label>
				<input type ="text" class="form-control" placeholder="도서명을 입력해주세요" value="<%=ebook.getEbookTitle()%>" id="ebookTitle" name="ebookTitle" >
			</div>
			<div class="form-group">
			<label for="ebookAuthor">저자 : </label>
				<input type ="text" class="form-control" placeholder="작가명을 입력해주세요" value="<%=ebook.getEbookAuthor()%>" id="ebookAuthor" name="ebookAuthor" >
			</div>
			<div class="form-group">
			<label for="ebookCompany">출판회사 : </label>
				<input type ="text" class="form-control" placeholder="회사명을 입력해주세요" value="<%=ebook.getEbookCompany()%>" id="ebookCompany" name="ebookCompany" >
			</div>
			<div class="form-group">
			<label for="ebookPageCount">페이지 수 : </label>
				<input type ="number" class="form-control" placeholder="페이지 수를 입력해주세요" value="<%=ebook.getEbookPageCount()%>" id="ebookPageCount" name="ebookPageCount" >
			</div>		
			<div class="form-group">
			<label for="ebookPirce">가격 : </label>
				<input type ="text" class="form-control" value="<%=ebook.getEbookPrice()%>" id="ebookPrice" name="ebookPrice">
			</div>
			<div class="form-group">
			<label for="ebookSummary">서평 : </label>
				<textarea class="form-control" rows="5" placeholder="서평을 작성해주세요" id="ebookSummary" name="ebookSummary" ><%=ebook.getEbookSummary()%></textarea>
			</div>
			<div class="form-group">
				<label for="ebookState">판매현황 : </label>
				<select class="form-control" id = "ebookState" name = "ebookState">
					<option value = "판매중">판매중</option>
					<option value = "품절">품절</option>
					<option value = "절판">절판</option>
					<option value = "구편절판">구편절판</option>
				</select>
			</div>
			<div class="form-group">
				<label for="ebookImg">이미지 변경 :</label>
					<input type="file" class="form-control-file border" id="ebookImg" name="ebookImg">
			</div>
			<div>
				<button id="btn" type="button" class="btn btn-primary">수정</button>
				<button type="reset" class="btn float-right btn-danger">초기화</button>
			</div>
		</form>
		
		<script>
			$('#btn').click(function(){
				if($('#ebookTitle').val() == '') {
					alert('도서명을 입력하세요');
					return;
				}
				if($('#ebookAuthor').val() == '') {
					alert('작가명을 입력하세요');
					return;
				}
				if($('#ebookCompany').val() == '') {
					alert('출판 회사를 입력하세요');
					return;
				}
				if($('#ebookPageCount').val() == '') {
					alert('페이지 수를 입력하세요');
					return;
				}
				if($('#ebookPrice').val() == '') {
					alert('가격을 입력하세요');
					return;
				}
				if($('#ebookSummary').val() == '') {
					alert('서평을 입력하세요');
					return;
				}
				$('#updateEbookForm').submit();
			});
		</script>
</div>
</body>
</html>