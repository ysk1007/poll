<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<%
	// controller(1.요청값 분석, 2.모델 호출)
	// 1. 요청값 분석
	Question question = new Question();
	ArrayList<Item> itemList = new ArrayList<>();
	
	String title = request.getParameter("title");
	String[] items = request.getParameterValues("item");
	
	int inum = 1;
	for(String s : items){
		if(s.isEmpty()){
			continue;
		}
		Item item = new Item();
		
		item.setInum(inum);
		item.setContent(s);
		
		itemList.add(item);
		inum++;
	}
	
	for(Item i : itemList){
		System.out.println(i.getInum()+ "번: " +i.getContent());
	}
	
	// 2. 모델(DAO메서드) 호출

%>