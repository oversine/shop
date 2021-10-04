package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.*;

public class QnaDao {
	// 6. 관리자, 회원 문의글 수정 메서드
	public void updateQna(Qna qna) throws ClassNotFoundException, SQLException {
		System.out.println(qna.toString() + " <-- updateQna");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE qna SET qna_category = ?, qna_title = ?, qna_content = ?, qna_secret = ? WHERE qna_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, qna.getQnaCategory());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, qna.getQnaNo());
		
		stmt.executeUpdate();
		
		// System.out.println(stmt);
		
		stmt.close();
		conn.close();
	}	
	
	// 5. 관리자, 회원 문의글 삭제
	public void deleteQna(int qnaNo) throws ClassNotFoundException, SQLException {
		System.out.println(qnaNo + "<-- deleteQna.qnaNo");

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		
		// System.out.println(stmt);
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
	}
	
	// 4. QnA 작성
	public void insertQna(Qna qna) throws ClassNotFoundException, SQLException {
		System.out.println(qna.toString() + "<-- QnaDao.insretQna");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO qna(qna_category, qna_title, qna_content, qna_secret, member_no, member_id, create_date, update_date) VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategory());
	 	stmt.setString(2, qna.getQnaTitle());
	 	stmt.setString(3, qna.getQnaContent());
	 	stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, qna.getMemberNo());
		stmt.setString(6, qna.getMemberId());

 	
		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("작성 성공");
		} else {
			System.out.println("작성 실패");
		}
		
		stmt.close();
		conn.close();
	}
	
	
	// 3. 특정 QnA 글 조회
	public Qna selectQnaOne(int qnaNo) throws ClassNotFoundException, SQLException {
		System.out.println(qnaNo + "<-- selectQnaOne.qnaNo");
		
		Qna qna = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no memberNo, member_id memberId, create_date createDate, update_date updateDate FROM qna WHERE qna_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		// System.out.println(stmt + "<-- stmt qna");
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
			qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("memberNo"));
			qna.setMemberId(rs.getString("memberId"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
		}
	
		rs.close();
		stmt.close();
		conn.close();
			
		return qna;
	}
	
	// 2. 최대 수 값을 받아와 마지막 페이지를 체크하는 메서드
	public int selectLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
		System.out.println(rowPerPage + "<-- QnaDao.selectLastPage");
		
		int lastPage = 0;
		int totalRowCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 전체 데이터 개수 조회
		String sql = "SELECT COUNT(*) FROM qna";
		PreparedStatement stmt = conn.prepareStatement(sql);
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
	
	// 1. 전체 QnA 작성글 출력
	public ArrayList<Qna> selectQnaList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Qna> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_secret qnaSecret, member_no memberNo, member_id memberId, update_date updateDate FROM qna ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Qna q = new Qna();
			q.setQnaNo(rs.getInt("qnaNo"));
			q.setQnaCategory(rs.getString("qnaCategory"));
			q.setQnaTitle(rs.getString("qnaTitle"));
			q.setQnaSecret(rs.getString("qnaSecret"));
			q.setMemberNo(rs.getInt("memberNo"));
			q.setMemberId(rs.getString("memberId"));
			q.setUpdateDate(rs.getString("updateDate"));
			list.add(q);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;		
	}
}
