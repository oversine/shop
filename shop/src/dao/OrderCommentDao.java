package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.OrderComment;


public class OrderCommentDao {
	// 4.1 최대 수 값을 받아와 마지막 페이지를 체크하는 메서드
	public int selectCommentLastPage(int ebookNo, int rowPerPage) throws ClassNotFoundException, SQLException {
		System.out.println(ebookNo + "<-- OrderCommentDao.CommentLastPage");
		System.out.println(rowPerPage + "<-- OrderCommentDao.CommentLastPage");
		
		int lastPage = 0;
		int totalRowCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 전체 데이터 개수 조회
		String sql = "SELECT COUNT(*) FROM order_comment WHERE ebook_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
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
	
	// 4. 상품 후기 조회 메서드
	public ArrayList<OrderComment> selectOrderList(int ebookNo, int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<OrderComment> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT order_no orderNo, order_comment_content commentContent, order_score orderScore, update_date updateDate FROM order_comment WHERE ebook_no = ? ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		stmt.setInt(2, beginRow);
	 	stmt.setInt(3, rowPerPage);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			OrderComment oc = new OrderComment();
			
			oc.setOrderNo(rs.getInt("orderNo"));
			oc.setOrderComment(rs.getString("commentContent"));
			oc.setOrderScore(rs.getInt("orderScore"));
			oc.setUpdateDate(rs.getString("updateDate"));
			list.add(oc);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// 3. 상품 후기 평점 조회 메서드
	public double selectOrderScoreAvg(int ebookNo) throws ClassNotFoundException, SQLException {
		System.out.println(ebookNo + "<-- selectOrderScoreAvg.ebookNo");
		
		double avgScore = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT AVG(order_score) av FROM order_comment WHERE ebook_no=? ORDER BY ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			avgScore = rs.getInt("av");
		}
		
		
		rs.close();
		stmt.close();
		conn.close();
		
		// System.out.println(avgScore);
		
		return avgScore;
	}
	
	// 2. 후기 중복 체크 확인
	public int selectCheckCommentReview(int orderNo, int ebookNo)throws SQLException, ClassNotFoundException {
		System.out.println(orderNo + "<-- selectCheckCommentReview.orderNo");
		System.out.println(ebookNo + "<-- selectCheckCommentReview.ebookNo");
		
		int check = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql ="SELECT order_no, ebook_no FROM order_comment WHERE order_no=? AND ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setInt(1,orderNo);
		stmt.setInt(2, ebookNo);
		System.out.println(stmt+"<------dao.selectCheckCommentReview - stmt");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			check=1;
		}
		stmt.close();
		conn.close();
		
		return check;	
	}
	
	// 1. 회원 상품 후기 추가 메서드
	public void insertOrderComment(OrderComment orderComment) throws ClassNotFoundException, SQLException {
		System.out.println(orderComment.toString() + "<-- insertOrderComment");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO order_comment(order_no, ebook_no, order_score, order_comment_content, create_Date, update_Date) VALUES (?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderComment.getOrderNo());
		stmt.setInt(2, orderComment.getEbookNo());
		stmt.setInt(3, orderComment.getOrderScore());
		stmt.setString(4, orderComment.getOrderComment());
			 	
		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("작성 성공");
		} else {
			System.out.println("작성 실패");
		}
		
		stmt.close();
		conn.close();
	}
}
