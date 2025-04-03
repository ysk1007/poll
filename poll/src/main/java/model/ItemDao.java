package model;
import java.sql.*;
import java.util.ArrayList;

import dto.*;
// Table : Item CRUD 담당
public class ItemDao {
	
	//---------- INSERT ----------//
	
	// item 클래스 받아서 투표 항목 넣기
	public void insertItem(Item item) throws ClassNotFoundException, SQLException {
		PreparedStatement stmt;
		Connection conn;
		
		// 라이브러리를 추가 : projcet 우클릭 -> build-path 항목에서 추가
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "INSERT INTO Item(qnum, inum, content) VALUES(?,?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, item.getQnum());
		stmt.setInt(2, item.getInum());
		stmt.setString(3, item.getContent());
		
		int row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("ItemDao.insertItem - 입력성공");
		}
		else {
			System.out.println("ItemDao.insertItem - 입력실패");
		}
		
		conn.close();
	}
	
	//---------- SELECT ----------//
	
	// qnum 받아서 아이템 리스트 반환
	public ArrayList<Item> selectItem(int qnum) throws ClassNotFoundException, SQLException{
		ArrayList<Item> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "SELECT"
						+ " qnum,"
						+ " inum,"
						+ " content,"
						+ " count"
					+ " FROM item"
					+ " WHERE qnum = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		
		// 디버깅
		//System.out.println(stmt);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Item i = new Item();
			
			i.setQnum(rs.getInt("qnum"));
			i.setInum(rs.getInt("inum"));
			i.setContent(rs.getString("content"));
			i.setCount(rs.getInt("count"));
			
			list.add(i);
		}
		
		conn.close();
		
		return list;
	}

	//---------- DELETE ----------//
	
	// qnum 받아서 투표에 있는 항목들 전부 제거
	public void deleteAllItem(int qnum) throws ClassNotFoundException, SQLException{
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "DELETE"
					+ " FROM item"
					+ " WHERE qnum = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		
		// 디버깅
		//System.out.println(stmt);
		
		row = stmt.executeUpdate();
		
		conn.close();
	}
}
