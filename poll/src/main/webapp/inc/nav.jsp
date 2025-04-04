<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

    <!-- Brand / Logo -->
    <a class="navbar-brand font-weight-bold text-primary" href="/poll/pollList.jsp">
        📊 설문 관리
    </a>

    <!-- Topbar Navbar (오른쪽 메뉴) -->
    <ul class="navbar-nav ml-auto">

        <!-- 리스트 버튼 -->
        <li class="nav-item">
            <a class="btn btn-sm btn-outline-primary mx-1" href="/poll/pollList.jsp">
                <i class="fas fa-list fa-sm text-primary"></i> 리스트
            </a>
        </li>

        <!-- 설문 추가 버튼 -->
        <li class="nav-item">
            <a class="btn btn-sm btn-outline-success mx-1" href="/poll/insertPollForm.jsp">
                <i class="fas fa-plus fa-sm text-success"></i> 설문추가
            </a>
        </li>

    </ul>

</nav>
