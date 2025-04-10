<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String fileName = request.getParameter("filename");

	// db 삭제
	ImageDao imageDao = new ImageDao();
	imageDao.deleteImage(num);
	
	// 파일 삭제
	
	// 톰켓안에 poll 프로젝트안 upload폴더 실제 물리적 주소를 반환
	String path = request.getServletContext().getRealPath("upload");
	File file = new File(path, fileName);	// new File 경로에 파일이 없으면 빈파일을 생성을 준비
	
	if(file.exists()){	// 빈파일이 아니라면
		file.delete();			
	}
	
	response.sendRedirect("/poll/imageBoard/imageList.jsp");
%>