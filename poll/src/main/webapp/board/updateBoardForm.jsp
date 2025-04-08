<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));

	BoardDao boardDao = new BoardDao();
	Board board = boardDao.selectBoardOne(num);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글입력</title>

<!-- SB Admin 2 CSS -->
<link href="/poll/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link href="/poll/css/sb-admin-2.min.css" rel="stylesheet">

</head>
<body id="page-top">

<!-- Topbar -->
<jsp:include page="/inc/nav.jsp"></jsp:include>

<!-- Main Content -->
<div class="container mt-5">

    <div class="card shadow">
    
        <div class="card-header py-3">
            <h5 class="m-0 font-weight-bold text-primary">글 수정</h5>
        </div>
        <div class="card-body">
            <form method="post" action="/poll/board/updateBoardAction.jsp">
            	<!-- 게시글 번호 넘기기 -->
            	<input type="hidden" name="num" value="<%=num%>">
            
                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%=board.getName()%>">
                </div>
                <div class="form-group">
                    <label for="subject">제목</label>
                    <input type="text" class="form-control" id="subject" name="subject" value="<%=board.getSubject()%>">
                </div>
                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea class="form-control" id="content" name="content" rows="5"><%=board.getContent()%></textarea>
                </div>
                <div class="form-group">
                    <label for="pass">비밀번호</label>
                    <input type="password" class="form-control" id="pass" name="pass" placeholder="비밀번호 입력">
                </div>
                <button type="submit" class="btn btn-primary">수정</button>
                <a href="/poll/board/boardList.jsp" class="btn btn-secondary">목록</a>
            </form>
        </div>
    </div>
</div>

<!-- SB Admin 2 JS -->
<script src="/poll/vendor/jquery/jquery.min.js"></script>
<script src="/poll/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/poll/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/poll/js/sb-admin-2.min.js"></script>

</body>
</html>
