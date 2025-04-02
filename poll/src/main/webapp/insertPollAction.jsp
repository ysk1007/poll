<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// controller(1.요청값 분석, 2.모델 호출)
	// 1. 요청값 분석
	String title = request.getParameter("title");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	int type = Integer.parseInt(request.getParameter("type"));
	
	Question question = new Question();
	question.setTitle(title);
	question.setStartdate(startdate);
	question.setEnddate(enddate);
	question.setType(type);
	
	// item.content 공백요소는 제외해야함
	String[] contents = request.getParameterValues("content");

	// 2. Question 모델(DAO메서드) 호출
	QuestionDao questionDao = new QuestionDao();
	int qnum = questionDao.insertQuestion(question);
	
	ArrayList<Item> itemList = new ArrayList<>();
	
	int inum = 1;
	for(String s : contents){
		if(s.isEmpty()){
			continue;
		}
		Item item = new Item();
		
		item.setQnum(qnum);
		item.setInum(inum);
		item.setContent(s);
		
		itemList.add(item);
		inum++;
	}
	
	// 2-1. Item 모델(DAO메서드) 호출
	ItemDao itemDao = new ItemDao();
	for(Item i : itemList){
		itemDao.insertItem(i);
	}
	
	// view가 필요가 없다 -> 새로운 요청 pollList.jsp
	response.sendRedirect("/poll/pollList.jsp");
%>