package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;
import vo.*;

public class OrderDao {
	// 3 관리자 주문내역 삭제
	public void deleteOrder(int orderNo) throws ClassNotFoundException, SQLException {
		// System.out.println(memberNo + "<-- deleteMemberKey param : memberNo");

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM orders WHERE order_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);
		
		// System.out.println(stmt);
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
	}
	
	
	// 2. 특정 주문 데이터 조회 메서드
		public OrderEbookMember selectOrderOne(int orderNo) throws ClassNotFoundException, SQLException {
			OrderEbookMember oem = null;
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, m.member_name memberName, m.member_age memberAge, m.member_gender memberGender, o.order_price orderPrice, o.create_date createDate, o.update_date updateDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no WHERE o.orders_no=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				oem = new OrderEbookMember();
				
				// OrderEbookMember의 리스트 배열에 각 데이터를 저장하기 위해 먼저 각 데이터를 개별로 저장하고 마지막으로 리스트에 추가함 
				Order o = new Order();
				o.setOrderNo(rs.getInt("orderNo"));
				o.setOrderPrice(rs.getInt("orderPrice"));
				o.setCreateDate(rs.getString("createDate"));
				o.setUpdateDate(rs.getString("updateDate"));
				oem.setOrder(o);
				
				Ebook e = new Ebook();
				e.setEbookNo(rs.getInt("ebookNo"));
				e.setEbookTitle(rs.getString("ebookTitle"));
				oem.setEbook(e);
				
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberName(rs.getString("memberName"));
				m.setMemberAge(rs.getInt("memberAge"));
				m.setMemberGender(rs.getString("memberGender"));
				oem.setMember(m);
			}
			rs.close();
			stmt.close();
			conn.close();
			
			return oem;
		}
	
	
	// 1.1 최대 수 값을 받아와 마지막 페이지를 체크하는 메서드
	public int selectLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		int totalRowCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 전체 데이터 개수 조회
		String sql = "SELECT COUNT(*) FROM order";
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
	
	// 1. 전체 주문 조회 메서드
	public ArrayList<OrderEbookMember> selectOrderList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, o.order_price orderPrice, o.create_date createDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no ORDER BY o.create_date DES LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
	 	stmt.setInt(2, rowPerPage);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			OrderEbookMember oem = new OrderEbookMember();
			
			// OrderEbookMember의 리스트 배열에 각 데이터를 저장하기 위해 먼저 각 데이터를 개별로 저장하고 마지막으로 리스트에 추가함 
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
}