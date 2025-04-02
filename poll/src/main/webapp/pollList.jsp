<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// question 테이블 리스트 -> 페이징 -> title링크(startdate <= 오늘날짜 <= enddate) -> 투표프로그램
	// QuestionDao.selectQuestionList()
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int lastPage = 0;
	
	String jsp = "/poll/pollList.jsp";
	
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	
	ArrayList<Question> list = questionDao.selectQuestionList(paging);
	
	lastPage = paging.getLastPage(questionDao.getTotalDataCount());
	
	Calendar c = Calendar.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 리스트</title>
</head>
<body>
	<h1>투표리스트</h1>
	<a href="/poll/insertPollForm.jsp">[생성]</a>
	<!-- paging 출력 
	링크(startdate <= 오늘날짜 <= enddate) 투표시작전, 투표종료, 투표하기-->
	<table border="1">
		<tr>
			<th>투표 번호</th>
			<th>주제</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>타입</th>
		</tr>
	<%
		for(Question q : list){
			%>
			<tr>
				<td><%=q.getNum()%></td>
				<td><%=q.getTitle()%></td>
				<td><%=q.getStartdate()%></td>
				<td><%=q.getEnddate()%></td>
				<td><%=q.getType()%></td>
			</tr>
			<%
		}
	%>
	</table>
	
	<%=currentPage%> / <%=lastPage%>
	
	<br>
	
	<!-- 네비게이션 -->
	<a href="<%=jsp%>?currentPage=1">[처음]</a>
	<%
		if(currentPage > 1){
			%><a href="<%=jsp%>?currentPage=<%=currentPage - 1%>">[이전]</a><%
		}
	%>
	
	<%
		if(currentPage < lastPage){
			%><a href="<%=jsp%>?currentPage=<%=currentPage + 1%>">[다음]</a><%
		}
	%>
	
	<a href="<%=jsp%>?currentPage=<%=lastPage%>">[마지막]</a>
</body>
</html>