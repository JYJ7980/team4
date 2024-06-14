<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 매니저 등록</title>
</head>
<body>
		<body>
		<div class="form-wrapper">
		<header> 신규 매니저 등록 </header>
		<form action="/createAdminForm" method="post">

		<!-- <div class="form-group">
                <label for="reg_dt"> 입사일 : </label>
             
                current_date.now() / session / select current_date from dual;
            </div>  작성일 당일이 입사일이 되도록 저장 disabled 로 확인만 가능하게 -->
            
            
                <label for="user_id"> 부여 할 ID : </label>   <!-- 매니저에게 부여할 id를 작성 -->
                <input type="text" id="user_id" name="user_id" placeholder="ID를 입력해 주세요" required>
            
                <label for="user_pw"> 비밀번호: </label>  <!-- 매니저의 초기 비밀번호 부여 -->
                <input type="text" id="user_pw" name="manager_pw" placeholder="" required>
            
            
                <label for="name"> 이름 : </label> <!--  매니저의 이름을 작성 -->
                <input type="text" id="name" name="name" placeholder="이름을 작성해 주세요" required>
            
                <label for="status_cd"> 재직상태 : </label>   <!-- 직급 선택 -->
                <select id="status_cd" name="status_cd">
                <option value="disabled"> 입사 </option>
                </select>
                
                <label for="email">이메일</label>
                <input type="disable" id="email" name="email" placeholder=user_id + @T4company
            
                <label for="jikgub_nm"> 직급 : </label>   <!-- 직급 선택 -->
                <!-- <input type="text" id="manager_position " name="manager_position " required> -->
                <select id="jikgub_nm" name="jikgub_nm">
                <option value="none"> 부여 할 직급을 선택하세요. </option>
                <option value=""> 팀장 </option>   <!-- 예시 -->
                <option value=""> 대리 </option>
                <option value=""> 사원 </option>
                </select>
            
                <label for="dept"> 담당부서 : </label>    <!-- 담당 부서를 select? -->
                <!-- <input type="text" id="manager_dep " name="manager_dep " required> -->
                <select id="dep" name="dep">
                <option value="none"> 담당부서를 선택하세요. </option>
                <option value=""> 총무 </option>  <!-- 에시 -->
                <option value=""> 영업 </option>
                <option value=""> 고객응대 </option>
                </select>
            
                <input type="submit" value="제출">
                </form>
                
                <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
		function submitNewCustomerForm() { 
		var formData = { '
				manager_id: $("#manager_id").val(),
				user_pw: $("#user_pw").val(),
				name: $("#name").val(),
				status_cd: $("#status_cd").val(),
				jikgub_nm: $("#jikgub_nm").val(),
				dept: $("#dept").val(),
				날자 : $("#").val()		/* 날자 */
				manager_id: $("#manager_id").val()		/* 이메일저장 */
		}; 
		$.ajax({
		url: "<c:url value='/createAdminForm'></c:url>",
        type: "POST",
        data: formData,
        success: function(response) {
            // 서버로부터 응답을 받은 경우 처리할 내용을 추가합니다.
            alert("사용자 등록이 완료되었습니다.");
            // 사용자 등록이 성공하면 원하는 동작을 수행합니다.
        },
        error: function(xhr, status, error) {
            // 오류가 발생한 경우 오류를 처리합니다.
            console.error("Error:", error);
            alert("사용자 등록 중 오류가 발생했습니다.");
        }
    });
		</script>
		</div>
		</body>

</body>
</html>