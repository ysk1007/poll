package model;
import java.sql.*;
import java.util.ArrayList;

import dto.*;

import dto.Question;
// Table : question CRUD 담당
public class QuestionDao {
	
	//---------- SELECT ----------//
	
	// 페이징으로 리스트 가져오기
	public ArrayList<Question> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException{
		ArrayList<Question> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = "SELECT"
						+ " q.num AS num,"
						+ " q.title AS title,"
						+ " q.startdate AS startDate,"
						+ " q.enddate AS endDate,"
						+ " q.createdate AS createDate,"
						+ " q.type AS type,"
						+ " t.count AS count"
					+ " FROM question q"
					+ " INNER JOIN (SELECT qnum, SUM(COUNT) AS count FROM item GROUP BY qnum) t ON q.num = t.qnum"
					+ " ORDER BY num DESC"
					+ " LIMIT ?,?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		
		// 디버깅
		//System.out.println(stmt);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Question q = new Question();
			
			q.setNum(rs.getInt("num"));
			q.setTitle(rs.getString("title"));
			q.setStartdate(rs.getString("startDate"));
			q.setEnddate(rs.getString("endDate"));
			q.setCreatedate(rs.getString("createDate"));
			q.setType(rs.getInt("type"));
			q.setCount(rs.getInt("count"));
			
			list.add(q);
		}
		
		conn.close();
		
		return list;
	}

	// qnum으로 원하는 투표 가져오기
	public Question selectQuestion(int qnum) throws ClassNotFoundException, SQLException{
		Question q = new Question();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = "SELECT"
						+ " num,"
						+ " title,"
						+ " startdate AS startDate,"
						+ " enddate AS endDate,"
						+ " createdate AS createDate,"
						+ " type"
					+ " FROM question"
					+ " WHERE num = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		
		// 디버깅
		//System.out.println(stmt);
		
		rs = stmt.executeQuery();
		
		rs.next();
		
		q.setNum(rs.getInt("num"));
		q.setTitle(rs.getString("title"));
		q.setStartdate(rs.getString("startDate"));
		q.setEnddate(rs.getString("endDate"));
		q.setCreatedate(rs.getString("createDate"));
		q.setType(rs.getInt("type"));
		
		conn.close();
		
		return q;
	}
	
	// 전체 데이터 수 가져오기
	public int getTotalDataCount() throws ClassNotFoundException, SQLException{
		int count = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = "SELECT "
						+ " COUNT(*) AS count"
					+ " FROM question";
		
		stmt = conn.prepareStatement(sql);
		
		// 디버깅
		//System.out.println(stmt);
		
		rs = stmt.executeQuery();
		rs.next();
		
		count = rs.getInt("count");
		
		conn.close();
		
		return count;
	}

	
	//---------- INSERT ----------//
	
	// 입력 후 자동으로 생성된 키값을 반환
	public int insertQuestion(Question question) throws ClassNotFoundException, SQLException {
		int pk = 0;
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;			// INSERT 지만 KEY 값을 받아와야해서 사용
		
		// 라이브러리를 추가 : projcet 우클릭 -> build-path 항목에서 추가
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "INSERT INTO question(title, startdate, enddate, type) VALUES(?,?,?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		// Statement.RETURN_GENERATED_KEYS 옵션 : insert 후 SELECT MAX(pk) FROM ... 실행
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, question.getTitle());
		stmt.setString(2, question.getStartdate());
		stmt.setString(3, question.getEnddate());
		stmt.setInt(4, question.getType());
		
		System.out.println(stmt);
		
		row = stmt.executeUpdate();		// INSERT
		rs = stmt.getGeneratedKeys();	// SELECT MAX(num) FROM question -> 가장 최근 키
		
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		
		conn.close();
		
		return pk;
	}

	//---------- UPDATE ----------//
	
	// Qnum 받아서 제목, 타입 수정하기
	public void updateQuestion(int qnum, String title, int type) throws ClassNotFoundException, SQLException{
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = "UPDATE question SET"
						+ " title = ?,"
						+ " type = ?"
					+ " WHERE num = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, title);
		stmt.setInt(2, type);
		stmt.setInt(3, qnum);
		
		// 디버깅
		//System.out.println(stmt);
		
		row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("정상 수정");
		}
		else {
			System.out.println("비정상 수정");
		}
		
		conn.close();
	}

	// Qnum이랑, enddate 받아서 투표 종료일 수정하기
	public void updateQuestionEnddate(int qnum, String enddate) throws ClassNotFoundException, SQLException{
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "UPDATE question SET"
						+ " enddate = ?"
					+ " WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, enddate);
		stmt.setInt(2, qnum);
		
		// 디버깅
		//System.out.println(stmt);
		
		row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("정상 수정");
		}
		else {
			System.out.println("비정상 수정");
		}
		
		conn.close();
	}

	
	
	//---------- DELETE ----------//
	
	// Qnum 받아서 삭제하기 투표자 확인(SELECT) -> 삭제(DELETE)
	public boolean deleteQuestion(int qnum) throws ClassNotFoundException, SQLException{
		boolean isDelete = false;
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		// ITEM DELETE
		ItemDao itemDao = new ItemDao();
		itemDao.deleteAllItem(qnum);
		
		// DELETE
		String sql = "DELETE FROM question WHERE num = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		
		row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("정상 삭제");
			isDelete = true;
		}
		else {
			System.out.println("비정상 삭제");
		}
		
		conn.close();
		
		return isDelete;
	}
}
