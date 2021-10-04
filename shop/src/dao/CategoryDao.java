package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.*;

public class CategoryDao {
	// 4. 카테고리 사용 여부 수정
	public void updateCategoryState(Category category) throws ClassNotFoundException, SQLException {
		System.out.println(category.toString() + "<-- updateCategoryState");
	
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 들어온 상태 값으로 카테고리명 행에 해당하는 상태값, 변경일 수정
		String sql = "UPDATE category SET category_state=?, update_date=NOW() WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryState());
		stmt.setString(2, category.getCategoryName());
		
		// System.out.println(stmt);
		
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}	
	
	
	// 3. 카테고리명 중복체크
	public String selectCategoryName(String categoryNameCheck) throws ClassNotFoundException, SQLException {
		System.out.println(categoryNameCheck + "<-- categoryNameCheck");
		
		String categoryName = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_name categoryName FROM category WHERE category_Name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryNameCheck);
		
		// System.out.println(stmt + "<-- selectCategoryName.stmt");
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			categoryName = rs.getString("categoryName");
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return categoryName;
	}	
	
	// 2. 카테고리 추가
	public void insertCategory(Category category) throws ClassNotFoundException, SQLException {
		System.out.println(category.toString() + "<-- insertCategory");
				
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO category(category_name, category_state, update_Date, create_Date) VALUES (?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
	 	stmt.setString(2, category.getCategoryState());
			 	
		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("추가 성공");
		} else {
			System.out.println("추가 실패");
		}
		
		stmt.close();
		conn.close();
	}
	
	
	// 1. 카테고리 리스트 출력
	public ArrayList<Category> selectCategoryList() throws ClassNotFoundException, SQLException{
		ArrayList<Category> list = new ArrayList<Category>();
	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_name categoryName, category_state categoryState, update_date updateDate, create_date createDate FROM category ORDER BY create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
	 	
	 	ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Category c = new Category();
			c.setCategoryName(rs.getString("categoryName"));
			c.setCategoryState(rs.getString("categoryState"));
			c.setUpdateDate(rs.getString("updateDate"));
			c.setCreateDate(rs.getString("createDate"));
			list.add(c);
		}
		rs.close();
		stmt.close();
		conn.close();
	 	
		return list;
	}
}
