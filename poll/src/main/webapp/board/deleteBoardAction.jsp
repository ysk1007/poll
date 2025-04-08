<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// Controller Layer(request분석, model 호출)
	
	int num = Integer.parseInt(request.getParameter("num"));
	int ref = Integer.parseInt(request.getParameter("ref"));
	
	String pass = request.getParameter("pass");
	
	BoardDao boardDao = new BoardDao();
	
	if(boardDao.deleteBoard(num, pass)){	// 삭제 성공
		boardDao.updateBoardChild(ref);
	
		response.sendRedirect("/poll/board/boardList.jsp");
	}
	else{	// 삭제 실패
		response.sendRedirect("/poll/board/deleteBoardForm.jsp?num="+num);
	}
%>