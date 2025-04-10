<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>이미지 올리기</title>
    </head>
    <body>
    <%
    	if(request.getParameter("msg") != null){	// insertImageAction png 파일이 아니라서 redirect
    		%><div><h1 style="color:red"><%=request.getParameter("msg")%></h1></div><%
    	}
    %>
    
    <form action="/poll/imageBoard/insertImageAction.jsp" method="post" enctype="multipart/form-data">
		<div>메모 : <input type="text" name="memo"/></div>
		<div>이미지 : <input type="file" name="imageFile"/></div>
		<button type="submit">이미지 저장</button>
    </form>
    </body>
</html>