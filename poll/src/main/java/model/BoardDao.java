package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Board;
import dto.Paging;

public class BoardDao {
	
	//---------------- DELETE ----------------
	
	// 게시글 삭제
	public boolean deleteBoard(int num, String pass) throws ClassNotFoundException, SQLException{
		int row = 0;
		boolean isSuccess = false;
		Connection conn = null;
		PreparedStatement stmt = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = "DELETE FROM board "
				+ " WHERE num = ? AND pass = ?";
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1,num);
		stmt.setString(2,pass);
		
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
	
	//---------------- UPDATE ----------------
	
	// 게시글 수정
	public boolean updateBoard(Board board) throws ClassNotFoundException, SQLException{
		int row = 0;
		boolean isSuccess = false;
		Connection conn = null;
		PreparedStatement stmt = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = "UPDATE board SET "
				+ " name = ?, "
				+ " subject = ?, "
				+ " content = ? "
				+ " WHERE num = ? AND pass = ?";
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1,board.getName());
		stmt.setString(2,board.getSubject());
		stmt.setString(3,board.getContent());
		
		stmt.setInt(4,board.getNum());
		stmt.setString(5,board.getPass());
		
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
	
	// 자식 게시글 수정
	public void updateBoardChild(int ref) throws ClassNotFoundException, SQLException{
		Connection conn = null;
		PreparedStatement stmt = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = "UPDATE board SET "
				+ " subject='부모글이 삭제된 게시글'"
				+ " WHERE ref = ?";
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1,ref);
		
		stmt.executeUpdate();
		
		// 디버깅
		//System.out.println(stmt);

		conn.close();

	}
	
	//---------------- INSERT ----------------
	
	// 새글 입력(부모글)
	public void insertBoard(Board board) throws ClassNotFoundException, SQLException{
		int pk = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "INSERT INTO "
				+ " board(name, subject, content, ref, pass, ip) "
				+ " VALUES(?,?,?,?,?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		conn.setAutoCommit(false);	// executeUpdate()시마다 자동 커밋기능을 false
		
		// Statement.RETURN_GENERATED_KEYS 옵션 : insert 후 SELECT MAX(pk) FROM ... 실행
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		
		stmt.setString(1, board.getName());
		stmt.setString(2, board.getSubject());
		stmt.setString(3, board.getContent());
		stmt.setInt(4, board.getRef());
		stmt.setString(5, board.getPass());
		stmt.setString(6, board.getIp());
		
		stmt.executeUpdate();
		
		rs = stmt.getGeneratedKeys();	// 입력직후 pk를 반환 받아서 ref값을 동일하게
		
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		
		sql = "UPDATE board SET ref = ? WHERE num = ?";
		
		stmt = conn.prepareStatement(sql);
		// UPDATE 쿼리가 실패하면 INSERT도 롤백 : conn.rollback()
		
		stmt.setInt(1, pk);
		stmt.setInt(2, pk);
		stmt.executeUpdate();
		
		conn.commit();
		conn.close();
	}
	
	// 답글 입력
	public void insertBoardReply(Board board) throws ClassNotFoundException, SQLException{
		Connection conn = null;
		PreparedStatement stmt = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		// 트랜잭션(2개 이상의 쿼리를 처리)
		conn.setAutoCommit(false);	// executeUpdate()시마다 자동 커밋기능을 false
		
		// ref 같고 pos 값이 현재 글 보다 크거나 같다면 +1
		String sql = "UPDATE board SET pos = pos+1 WHERE ref=? AND pos >= ?";
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1,board.getRef());
		stmt.setInt(2,board.getPos());
		
		stmt.executeUpdate();
		
		sql = "INSERT INTO "
			+ " board(name, subject, content, ref, pos, depth, pass, ip) "
			+ " VALUES(?,?,?,?,?,?,?,?)";
		// Statement.RETURN_GENERATED_KEYS 옵션 : insert 후 SELECT MAX(pk) FROM ... 실행
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, board.getName());
		stmt.setString(2, board.getSubject());
		stmt.setString(3, board.getContent());
		stmt.setInt(4, board.getRef());
		stmt.setInt(5, board.getPos());
		stmt.setInt(6, board.getDepth());
		stmt.setString(7, board.getPass());
		stmt.setString(8, board.getIp());
		
		stmt.executeUpdate();
		
		conn.commit();
		conn.close();
	}
	
	
	//---------------- SELECT ----------------
	
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
					+ " FROM board"
					+ " WHERE subject LIKE ?";
		
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, "%"+searchWord+"%");
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt(1);
		}
		
		conn.close();
		
		return row;
	}
	
	public Board selectBoardOne(int num) throws ClassNotFoundException, SQLException {
		Board b = new Board();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = " SELECT "
				+ " * "
				+ " FROM board "
				+ " WHERE num = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		
		// 디버깅
		//System.out.println(stmt);
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setContent(rs.getString("content"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setRegdate(rs.getString("regdate"));
			b.setPass(rs.getString("pass"));
			b.setIp(rs.getString("ip"));
			b.setCount(rs.getInt("count"));
		}
		
		conn.close();
		
		return b;
	}
	
	public ArrayList<Board> selectBoardList(Paging p, String searchWord) throws ClassNotFoundException, SQLException{
		ArrayList<Board> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = " SELECT "
				+ " * "
				+ " FROM board "
				+ " WHERE subject LIKE ?"
				+ " ORDER BY ref DESC, pos "
				+ " LIMIT ?,?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%");
		stmt.setInt(2, p.getBeginRow());
		stmt.setInt(3, p.getRowPerPage());
		
		// 디버깅
		//System.out.println(stmt);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Board b = new Board();
			
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			//b.setContent(rs.getString("content"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			//b.setRegdate(rs.getString("regdate"));
			//b.setPass(rs.getString("pass"));
			//b.setIp(rs.getString("ip"));
			b.setCount(rs.getInt("count"));
			
			list.add(b);
		}
		
		conn.close();
		
		return list;
	}
}
