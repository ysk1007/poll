<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));

	// Controller Layer(request분석, model 호출)
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pass = request.getParameter("pass");
	
	String ip = request.getRemoteAddr();
	
	// Form 입력타입(DTO사용가능)으로 묶음
	Board board = new Board();
	board.setNum(num);
	board.setName(name);
	board.setSubject(subject);
	board.setContent(content);
	board.setPass(pass);
	board.setIp(ip);
	
	
	// logging(디버깅,...)
	//System.out.println(board.toString());
	
	BoardDao boardDao = new BoardDao();
	
	if(boardDao.updateBoard(board)){ // UPDATE 성공
		response.sendRedirect("/poll/board/boardList.jsp");
	}
	else{ // UPDATE 실패
		response.sendRedirect("/poll/board/updateBoardForm.jsp?num="+ num);
	}
%>