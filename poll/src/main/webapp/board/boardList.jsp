<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	String jsp = "/poll/board/boardList.jsp";
	int currentPage = 1;
	String searchWord = "";
	
	if(request.getParameter("searchWord") != null){
		searchWord = request.getParameter("searchWord");
	}
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	BoardDao boardDao = new BoardDao();
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(8);
	
	int totalRow = boardDao.getTotalCount(searchWord);
	int lastPage = p.getLastPage(totalRow);
	
	ArrayList<Board> list = boardDao.selectBoardList(p,searchWord);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

<!-- SB Admin 2 CSS -->
<link href="/poll/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet">
<link href="/poll/css/sb-admin-2.min.css" rel="stylesheet">
</head>

<body id="page-top">

<!-- Topbar -->
<jsp:include page="/inc/nav.jsp"></jsp:include>
<form method="post" action="<%=jsp%>">
<div class="container mt-5">
	<h3 class="mb-4 font-weight-bold text-gray-800">📋 게시판</h3>

	<div class="card shadow-sm">
		<div class="card-body p-0">
			<table class="table table-hover mb-0">
				<thead class="thead-light">
					<tr>
						<th style="width: 10%;">번호</th>
						<th>제목</th>
						<th>글쓴이</th>
					</tr>
				</thead>
				<tbody>
					<% if(list.size() == 0) { %>
						<tr>
							<td colspan="2" class="text-center">게시글이 없습니다.</td>
						</tr>
					<% } else {
						for(Board b : list){ %>
						<tr>
							<td><%=b.getNum()%></td>
							<td>
								<a href="/poll/board/boardOne.jsp?num=<%=b.getNum()%>" class="text-dark">
									<%
										for(int i = 0; i < b.getDepth(); i++) {
									%>
										<span class="ml-3"></span>
									<% } %>
									<%=b.getDepth() > 0 ? "┗ " : "" %><%=b.getSubject()%>
								</a>
							</td>
							<td><%=b.getName()%></td>
						</tr>
					<% }} %>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Paging -->
    <div class="mt-3">
        <span><%=currentPage%> / <%=lastPage%></span><br>

        <a class="btn btn-outline-primary btn-sm" href="<%=jsp%>?currentPage=1&searchWord=<%=searchWord%>">처음</a>
        <% if(currentPage > 1){ %>
            <a class="btn btn-outline-primary btn-sm" href="<%=jsp%>?currentPage=<%=currentPage - 1%>&searchWord=<%=searchWord%>">이전</a>
        <% } %>
        <% if(currentPage < lastPage){ %>
            <a class="btn btn-outline-primary btn-sm" href="<%=jsp%>?currentPage=<%=currentPage + 1%>&searchWord=<%=searchWord%>">다음</a>
        <% } %>
        <a class="btn btn-outline-primary btn-sm" href="<%=jsp%>?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>
    </div>
    
	<!-- 검색 영역 -->
	<div class="mt-3 d-flex justify-content-between align-items-center">
	    <div class="form-inline">
	        <input type="text" name="searchWord" class="form-control form-control-sm mr-2" 
	               value="<%=searchWord%>" placeholder="게시글 제목 검색">
	        <button type="submit" class="btn btn-sm btn-outline-primary">검색</button>
	    </div>
	
	    <!-- 글쓰기 버튼 -->
	    <div>
	        <a href="/poll/board/insertBoardForm.jsp" class="btn btn-sm btn-primary">
	            <i class="fas fa-pencil-alt"></i> 글쓰기
	        </a>
	    </div>
	</div>

</div>
</form>

<!-- SB Admin 2 JS -->
<script src="/poll/vendor/jquery/jquery.min.js"></script>
<script src="/poll/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/poll/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/poll/js/sb-admin-2.min.js"></script>
</body>
</html>
