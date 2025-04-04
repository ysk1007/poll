<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<%
    int qnum = 0;
    if(request.getParameter("qnum") != null){
        qnum = Integer.parseInt(request.getParameter("qnum"));
    }

    QuestionDao questionDao = new QuestionDao();
    ItemDao itemDao = new ItemDao();

    Question question = questionDao.selectQuestion(qnum);
    ArrayList<Item> itemList = itemDao.selectItem(qnum);
    int listSize = itemList.size();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>설문 수정</title>

    <!-- SB Admin 2 CSS -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">
    <!-- nav.jsp 인클루드 -->
    <jsp:include page="/inc/nav.jsp" />

    <div class="container mt-5">
        <div class="card shadow mb-4">
            <div class="card-header bg-warning">
                <h6 class="m-0 font-weight-bold text-dark">설문 수정</h6>
            </div>
            <div class="card-body">
                <form method="post" action="/poll/updatePollAction.jsp">
                    <input type="hidden" name="qnum" value="<%=question.getNum()%>">

                    <div class="form-group">
                        <label>질문</label>
                        <input type="text" class="form-control" name="title" value="<%=question.getTitle()%>">
                    </div>

                    <label class="mt-4">항목</label>
                    <div class="row">
                        <% for(int i = 0; i < 8; i++) { %>
                            <div class="col-md-6 mb-3">
                                <label><%= (i+1) %>)</label>
                                <input type="text" class="form-control" name="content" value="<%= listSize > i ? itemList.get(i).getContent() : "" %>">
                            </div>
                        <% } %>
                    </div>

                    <div class="form-group">
                        <label>시작일</label>
                        <input type="date" class="form-control" name="startdate" value="<%=question.getStartdate()%>" readonly>
                    </div>

                    <div class="form-group">
                        <label>종료일</label>
                        <div class="d-flex align-items-center">
                            <input type="date" class="form-control mr-2" name="enddate" value="<%=question.getEnddate()%>" readonly>
                            <a href="/poll/updateQuestionEnddateForm.jsp?qnum=<%=qnum%>" class="btn btn-sm btn-outline-primary">종료일자 수정</a>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>복수투표 허용 여부</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="type" value="1" <%=question.getType() == 1 ? "checked" : "" %>>
                            <label class="form-check-label">예</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="type" value="0" <%=question.getType() == 0 ? "checked" : "" %>>
                            <label class="form-check-label">아니오</label>
                        </div>
                    </div>

                    <div class="mt-4">
                        <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> 수정하기</button>
                        <a href="/poll/pollList.jsp" class="btn btn-secondary ml-2"><i class="fas fa-list"></i> 리스트</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- JS -->
    <script src="/vendor/jquery/jquery.min.js"></script>
    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/js/sb-admin-2.min.js"></script>
</body>
</html>
