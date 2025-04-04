<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
    String[] color = {"bg-danger", "bg-warning", "bg-info", "bg-success", "bg-primary", "bg-secondary", "bg-dark", "bg-pink"};
    int qnum = Integer.parseInt(request.getParameter("qnum"));

    QuestionDao questionDao = new QuestionDao();
    ItemDao itemDao = new ItemDao();

    Question question = questionDao.selectQuestion(qnum);
    ArrayList<Item> itemList = itemDao.selectItem(qnum);

    int totalCount = itemDao.selectItemCount(qnum);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>투표 결과</title>

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
            <div class="card-header bg-primary text-white">
                <h6 class="m-0 font-weight-bold">[<%=qnum%>번] 설문 투표 결과</h6>
            </div>
            <div class="card-body">
                <h5 class="mb-3">
                    Q: <%=question.getTitle()%>
                </h5>
                <p><strong>총 투표수:</strong> <%=totalCount%></p>

                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th>번호</th>
                                <th>내용</th>
                                <th style="width: 50%">투표율</th>
                                <th>카운트</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(Item i : itemList) {
                                int per = (totalCount == 0) ? 0 : (int)Math.round((i.getCount() / (double)totalCount) * 100);
                                int colorIndex = (i.getInum() - 1) % color.length;
                            %>
                            <tr>
                                <td><%=i.getInum()%></td>
                                <td><%=i.getContent()%></td>
                                <td>
                                    <div class="progress">
                                        <div class="progress-bar <%=color[colorIndex]%>" role="progressbar" style="width: <%=per%>%;">
                                            <%=per%>%
                                        </div>
                                    </div>
                                </td>
                                <td><%=i.getCount()%></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <a href="/poll/pollList.jsp" class="btn btn-secondary mt-3"><i class="fas fa-list"></i> 설문 목록으로</a>
            </div>
        </div>
    </div>

    <!-- JS -->
    <script src="/vendor/jquery/jquery.min.js"></script>
    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/js/sb-admin-2.min.js"></script>
</body>
</html>
