package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;

public class EbookDao {
	// 5. 등록 순 신규 책 조회
	public ArrayList<Ebook> selectNewEbookList() throws ClassNotFoundException, SQLException {
		ArrayList<Ebook> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT t.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_img ebookImg, e.ebook_price ebookPrice FROM ebook e INNER JOIN (SELECT * FROM ebook ORDER BY create_date DESC LIMIT 0, 5) t ON e.ebook_no = t.ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
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
		String sql = "SELECT t.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_img ebookImg, e.ebook_price ebookPrice FROM ebook e INNER JOIN (SELECT ebook_no, COUNT(ebook_no) cnt FROM orders GROUP BY ebook_no ORDER BY COUNT(ebook_no) DESC LIMIT 0, 5) t ON e.ebook_no = t.ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			list.add(e);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	
	// 3.2 책 검색
	public ArrayList<Ebook> selectEbookListBySearchEbookTitle(int beginRow, int rowPerPage, String EbookTitle) throws ClassNotFoundException, SQLException{
		ArrayList<Ebook> list = new ArrayList<Ebook>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNO, ebook_img ebookImg, ebook_title ebookTitle, ebook_price ebookPrice FROM ebook WHERE ebook_title LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+EbookTitle+"%");
		stmt.setInt(2, beginRow);
	 	stmt.setInt(3, rowPerPage);
		 	
	 	// System.out.println(stmt);
		 	
	 	ResultSet rs = stmt.executeQuery();
			
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
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
			sql = "UPDATE ebook SET ebook_price = ? WHERE ebook_no =?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ebook.getEbookPrice());
			stmt.setInt(2, ebook.getEbookNo());
		} else {
			sql = "UPDATE ebook SET ebook_price = ?, ebook_img = ? WHERE ebook_no =?";
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
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_state ebookState FROM ebook WHERE category_name=? ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setInt(2, beginRow);
	 	stmt.setInt(3, rowPerPage);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookState(rs.getString("ebookState"));
			list.add(e);
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	
	// 1.1 최대 수 값을 받아와 마지막 페이지를 체크하는 메서드
	public int selectLastPage(int rowPerPage, String categoryName) throws ClassNotFoundException, SQLException {
		System.out.println(rowPerPage + "<-- EbookDao.selectLastPage");
		System.out.println(categoryName + "<-- EbookDao.selectLastPage");
		
		int lastPage = 0;
		int totalRowCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 전체 데이터 개수 조회
		String sql = null;
		PreparedStatement stmt = null;
		
		if(categoryName.equals("") == true) {
			sql = "SELECT COUNT(*) FROM ebook";
			stmt = conn.prepareStatement(sql);
			// System.out.println(stmt);
		} else {
			sql = "SELECT COUNT(*) FROM ebook WHERE category_name LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+categoryName+"%");
			// System.out.println(stmt);
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
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice, ebook_state ebookState FROM ebook ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
	 	stmt.setInt(2, rowPerPage);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setEbookState(rs.getString("ebookState"));
			list.add(e);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
}
