<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>

<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 8;
	int lastPage = 0;
	String jsp = "/poll/pollList.jsp";
	
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<Question> list = questionDao.selectQuestionList(paging);
	lastPage = paging.getLastPage(questionDao.getTotalDataCount());
	
	Calendar today = Calendar.getInstance();
	today.set(Calendar.HOUR_OF_DAY, 0);
	today.set(Calendar.MINUTE, 0);
	today.set(Calendar.SECOND, 0);
	today.set(Calendar.MILLISECOND, 0);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date todayDate = today.getTime();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>투표 리스트</title>

    <!-- SB Admin 2 CSS -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">

<div id="wrapper">
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

		<!-- Topbar -->
     	<jsp:include page="/inc/nav.jsp"></jsp:include>
	
        <div id="container-fluid" class="container-fluid mt-4">

            <!-- Data Table -->
            <div class="card shadow mb-4">
            	<div class="card-header py-3">
            	<h5 class="m-0 font-weight-bold text-primary">투표 리스트</h5>
        		</div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" width="100%" cellspacing="0">
                            <thead class="thead-light">
                                <tr>
                                    <th>번호</th>
                                    <th>주제</th>
                                    <th>기간</th>
                                    <th>투표수</th>
                                    <th>복수투표</th>
                                    <th>투표하기</th>
                                    <th>삭제</th>
                                    <th>수정</th>
                                    <th>종료일 수정</th>
                                    <th>결과</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (Question q : list) {
                                        Date startDate = sdf.parse(q.getStartdate());
                                        Date endDate = sdf.parse(q.getEnddate());
                                %>
                                <tr>
                                    <td><%= q.getNum() %></td>
                                    <td><%= q.getTitle() %></td>
                                    <td><%= q.getStartdate() %> ~ <%= q.getEnddate() %></td>
                                    <td><%= q.getCount() %></td>
                                    <td><%= q.getType() == 1 ? "가능" : "불가능" %></td>
                                    <td>
                                        <%
                                            if (todayDate.before(startDate)) {
                                                out.print("투표시작전");
                                            } else if (todayDate.after(endDate)) {
                                                out.print("투표종료");
                                            } else {
                                        %>
                                        <a href="/poll/updateItemForm.jsp?qnum=<%=q.getNum()%>" class="btn btn-sm btn-primary">투표하기</a>
                                        <% } %>
                                    </td>
                                    <td>
                                        <%
                                            if (q.getCount() > 0) {
                                                out.print("삭제 불가");
                                            } else {
                                        %>
                                        <a href="/poll/deletePollAction.jsp?qnum=<%=q.getNum()%>" class="btn btn-sm btn-danger">삭제</a>
                                        <% } %>
                                    </td>
                                    <td>
                                        <%
                                            if (todayDate.after(endDate)) {
                                                out.print("종료됨");
                                            } else if (q.getCount() > 0) {
                                                out.print("수정 불가");
                                            } else {
                                        %>
                                        <a href="/poll/updatePollForm.jsp?qnum=<%=q.getNum()%>" class="btn btn-sm btn-warning">수정</a>
                                        <% } %>
                                    </td>
                                    <td>
                                        <a href="/poll/updateQuestionEnddateForm.jsp?qnum=<%=q.getNum()%>" class="btn btn-sm btn-info">종료일 수정</a>
                                    </td>
                                    <td>
                                        <%
                                            if (todayDate.after(endDate)) {
                                        %>
                                        <a href="/poll/questionOneResult.jsp?qnum=<%=q.getNum()%>" class="btn btn-sm btn-success">결과</a>
                                        <% } else { out.print("집계중"); } %>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Paging -->
                    <div class="mt-3">
                        <span><%=currentPage%> / <%=lastPage%></span><br>

                        <a class="btn btn-outline-primary btn-sm" href="<%=jsp%>?currentPage=1">처음</a>
                        <% if(currentPage > 1){ %>
                            <a class="btn btn-outline-primary btn-sm" href="<%=jsp%>?currentPage=<%=currentPage - 1%>">이전</a>
                        <% } %>
                        <% if(currentPage < lastPage){ %>
                            <a class="btn btn-outline-primary btn-sm" href="<%=jsp%>?currentPage=<%=currentPage + 1%>">다음</a>
                        <% } %>
                        <a class="btn btn-outline-primary btn-sm" href="<%=jsp%>?currentPage=<%=lastPage%>">마지막</a>
                    </div>
					<!-- 글쓰기 버튼 -->
					<div class="text-right mt-3">
						<a href="/poll/insertPollForm.jsp" class="btn btn-primary btn-sm">
							<i class="fas fa-pencil-alt"></i> 생성
						</a>
					</div>
                </div>
            </div>

        </div> <!-- End Content -->

    </div> <!-- End Content Wrapper -->

</div> <!-- End Page Wrapper -->

<!-- SB Admin 2 JS -->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/js/sb-admin-2.min.js"></script>

</body>
</html>
