package model;
import java.sql.*;
import dto.*;
// Table : Item CRUD 담당
public class ItemDao {
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
}
