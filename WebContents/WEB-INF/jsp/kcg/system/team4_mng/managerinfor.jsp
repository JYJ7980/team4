<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table>
<body>
    
    <form action="/submit" method="get">
        
        <label for="user_id">직원 ID :</label><br>
        <input type="text" id="user_id" name="user_id" required><br><br>
        
        <label for="name">이름 : </label><br>
        <input type="text" id="name" name="name" required><br><br>

        
        <label for="email">이메일:</label><br>
        <input type="email" id="email" name="email" required><br><br>

        
        <label for="status_cd">재직상태 : </label>
         <select id="status_cd" id="status_cd" name="status_cd" required>
            <option value="kr">재직</option>
            <option value="us">휴직</option>
            <option value="us">퇴직</option>
            <option value="us">사직</option>

        </select>
        <input type="조회하기" value="제출">
        <input type="수정하기" value="제출">
        <input type="삭제하기" value="제출">
    </form>

</table>

</body>
</html>