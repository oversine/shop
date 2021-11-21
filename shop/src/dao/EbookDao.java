package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;

public class EbookDao {	
	// 8. 카테고리 사용여부 변경시 전자책 DB 수정
	public void updateEbookCategoryState(Ebook ebook) throws ClassNotFoundException, SQLException {
		System.out.println(ebook.toString() + "<-- updateEbookCategoryState");

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 들어온 상태 값으로 카테고리명 행에 해당하는 상태값, 변경일 수정
		String sql = "UPDATE ebook SET category_state=?, update_date=NOW() WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getCategoryState());
		stmt.setString(2, ebook.getCategoryName());
		
		// System.out.println(stmt);
		
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}	
	
	// 7. 신규 전자책 추가
	public void insertEbook(Ebook ebook) throws ClassNotFoundException, SQLException {
		System.out.println(ebook.toString() + "<-- ebookDao.insertEbook");
				
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_img, ebook_summary, ebook_state, create_Date, update_Date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
	 	stmt.setString(2, ebook.getCategoryName());
	 	stmt.setString(3, ebook.getEbookTitle());
	 	stmt.setString(4, ebook.getEbookAuthor());
	 	stmt.setString(5, ebook.getEbookCompany());
	 	stmt.setInt(6, ebook.getEbookPageCount());
	 	stmt.setInt(7, ebook.getEbookPrice());
	 	stmt.setString(8, ebook.getEbookImg());
	 	stmt.setString(9, ebook.getEbookSummary());
	 	stmt.setString(10, ebook.getEbookState());
			 	
		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("등록 성공");
		} else {
			System.out.println("등록 실패");
		}
		
