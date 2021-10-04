package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.DBUtil;
import vo.*;

public class QnaCommentDao {
	// 7. 관리자 답변 삭제
	public void deleteQnaComment(int qnaCommentNo) throws ClassNotFoundException, SQLException {
		System.out.println(qnaCommentNo + "<-- delectQnaComment.qnaCommentNo");

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM qna_comment WHERE qna_comment_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaCommentNo);
		
		// System.out.println(stmt);
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
	}
	
	// 2. 문의 답변 작성
	public void insertQnaComment(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		System.out.println(qnaComment.toString() + "<-- QnaCommentDao.insretQnaComment");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO qna_comment(qna_no, qna_comment_content, member_no, member_id, create_date, update_date) VALUES (?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaComment.getQnaNo());
	 	stmt.setString(2, qnaComment.getQnaCommentContent());
	 	stmt.setInt(3, qnaComment.getMemberNo());
	 	stmt.setString(4, qnaComment.getMemberId());
 	
		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("답변 작성 성공");
		} else {
			System.out.println("답변 작성 실패");
		}
		
		stmt.close();
		conn.close();
	}
	
	// 1. 특정 문의글 관리자 답변 출력
	public QnaComment selectQnaCommentOne(int qnaNo) throws ClassNotFoundException, SQLException {
		System.out.println(qnaNo + "<-- selectQnaCommentOne.qnaNo");
		
		QnaComment qnaComment = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT qna_comment_no qnaCommentNo, qna_comment_content qnaCommentContent, member_no memberNo, member_id memberId, update_date updateDate FROM qna_comment WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
			
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			qnaComment = new QnaComment();
			qnaComment.setQnaCommentNo(rs.getInt("qnaCommentNo"));
			qnaComment.setQnaCommentContent(rs.getString("qnaCommentContent"));
			qnaComment.setMemberId(rs.getString("memberId"));
			qnaComment.setUpdateDate(rs.getString("updateDate"));
		}
		
		
		rs.close();
		stmt.close();
		conn.close();
			
		return qnaComment;
	}
}	
