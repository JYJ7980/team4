<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 조회</title>
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.12"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
var vueapp = new Vue({
	el: "#vueapp",
	data: {
		employee: {
			reg_dt:"",
			user_id:"",
			user_pw:"",
			name:"",
			auth_cd:"",
			status_cd:"",
			jikgub_nm:"",
			dept:"",
			email:""
		}
	},
	mounted: function() {
		// 필요한 경우 초기화 작업 수행
	},
	
	methods: {
		save: function () {
			}
			if (!this.employee.jikgub_nm.trim()) {
				alert("직급을 선택 해주세요.");
				return;
			}
			if (!this.employee.dept.trim()) {
				alert("부서를 선택하세요.");
				return;
			}

			// 저장 요청 보내기
			if (!confirm("저장하시겠습니까?")) return;
			
			 var params = {
		                user_id: this.employee.user_id,
		                user_pw: this.employee.user_pw,
		                name: this.employee.name,
		                auth_cd: this.employee.auth_cd,
		                status_cd: this.employee.status_cd,
		                jikgub_nm: this.employee.jikgub_nm,
		                dept: this.employee.dept,
		                email: this.employee.email
		            };
			
			console.log(params);
			axios.post("/system/team4/notice/save", {params:params})
				.then(response => {
					if (response.data.status === "OK") {
						alert("저장되었습니다.");
						window.location.href = '/system/team4/employeeinfo/'; // 저장 후 목록으로 이동
					} else {
						alert("저장 실패: " + response.data.message);
					}
				})
				.catch(error => {
					alert("오류 발생: " + error);
				});
		
		}
	}
	
	
});
</script>
</head>
<body>
<div id="vueapp">
	<form class="form-group" id="updateEmployee" method="post">
		<h3>직원 정보</h3>
		<table border="1" >
			<tr>
				<td>입사년월</td>
				<td type="text" id="reg_dt" v-model="employee.reg_dt" disabled></td>
			</tr>
			<tr>
				<td>직원 ID</td>
				<td type="text" id="user_id" v-model="employee.user_id" disabled></td>
			</tr>
			<tr>
				<td>E-mail</td>
				<td type="text" id="email" v-model="employee.email" disabled></td>
			</tr>
			<tr>
				<td>이름</td>
				<td type="text" id="name" v-model="employee.name"></td>
			</tr>
			<tr>
				<td>재직상태</td>
				<td><select id="status_cd" v-model="status_cd">
						<option value="재직">재직</option>
						<option value="휴직">휴직</option>
						<option value="사직">사직</option>
					</select></td>
			</tr>
			<tr>
				<td>직급</td>
				<td><select id="jikgub_nm" v-model="employee.jikgub_nm">
						<option value="부장">부장</option>
						<option value="과장">과장</option>
						<option value="대리">대리</option>
						<option value="사원">사원</option>
					</select></td>
			</tr>
			<tr>
				<td>담당부서</td>
				<td><select id="dept" v-model="employee.dept">
							<option value="총무">총무</option>
							<option value="영업">영업</option>
							<option value="개발">개발</option>
					</select></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>