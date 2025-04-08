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
<title>게시글 삭제</title>

<!-- SB Admin 2 CSS -->
<link href="/poll/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet">
<link href="/poll/css/sb-admin-2.min.css" rel="stylesheet">

</head>
<body id="page-top">

<!-- Topbar -->
<jsp:include page="/inc/nav.jsp"></jsp:include>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-lg-6">
        
            <div class="card shadow border-left-danger">
                <div class="card-header bg-danger text-white">
                    <h5 class="m-0">⚠️ 게시글 삭제 확인</h5>
                </div>
                
                <div class="card-body">
                    <p class="mb-4">
                        아래 게시글을 삭제하시려면 비밀번호를 입력하세요.<br>
                        <strong class="text-danger">이 작업은 되돌릴 수 없습니다.</strong>
                    </p>
                    
                    <ul class="list-group mb-3">
                        <li class="list-group-item"><strong>글 번호:</strong> <%=board.getNum()%></li>
                        <li class="list-group-item"><strong>제목:</strong> <%=board.getSubject()%></li>
                        <li class="list-group-item"><strong>작성자:</strong> <%=board.getName()%></li>
                    </ul>
                    
                    <form method="post" action="/poll/board/deleteBoardAction.jsp">
                        <input type="hidden" name="num" value="<%=num%>">
                        <input type="hidden" name="ref" value="<%=board.getRef()%>">
                        <div class="form-group">
                            <label for="pass">비밀번호 입력</label>
                            <input type="password" class="form-control" id="pass" name="pass" placeholder="비밀번호 입력" required>
                        </div>
                        <div class="d-flex justify-content-between">
                            <a href="/poll/board/boardList.jsp" class="btn btn-secondary">취소</a>
                            <button type="submit" class="btn btn-danger">삭제</button>
                        </div>
                    </form>
                </div>
            </div>
            
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
