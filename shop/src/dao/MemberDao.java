package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.DBUtil;
import vo.Member;

public class MemberDao {
	
	
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
			 	
		stmt.executeUpdate();	
		
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
