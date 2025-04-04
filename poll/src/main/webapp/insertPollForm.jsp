<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>설문 작성</title>

    <!-- SB Admin 2 CSS -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
   			<jsp:include page="/inc/nav.jsp"></jsp:include>

            <!-- Begin Page Content -->
            <div class="container-fluid mt-4">

                <!-- Page Heading -->
                <h1 class="h3 mb-4 text-gray-800">설문 작성</h1>

                <!-- 설문 작성 폼 -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">설문 항목 입력</h6>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/poll/insertPollAction.jsp">
                            <div class="form-group">
                                <label for="title">질문</label>
                                <input type="text" class="form-control" id="title" name="title" placeholder="설문 질문 입력">
                            </div>

                            <label>항목</label>
                            <div class="form-row">
                                <% for (int i = 1; i <= 8; i += 2) { %>
                                    <div class="form-group col-md-6">
                                        <label><%= i %>)</label>
                                        <input type="text" class="form-control" name="content" placeholder="항목 <%= i %> 입력">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label><%= i + 1 %>)</label>
                                        <input type="text" class="form-control" name="content" placeholder="항목 <%= i + 1 %> 입력">
                                    </div>
                                <% } %>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="startdate">시작일</label>
                                    <input type="date" class="form-control" id="startdate" name="startdate">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="enddate">종료일</label>
                                    <input type="date" class="form-control" id="enddate" name="enddate">
                                </div>
                            </div>

                            <div class="form-group">
                                <label>복수 투표 가능 여부</label><br>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="type" id="type1" value="1">
                                    <label class="form-check-label" for="type1">Yes</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="type" id="type0" value="0" checked>
                                    <label class="form-check-label" for="type0">No</label>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">작성하기</button>
                            <button type="reset" class="btn btn-secondary">다시쓰기</button>
                        </form>
                    </div>
                </div>

            </div>
            <!-- End Page Content -->

        </div>
        <!-- End Main Content -->
    </div>
    <!-- End Content Wrapper -->

</div>
<!-- End Page Wrapper -->

<!-- SB Admin 2 JS -->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/js/sb-admin-2.min.js"></script>

</body>
</html>
