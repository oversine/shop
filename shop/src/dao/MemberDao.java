package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Member;

public class MemberDao {
	// 4. 특정 회원정보 출력
	public Member selectMember(int memberNo) throws ClassNotFoundException, SQLException {
		Member returnMember = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_name memberName, member_age memberAge, member_gender memberGender FROM member WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
				
		// System.out.println(stmt + "<-- stmt");
				
		ResultSet rs = stmt.executeQuery();
				
		if(rs.next()) {
			returnMember = new Member();
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberName(rs.getString("memberName"));
			returnMember.setMemberAge(rs.getInt("memberAge"));
			returnMember.setMemberGender(rs.getString("memberGender"));
			return returnMember;
		}
				
		rs.close();
		stmt.close();
		conn.close();
		
		return returnMember;
	}
	
	// 3.5 관리자 회원 레벨 수정
	public void updateMemberLevelByAdmin(Member member) throws ClassNotFoundException, SQLException {
		// System.out.println(member.getMemberNo() + "<-- levelByAdmin param : memberNo");
		// System.out.println(member.getMemberLevel() + "<-- levelByAdmin param : memberLevel");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_level=? WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberLevel());
		stmt.setInt(2, member.getMemberNo());
		
		System.out.println(stmt);
		
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}
	
	// 3.4 관리자 회원 비밀번호 수정
	public void updateMemberPwByAdimin(Member member) throws ClassNotFoundException, SQLException {
		// System.out.println(member.getMemberNo() + "<-- pwByAdmin param : memberNo");
		// System.out.println(member.getMemberPw() + "<-- pwByAdmin param : memberPw");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_pw=PASSWORD(?) WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberPw());
		stmt.setInt(2, member.getMemberNo());
		
		/// System.out.println(stmt);
		
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}
	
	// 3.3 관리자 회원 삭제
	public void deleteMemberByKey(int memberNo) throws ClassNotFoundException, SQLException {
		// System.out.println(memberNo + "<-- deleteMemberKey param : memberNo");

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM member WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		
		// System.out.println(stmt);
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
	}
	
	// 3.2 관리자 회원 목록 검색
	public ArrayList<Member> selectMemberListAllBySearchMemberId(int beginRow, int rowPerPage, String searchMemberId) throws ClassNotFoundException, SQLException{
		ArrayList<Member> list = new ArrayList<Member>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNO, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_id LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchMemberId+"%");
		stmt.setInt(2, beginRow);
	 	stmt.setInt(3, rowPerPage);
		 	
	 	// System.out.println(stmt);
		 	
	 	ResultSet rs = stmt.executeQuery();
			
		while(rs.next()){
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			m.setMemberLevel(rs.getInt("memberLevel"));
			m.setMemberName(rs.getString("memberName"));
			m.setMemberAge(rs.getInt("memberAge"));
			m.setMemberGender(rs.getString("memberGender"));
			m.setUpdateDate(rs.getString("updateDate"));
			m.setCreateDate(rs.getString("createDate"));
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
	
		return list;
	}	
	
	
	// 3.1 최대 수 값을 받아와 마지막 페이지를 체크하는 메서드
	public int selectLastPage(int rowPerPage, String memberId) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		int totalRowCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 전체 데이터 개수 조회
		String sql = null;
		PreparedStatement stmt = null;
		
		if(memberId.equals("") == true) {
			sql = "SELECT COUNT(*) FROM member";
			stmt = conn.prepareStatement(sql);
			// System.out.println(stmt);
		} else {
			sql = "SELECT COUNT(*) FROM member WHERE member_id LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+memberId+"%");
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
	
	// 3. 관리자 회원 목록 출력
	public ArrayList<Member> selectMemberListAllByPage(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		ArrayList<Member> list = new ArrayList<Member>();
	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNO, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
	 	stmt.setInt(2, rowPerPage);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			m.setMemberLevel(rs.getInt("memberLevel"));
			m.setMemberName(rs.getString("memberName"));
			m.setMemberAge(rs.getInt("memberAge"));
			m.setMemberGender(rs.getString("memberGender"));
			m.setUpdateDate(rs.getString("updateDate"));
			m.setCreateDate(rs.getString("createDate"));
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
	 	
		return list;
	}
	
	// 2. 회원가입
	public void insertMember(Member member) throws ClassNotFoundException, SQLException {
		// System.out.println(member.getMemberId() + "<-- MemberDao.insertMember param : memberId");
		// System.out.println(member.getMemberPw() + "<-- MemberDao.insertMember param : memberPw");
		// System.out.println(member.getMemberName() + "<-- MemberDao.insertMember param : memberName");
		// System.out.println(member.getMemberAge() + "<-- MemberDao.insertMember param : memberAge");
		// System.out.println(member.getMemberGender() + "<-- MemberDao.insertMember param : memberGender");
				
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw, member_level, member_name, member_age, member_gender, update_Date, create_Date) VALUES (?, PASSWORD(?), 0, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
	 	stmt.setString(2, member.getMemberPw());
	 	stmt.setString(3, member.getMemberName());
	 	stmt.setInt(4, member.getMemberAge());
	 	stmt.setString(5, member.getMemberGender());
			 	
		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("가입 성공");
		} else {
			System.out.println("가입 실패");
		}
		
		stmt.close();
		conn.close();
	}
	
	
	// 1. 회원 로그인
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		// System.out.println(member.getMemberId() + "<-- MemberDao.login param : memberId");
		// System.out.println(member.getMemberPw() + "<-- MemberDao.login param : memberPw");
		Member returnMember = null;
				
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
				
		// System.out.println(stmt + "<-- stmt");
				
		ResultSet rs = stmt.executeQuery();
				
		if(rs.next()) {
			returnMember = new Member();
			returnMember.setMemberNo(rs.getInt("memberNo"));
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberLevel(rs.getInt("memberLevel"));
			return returnMember;
		}
				
		rs.close();
		stmt.close();
		conn.close();
				
		return returnMember;
	}
	
}
