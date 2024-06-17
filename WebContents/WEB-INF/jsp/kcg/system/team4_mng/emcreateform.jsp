<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 직원 등록</title>
<script>
	function updateEmail() {
		var userId = document.getElementById("user_id").value;
		var emailField = document.getElementById("email");
		emailField.value = userId + "@T4company.com";
	}

	function submitForm(event) {
		event.preventDefault(); 

		var formData = {
			reg_dt :document.getElementById("reg_dt").value,	
			user_id: document.getElementById("user_id").value,
			user_pw: document.getElementById("user_pw").value,
			email: document.getElementById("email").value,
			name: document.getElementById("name").value,
			status_cd: document.getElementById("status_cd").value,
			jikgub_nm: document.getElementById("jikgub_nm").value,
			dept: document.getElementById("dept").value
		};

		var xhr = new XMLHttpRequest();
		xhr.open("POST", "/system/team4_mng/emcreateform", true);
		xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				if (xhr.responseText === "success") {
					alert("Employee created successfully!");
				} else {
					alert("Error creating employee.");
				}
			}
		};
		xhr.send(JSON.stringify(formData));
	}
</script>
</head>
<body>
	<form id="emCreateForm" class="emCreateForm" method="post" onsubmit="submitForm(event)">
		<h3>신규 직원 등록</h3>
		<table border="1">
			<tr>
				<td>입사일:</td>
				<td><input type="text" id="reg_dt" name="reg_dt" th:value=${currentDate} disabled></td>
			</tr>
			<tr>
				<td>부여할 ID:</td>
				<td><input type="text" id="user_id" name="user_id" oninput="updateEmail()"></td>
			</tr>
			<tr>
				<td>초기 비밀번호:</td>
				<td><input type="text" id="user_pw" name="user_pw"></td>
			</tr>
			<tr>
				<td>E-mail:</td>
				<td><input type="text" id="email" name="email" disabled></td>
			</tr>
			<tr>
				<td>이름:</td>
				<td><input type="text" id="name" name="name"></td>
			</tr>
			<tr>
				<td>재직상태:</td>
				<td><select id="status_cd" name="status_cd">
						<option value="재직">재직</option>
				</select></td>
			</tr>
			<tr>
				<td>직급:</td>
				<td><select id="jikgub_nm" name="jikgub_nm">
						<option value="부장">부장</option>
						<option value="과장">과장</option>
						<option value="대리">대리</option>
						<option value="사원">사원</option>
				</select></td>
			</tr>
			<tr>
				<td>담당부서:</td>
				<td><select id="dept" name="dept">
						<option value="총무">총무</option>
						<option value="영업">영업</option>
						<option value="서비스">서비스</option>
				</select></td>
			</tr>
		</table>
		<input type="submit" value="등록">
	</form>
</body>
</html>