		stmt.close();
		conn.close();
	}
	
	// 6. 도서 ISBN 번호 중복 확인
	public String selectEbookIsbn(String isbnCheck) throws ClassNotFoundException, SQLException {
		System.out.println(isbnCheck + "<-- isbnCheck");
		
		String isbn = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_isbn ebookIsbn FROM ebook WHERE ebook_isbn=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, isbnCheck);
		
		// System.out.println(stmt + "<-- selectMemberId.stmt");
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			isbn = rs.getString("ebookIsbn");
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return isbn;
	}
	
	// 5. 등록 순 신규 책 조회
	public ArrayList<Ebook> selectNewEbookList() throws ClassNotFoundException, SQLException {
		ArrayList<Ebook> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice, category_state categoryState FROM ebook WHERE category_state=? ORDER BY create_date DESC LIMIT 0, 5";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "Y");
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setCategoryState(rs.getString("categoryState"));
			list.add(e);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;		
	}
	
	
	// 4. 판매 수 많은 인기 책 조회
	public ArrayList<Ebook> selectPopularEbookList() throws ClassNotFoundException, SQLException {
		ArrayList<Ebook> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT t.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_img ebookImg, e.ebook_price ebookPrice, e.category_state categoryState FROM ebook e INNER JOIN (SELECT ebook_no, COUNT(ebook_no) cnt FROM orders GROUP BY ebook_no ORDER BY COUNT(ebook_no) DESC LIMIT 0, 5) t ON e.ebook_no = t.ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setCategoryState(rs.getString("categoryState"));
			list.add(e);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	
	// 3.2 책 검색
	public ArrayList<Ebook> selectEbookListBySearchEbookTitle(String categoryName, int beginRow, int rowPerPage, String EbookTitle) throws ClassNotFoundException, SQLException{
		ArrayList<Ebook> list = new ArrayList<Ebook>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		if (categoryName.equals("")) {
			sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_img ebookImg, ebook_title ebookTitle, ebook_price ebookPrice, category_state categoryState FROM ebook WHERE category_state =? AND ebook_title LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, "Y");
			stmt.setString(2, "%"+EbookTitle+"%");
			stmt.setInt(3, beginRow);
		 	stmt.setInt(4, rowPerPage);
		} else {
			sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_img ebookImg, ebook_title ebookTitle, ebook_price ebookPrice, category_state categoryState FROM ebook WHERE category_name=? AND category_state=? AND ebook_title LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, categoryName);
			stmt.setString(2, "Y");
			stmt.setString(3, "%"+EbookTitle+"%");
			stmt.setInt(4, beginRow);
		 	stmt.setInt(5, rowPerPage);
		}
		 	
	 	// System.out.println(stmt);
		 	
	 	ResultSet rs = stmt.executeQuery();
			
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setCategoryState(rs.getString("categoryName"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			list.add(e);
		}
		rs.close();
		stmt.close();
		conn.close();
	
		return list;
	}	
	
	// 3.1 특정 전자책 데이터 수정 메서드
	public void updateEbook(Ebook ebook) throws ClassNotFoundException, SQLException {
		System.out.println(ebook.toString() + " <-- updateEbook");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		
		// 가격만 수정하기 위해 시도한 경우 / 가격은 기존 입력값 그대로 두거나, 수정 후 이미지 파일 교체하기 위해 시도한 경우
		if (ebook.getEbookImg() == null) {
			sql = "UPDATE ebook SET ebook_price = ?, update_date=NOW() WHERE ebook_no =?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ebook.getEbookPrice());
			stmt.setInt(2, ebook.getEbookNo());
		} else {
			sql = "UPDATE ebook SET ebook_price = ?, ebook_img = ?, update_date=NOW() WHERE ebook_no =?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ebook.getEbookPrice());
			stmt.setString(2, ebook.getEbookImg());
			stmt.setInt(3, ebook.getEbookNo());
		}
		stmt.executeUpdate();
		
		System.out.println(stmt);
		
		stmt.close();
		conn.close();
	}

	// 3. 특정 전자책 데이터 조회 메서드
	public Ebook selectEbookOne(int ebookNo) throws ClassNotFoundException, SQLException {
		System.out.println(ebookNo + "ebookNo");
		
		Ebook ebook = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNo, ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_img ebookImg, ebook_summary ebookSummary, ebook_state ebookState, create_date createDate, update_date updateDate FROM ebook WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookISBN(rs.getString("ebookISBN"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookAuthor(rs.getString("ebookAuthor"));
			ebook.setEbookCompany(rs.getString("ebookCompany"));
			ebook.setEbookPageCount(rs.getInt("ebookPageCount"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookSummary(rs.getString("ebookSummary"));
			ebook.setEbookState(rs.getString("ebookState"));
			ebook.setCreateDate(rs.getString("createDate"));
			ebook.setUpdateDate(rs.getString("updateDate"));
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return ebook;
	}
	
	// 2. 특정 카테고리 선택시 해당 전자책 리스트 출력 메서드
	public ArrayList<Ebook> selectEbookListByCategory(String categoryName, int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		ArrayList<Ebook> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_state ebookState, ebook_img ebookImg FROM ebook WHERE category_name=? AND category_state=? ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setString(2, "Y");
		stmt.setInt(3, beginRow);
	 	stmt.setInt(4, rowPerPage);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookState(rs.getString("ebookState"));
			e.setEbookImg(rs.getString("ebookImg"));
			list.add(e);
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	
	// 1.1 최대 수 값을 받아와 마지막 페이지를 체크하는 메서드
	public int selectLastPage(int rowPerPage, String categoryName, String ebookTitle) throws ClassNotFoundException, SQLException {
		System.out.println(rowPerPage + "<-- EbookDao.selectLastPage");
		System.out.println(categoryName + "<-- EbookDao.selectLastPage");
		System.out.println(ebookTitle + "<-- EbookDao.selectLastPage");
		
		int lastPage = 0;
		int totalRowCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 전체 데이터 개수 조회
		String sql = null;
		PreparedStatement stmt = null;
		
		// 카테고리, 검색어가 없는 전체 목록 기본 페이징 수 체크
		if(categoryName.equals("") && ebookTitle.equals("")) {
			sql = "SELECT COUNT(*) FROM ebook WHERE category_state=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "Y");
			// System.out.println(stmt);
		// 특정 카테고리 미검색 상태 전체 페이징	
		} else if (ebookTitle.equals("")){
			sql = "SELECT COUNT(*) FROM ebook WHERE category_state=? AND category_name LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "Y");
			stmt.setString(2, "%"+categoryName+"%");
			// System.out.println(stmt);
		// 전체 판매책 페이지에서 검색을 시도한 경우 해당 페이징 수 체크	
		} else if (categoryName.equals("")) {
			sql = "SELECT COUNT(*) FROM ebook WHERE category_state=? AND ebook_title LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "Y");
			stmt.setString(2, "%"+ebookTitle+"%");
		} else {
			sql = "SELECT COUNT(*) FROM ebook WHERE category_name = ? AND category_name=? AND ebook_title LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
			stmt.setString(2, "Y");
			stmt.setString(3, "%"+ebookTitle+"%");
			System.out.println("4");
		}
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalRowCount = rs.getInt("COUNT(*)");
		}
		
		// System.out.println(totalRowCount);
		
		lastPage = totalRowCount / rowPerPage;
		if(totalRowCount % rowPerPage != 0) {
			lastPage++;
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return lastPage;
	}
	
	// 1. 전체 전자책 리스트 출력
	public ArrayList<Ebook> selectEbookList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		ArrayList<Ebook> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice, ebook_state ebookState, category_state categoryState FROM ebook WHERE category_state = ? ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "Y");
		stmt.setInt(2, beginRow);
	 	stmt.setInt(3, rowPerPage);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setEbookState(rs.getString("ebookState"));
			e.setCategoryState(rs.getString("categoryState"));
			list.add(e);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
}
