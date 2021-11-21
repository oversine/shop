package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.*;

public class NoticeDao {
	// 6. 관리자 특정 공지사항 수정 메서드
	public void updateNotice(Notice notice) throws ClassNotFoundException, SQLException {
		System.out.println(notice.toString() + " <-- updateNotice");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE notice SET notice_title = ?, notice_content = ?, update_date=NOW() WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		
		stmt.executeUpdate();
		
		System.out.println(stmt);
		
		stmt.close();
		conn.close();
	}	
	
	// 5. 관리자 공지사항 삭제
	public void deleteNotice(int noticeNo) throws ClassNotFoundException, SQLException {
		System.out.println(noticeNo + "<-- deleteNotice.noticeNo");

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		
		// System.out.println(stmt);
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
	}
	
	
	// 4. 특정 공지사항 조회 메서드
	public Notice selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		System.out.println(noticeNo + "<-- selectNoticeOne.noticeNo");
		
		Notice notice = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, create_date createDate, update_date updateDate FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
			
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
		}
		rs.close();
		stmt.close();
		conn.close();
			
		return notice;
	}
	
	// 3. 최대 수 값을 받아와 마지막 페이지를 체크하는 메서드
	public int selectLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
		System.out.println(rowPerPage + "<-- NoticeDao.selectLastPage");
		
		int lastPage = 0;
		int totalRowCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 전체 데이터 개수 조회
		String sql = "SELECT COUNT(*) FROM notice";
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

	// 2.1 전체 공지사항 조회
	public ArrayList<Notice> selectNoticeList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, update_date updateDate FROM notice ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setUpdateDate(rs.getString("updateDate"));
			list.add(n);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;		
	}
	
	// 2. 새로운 공지사항 6개 출력
	public ArrayList<Notice> selectNewNoticeList() throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, update_date updateDate FROM notice ORDER BY create_date DESC LIMIT 0, 6";
		PreparedStatement stmt = conn.prepareStatement(sql);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setUpdateDate(rs.getString("updateDate"));
			list.add(n);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;		
	}
	
	// 1. 공지사항 작성
	public void insertNotice(Notice notice) throws ClassNotFoundException, SQLException {
		System.out.println(notice.toString() + "<-- NoticeDao.insertNotice");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO notice(notice_title, notice_content, member_no, update_date, create_date) VALUES (?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
	 	stmt.setString(2, notice.getNoticeContent());
	 	stmt.setInt(3, notice.getMemberNo());
 	
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
