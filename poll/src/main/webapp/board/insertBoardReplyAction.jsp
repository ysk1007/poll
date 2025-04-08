<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// Controller Layer(request분석, model 호출)
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pass = request.getParameter("pass");
	
	String ip = request.getRemoteAddr();
	
	int ref = Integer.parseInt(request.getParameter("ref"));
	int pos = Integer.parseInt(request.getParameter("pos"));
	int depth = Integer.parseInt(request.getParameter("depth"));
	
	// Form 입력타입(DTO사용가능)으로 묶음
	Board board = new Board();
	board.setName(name);
	board.setSubject(subject);
	board.setContent(content);
	board.setPass(pass);
	board.setIp(ip);
	
	// 답글에 필요한 속성
	board.setRef(ref);
	board.setPos(pos);
	board.setDepth(depth);
	
	// logging(디버깅,...)
	System.out.println(board.toString());
	
	BoardDao boardDao = new BoardDao();
	boardDao.insertBoardReply(board);
	
	// 뷰가 있다면 뷰를 연결, 뷰가 없다면 클라이언트에 다른 요청을 강제
	response.sendRedirect("/poll/board/boardList.jsp");
%>