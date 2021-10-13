<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	request.setCharacterEncoding("utf-8");		
	
	// 로그인 회원 관리자 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 카테고리 선택을 위한 배열 생성
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매 책 추가 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div>
		<jsp:include page="/partial/memberMenu.jsp"></jsp:include>
	</div>

	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div class="jumbotron text-center">
		<h1>신규 책 추가</h1>
	</div>
	<%
		// 도서 ISBN값 중복 체크를 위한 변수
		String isbnCheck = "";
		if(request.getParameter("isbnCheck") != null) {
			isbnCheck = request.getParameter("isbnCheck");
		}
	%>
	<!-- 아이디 사용가능 중복여부 확인 폼 -->
	<form id="isbnCheckForm" action="<%=request.getContextPath()%>/admin/isbnCheckAction.jsp" method="post">
		<div class="form-group">
		<label for="isbn">ISBN : </label>
			<input type ="text" class="form-control" placeholder="도서 ISBN 번호를 입력해주세요" id="isbnCheck" name="isbnCheck">
		</div>
		<button id="btn" type="button" class="btn btn-primary">중복 검사</button>
	</form><br>
	
	<!-- 전자책 등록 폼 -->
	<form id="ebookForm" action ="<%=request.getContextPath()%>/admin/insertEbookAction.jsp" method ="post" enctype="multipart/form-data">
		<div class="form-group">
			<input type ="text" class="form-control" placeholder="도서 ISBN 번호를 중복 확인해주세요" id="ebookIsbn" name="ebookIsbn" readonly="readonly" value="<%=isbnCheck%>">
		</div>
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
			<input type ="text" class="form-control" placeholder="도서명을 입력해주세요" id="ebookTitle" name="ebookTitle" >
		</div>
		<div class="form-group">
		<label for="ebookAuthor">저자 : </label>
			<input type ="text" class="form-control" placeholder="작가명을 입력해주세요" id="ebookAuthor" name="ebookAuthor" >
		</div>
		<div class="form-group">
		<label for="ebookCompany">출판회사 : </label>
			<input type ="text" class="form-control" placeholder="회사명을 입력해주세요" id="ebookCompany" name="ebookCompany" >
		</div>
		<div class="form-group">
		<label for="ebookPageCount">페이지 수 : </label>
			<input type ="number" class="form-control" placeholder="페이지 수를 입력해주세요" id="ebookPageCount" name="ebookPageCount" >
		</div>
		<div class="form-group">
		<label for="ebookPrice">가격 : </label>
			<input type ="number" class="form-control" placeholder="판매 가격을 입력해주세요" id="ebookPrice" name="ebookPrice" >
		</div>								
		<div class="form-group">
		<label for="ebookImg">도서 이미지 :</label>
			<input type="file" class="form-control-file border" id="ebookImg" name="ebookImg">
		</div>
		<div class="form-group">
		<label for="ebookSummary">서평 : </label>
			<textarea class="form-control" rows="5" placeholder="서평을 작성해주세요" id="ebookSummary" name="ebookSummary" ></textarea>
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
		<div>
			<button id="btn2" type ="button" class="btn btn-primary">추가</button>
			<button type ="reset" class="btn float-right btn-danger">초기화</button>
		</div>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#isbnCheck').val() == '') {
				alert('도서 ISBN 번호를 입력하세요');
				return;
			}
			$('#isbnCheckForm').submit();
		});
	
		$('#btn2').click(function(){
			if($('#ebookIsbn').val() == '') {
				alert('도서 ISBN 번호의 중복 여부를 확인하세요');
				return;
			}
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
				alert('판매 가격을 입력하세요');
				return;
			}
			if($('#ebookImg').val() == '') {
				alert('도서 이미지 파일을 등록하세요');
				return;
			}
			if($('#ebookSummary').val() == '') {
				alert('서평을 입력하세요');
				return;
			}
			$('#ebookForm').submit();
		});
	</script>
</div>
</body>
</html>