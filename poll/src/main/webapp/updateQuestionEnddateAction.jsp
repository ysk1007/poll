<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	// param 받기
	String enddate = request.getParameter("enddate");
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	
	// 오늘 날짜 가져오기
    Calendar today = Calendar.getInstance();
    today.set(Calendar.HOUR_OF_DAY, 0);
    today.set(Calendar.MINUTE, 0);
    today.set(Calendar.SECOND, 0);
    today.set(Calendar.MILLISECOND, 0);
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Date todayDate = today.getTime();
	
    Date endDate = sdf.parse(enddate);
	
    // 날짜 비교
    if (endDate.before(todayDate)) { // 만약 수정할 종료일이 오늘보다 전이라면 다시 수정 페이지로 돌아감
    	response.sendRedirect("/poll/updateQuestionEnddateForm.jsp?qnum="+qnum);
    	return;
    }
    
	// 투표 정보 입력
	Question question = new Question();
	question.setEnddate(enddate);

	// Question 모델 호출해서 수정
	QuestionDao questionDao = new QuestionDao();
	questionDao.updateQuestionEnddate(qnum,enddate);

	// view가 필요가 없다 -> 새로운 요청 pollList.jsp
	response.sendRedirect("/poll/pollList.jsp");
%>