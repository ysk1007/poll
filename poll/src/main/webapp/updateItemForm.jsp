<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	QuestionDao questionDao = new QuestionDao();
	Question question = questionDao.selectQuestion(qnum);

	ItemDao itemDao = new ItemDao();
	ArrayList<Item> itemList = itemDao.selectItem(qnum);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>투표 하기</title>

    <!-- SB Admin 2 CSS -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">
	<!-- Topbar -->
   	<jsp:include page="/inc/nav.jsp"></jsp:include>
    <!-- 콘텐츠 래퍼 -->
    <div class="container mt-5">
        <div class="card shadow mb-4">
            <div class="card-header py-3 bg-primary">
                <h6 class="m-0 font-weight-bold text-white">투표 하기</h6>
            </div>
            <div class="card-body">
                <form method="post" action="/poll/updateItemAction.jsp">
                    <input type="hidden" name="qnum" value="<%=qnum%>">

                    <div class="mb-3">
                        <strong>Q:</strong> <%=question.getTitle()%>
                        <small class="text-muted">
                            (<%=question.getType() == 1 ? "복수 투표 가능" : "복수 투표 불가능" %>)
                        </small>
                    </div>

                    <div class="mb-3">
                        <% for(Item i : itemList) { %>
                            <div class="form-check">
                                <% if(question.getType() == 0) { %>
                                    <input class="form-check-input" type="radio" name="ck" value="<%=i.getInum()%>" id="item<%=i.getInum()%>">
                                <% } else { %>
                                    <input class="form-check-input" type="checkbox" name="ck" value="<%=i.getInum()%>" id="item<%=i.getInum()%>">
                                <% } %>
                                <label class="form-check-label" for="item<%=i.getInum()%>"><%=i.getContent()%></label>
                            </div>
                        <% } %>
                    </div>

                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check"></i> 투표
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- JS 파일들 -->
    <script src="/vendor/jquery/jquery.min.js"></script>
    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/js/sb-admin-2.min.js"></script>
</body>
</html>
