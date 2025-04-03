<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	// param 받기
	int qnum = Integer.parseInt(request.getParameter("qnum"));

	// Question 모델 호출해서 DELETE
	QuestionDao questionDao = new QuestionDao();
	
	if(questionDao.deleteQuestion(qnum)){ // 삭제 성공
		System.out.println("삭제 성공!");
	
		// 리스트 페이지로
		response.sendRedirect("/poll/pollList.jsp");
	}
	else{	// 삭제 실패
		System.out.println("투표자가 있습니다. 삭제 실패!");
	
		// 리스트 페이지로
		response.sendRedirect("/poll/pollList.jsp");
	}
%>