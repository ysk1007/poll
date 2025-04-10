package model;

import java.sql.*;
import java.util.*;

import dto.*;
import model.*;

public class ImageDao {
	//---------------- SELECT ----------------
	public ArrayList<Image> selectImageList(Paging p,String searchWord) throws ClassNotFoundException, SQLException{
		ArrayList<Image> list = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = " SELECT "
				+ " num, "
				+ " memo, "
				+ " filename AS fileName,"
				+ " createdate AS createDate"
				+ " FROM image "
				+ " WHERE memo LIKE ?"
				+ " ORDER BY num DESC"
				+ " LIMIT ?,?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%");
		stmt.setInt(2, p.getBeginRow());
		stmt.setInt(3, p.getRowPerPage());

		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Image img = new Image();
			
			img.setNum(rs.getInt("num"));
			img.setMemo(rs.getString("memo"));
			img.setFileName(rs.getString("fileName"));
			img.setCreateDate(rs.getString("createDate"));
			
			list.add(img);
		}
		
		conn.close();
		
		return list;
	}
	
	// 페이지 전체 개수 가져오기
	public int getTotalCount(String searchWord) throws ClassNotFoundException, SQLException {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = " SELECT "
					+ " COUNT(*) count"
					+ " FROM image"
					+ " WHERE memo LIKE ?";
		
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, "%"+searchWord+"%");
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt(1);
		}
		
		conn.close();
		
		return row;
	}
	
	//---------------- INSERT ----------------
	
	// 이미지 입력
	public void insertImage(Image image) throws ClassNotFoundException, SQLException{
		Connection conn = null;
		PreparedStatement stmt = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "INSERT INTO "
				+ " image(memo,filename) "
				+ " values(?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, image.getMemo());
		stmt.setString(2, image.getFileName());
		
		stmt.executeUpdate();

		conn.close();
	}


	//---------------- DELETE ----------------
	// 게시글 삭제
	public boolean deleteImage(int num) throws ClassNotFoundException, SQLException{
		int row = 0;
		boolean isSuccess = false;
		Connection conn = null;
		PreparedStatement stmt = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = "DELETE FROM image "
				+ " WHERE num = ?";
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1,num);
		
		row = stmt.executeUpdate();
		
		// 디버깅
		//System.out.println(stmt);
		
		if(row == 1) {
			isSuccess = true;
		}
		else {
			isSuccess = false;
		}

		conn.close();
		
		return isSuccess;
	}
}
