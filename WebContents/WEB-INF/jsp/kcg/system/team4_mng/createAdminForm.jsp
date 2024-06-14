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
	<form>
		<body>
		<div class="form-wrapper">
		<header> 신규 매니저 등록 </header>
		<form action="/createAdminForm" method="post">

		<!-- <div class="form-group">
                <label for="reg_dt"> 입사일 : </label>
             
                current_date.now() / session / select current_date from dual;
            </div>  작성일 당일이 입사일이 되도록 저장 disabled 로 확인만 가능하게 -->
            
            
            <div class="form-group">
                <label for="manager_id"> 부여 할 ID : </label>   <!-- 매니저에게 부여할 id를 작성 -->
                <input type="text" id="manager_id" name="manager_id" required>
            </div>
            
            <div class="form-group">
                <label for="user_pw"> 비밀번호: </label>  <!-- 매니저의 초기 비밀번호 부여 -->
                <input type="text" id="user_pw" name="manager_pw" required>
            </div>
            
            
            <div class="form-group">
                <label for="name"> 이름 : </label>  매니저의 이름을 작성
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="status_cd"> 재직상태 : </label>   <!-- 직급 선택 -->
                <!-- <input type="text" id="manager_position " name="manager_position " required> -->
                <select id="jikgub_nm" name="jikgub_nm">
                <option value="disabled"> 입사 </option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="jikgub_nm"> 직급 : </label>   <!-- 직급 선택 -->
                <!-- <input type="text" id="manager_position " name="manager_position " required> -->
                <select id="jikgub_nm" name="jikgub_nm">
                <option value="none"> 부여 할 직급을 선택하세요. </option>
                <option value=""> 팀장 </option>   <!-- 예시 -->
                <option value=""> 대리 </option>
                <option value=""> 사원 </option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="manager_dep "> 담당부서 : </label>    <!-- 담당 부서를 select? -->
                <!-- <input type="text" id="manager_dep " name="manager_dep " required> -->
                <select id="dep" name="dep">
                <option value="none"> 담당부서를 선택하세요. </option>
                <option value=""> 총무 </option>  <!-- 에시 -->
                <option value=""> 영업 </option>
                <option value=""> 고객응대 </option>
                </select>
            </div>
            
            <div class="form-group">
                <input type="submit" value="제출">
                </div>
                </form>
		</div>
		</body>
	</form>

</body>
</html>