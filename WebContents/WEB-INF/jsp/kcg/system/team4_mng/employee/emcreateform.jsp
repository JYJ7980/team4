<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 직원 등록</title>

<script src="https://cdn.jsdelivr.net/npm/vue@2.6.12"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

</head>
<body>
	<div id="vueapp">
		
			<h3>신규 직원 등록</h3>
			<table border="1">
				<tr>
					<td for="reg_dt">입사일:</td>
					<td><input type="text" id="reg_dt" v-model="employee.reg_dt"
						disabled></td>
				</tr>
				<tr>
					<td for="user_id">부여할 ID:</td>
					<td><input type="text" id="user_id" v-model="employee.user_id"></td>
				</tr>
				<tr>
					<td for="user_pw">초기 비밀번호:</td>
					<td><input type="text" id="user_pw" v-model="employee.user_pw"></td>
				</tr>
			<!-- 	<tr>
					<td><input type="hidden" id="email" v-model="employee.email"
						disabled></td>
				</tr> -->
				<tr>
					<td for="name">이름:</td>
					<td><input type="text" id="name" v-model="employee.name"></td>
				</tr>
		<!-- 		<tr>
					<td type="hidden" id="auth_cd" v-model="employee.auth_cd"></td>
				</tr> -->
				<tr>
					<td for="status_cd">재직상태:</td>
					<td><select id="status_cd" v-model="employee.status_cd">
							<option value="재직">재직</option>
					</select></td>
				</tr>
				<tr>
					<td for="jikgub_nm">직급:</td>
					<td><select id="jikgub_nm" v-model="employee.jikgub_nm">
							<option value="부장">부장</option>
							<option value="과장">과장</option>
							<option value="대리">대리</option>
							<option value="사원">사원</option>
					</select></td>
				</tr>
				<tr>
					<td for="dept">담당부서:</td>
					<td><select id="dept" v-model="employee.dept">
							<option value="총무">총무</option>
							<option value="영업">영업</option>
							<option value="개발">개발</option>
					</select></td>
				</tr>
			</table>
			<button type="button" @click="save"> 등록 </button>
	</div>
	
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
			// 제목과 내용이 비어있는지 검사
			if (!this.employee.user_id.trim()) {
				alert("부여 할 아이디를 입력하세요.");
				return;
			}
			if (!this.employee.user_pw.trim()) {
				alert("비밀번호를 입력하세요.");
				return;
			}
			if (!this.employee.name.trim()) {
				alert("이름을 입력하세요.");
				return;
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
		                /* auth_cd: this.employee.auth_cd, */
		                status_cd: this.employee.status_cd,
		                jikgub_nm: this.employee.jikgub_nm,
		                dept: this.employee.dept,
		                /* email: this.employee.email */
		     };
			 
			console.log(params);
			 
			axios.post("/system/team4/employee/save", {params:params})
				.then(response => {
					if (response.data.status === "OK") {
						alert("저장되었습니다.");
						window.location.href = '/system/team4/notice/'; // 저장 후 정보창으로 이동
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
</body>
</html>
