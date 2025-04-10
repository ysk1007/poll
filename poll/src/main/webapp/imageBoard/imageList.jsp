<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<%
	String jsp = "/poll/imageBoard/imageList.jsp";
	int currentPage = 1;
	String searchWord = "";
	
	if(request.getParameter("searchWord") != null){
		searchWord = request.getParameter("searchWord");
	}
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	ImageDao imageDao = new ImageDao();
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(8);
	
	int totalRow = imageDao.getTotalCount(searchWord);
	int lastPage = p.getLastPage(totalRow);
	
	ArrayList<Image> list = imageDao.selectImageList(p, searchWord);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		for(Image i :list){
			%>
				<table>
					<tr>
						<td><%=i.getMemo()%></td>
					</tr>
					<tr>
						<td>
							<img src="/poll/upload/<%=i.getFileName()%>">
						</td>
					</tr>
					<tr>
						<td>
							<a href="/poll/imageBoard/deleteImage.jsp?num=<%=i.getNum()%>&filename=<%=i.getFileName()%>">삭제</a>
						</td>
					</tr>
				</table>
			<%
		}
	%>
</body>
</html>