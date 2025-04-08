<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDao boardDao = new BoardDao();
	Board b = boardDao.selectBoardOne(num);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 보기</title>

<!-- SB Admin 2 스타일 -->
<link href="/poll/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet">
<link href="/poll/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">

<!-- Topbar -->
<jsp:include page="/inc/nav.jsp"></jsp:include>

<!-- 메인 콘텐츠 -->
<div class="container mt-5">
	<div class="row justify-content-center">
		<div class="col-lg-10">
			<div class="card shadow-sm">
				<div class="card-body">

					<!-- 상단 액션 영역 -->
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h4 class="mb-0 font-weight-bold text-gray-800"><%=b.getSubject()%></h4>
						<div>
							<a href="/poll/board/updateBoardForm.jsp?num=<%=num%>" class="btn btn-warning btn-sm mr-1">수정</a>
							<a href="/poll/board/deleteBoardForm.jsp?num=<%=num%>" class="btn btn-danger btn-sm mr-1">삭제</a>
							<a href="/poll/board/insertBoardReplyForm.jsp?ref=<%=b.getRef()%>&pos=<%=b.getPos()%>&depth=<%=b.getDepth()%>" class="btn btn-info btn-sm">답글 달기</a>
						</div>
					</div>

					<hr>

					<!-- 게시글 정보 -->
					<div class="mb-3">
						<div class="text-muted">
							작성자: <%=b.getName()%> |
							작성일: <%=b.getRegdate()%> |
							조회수: <%=b.getCount()%>
						</div>
					</div>

					<!-- 게시글 내용 -->
					<div class="mb-4">
						<pre style="white-space: pre-wrap;"><%=b.getContent()%></pre>
					</div>

					<!-- 기술적 정보 (숨겨도 무방) -->
					<div class="small text-muted">
						IP: <%=b.getIp()%> |
						Ref: <%=b.getRef()%> |
						Pos: <%=b.getPos()%> |
						Depth: <%=b.getDepth()%>
					</div>
				</div>
			</div>

			<!-- 뒤로가기 버튼 -->
			<div class="text-right mt-3">
				<a href="/poll/board/boardList.jsp" class="btn btn-secondary btn-sm">목록으로</a>
			</div>
		</div>
	</div>
</div>

<!-- JS 파일 -->
<script src="/poll/vendor/jquery/jquery.min.js"></script>
<script src="/poll/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/poll/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/poll/js/sb-admin-2.min.js"></script>
</body>
</html>
