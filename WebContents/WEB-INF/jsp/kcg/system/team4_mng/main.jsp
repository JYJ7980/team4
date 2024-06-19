<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false"/>
	<!-- Imported styles on this page -->
	<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">

</head>
<body class="page-body">

<div class="page-container" >

	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>
	
	대시보드 페이지
<br><br>
<a href="/system/team4/notice/">공지사항 메인</a><br>
<a href="/system/team4/customerInfoPage">고객관리 페이지</a><br>
<a href="/system/team4/consultListPage">상담내역 페이지</a>
</div>
</body>
</html>