<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin List</title>
</head>
<body>
<table border="1">
<thead>T4 company</thead>
<tbody>
<c:forEach="" var="name" items="${}">     <!-- 직원 테이블에서 이름 가져와서 리스트로 뿌려주기 -->
<td><input type="radio" id="name" value="name"></td>
</c:forEach>
</tbody>
</table>

</body>
</html>