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
<<<<<<< HEAD
	<div id="vueapp">
		<table class="createForm">
			<h3>신규 직원 등록</h3>
			<div for="user_id">
				부여할 ID:
				<div>
					<input type="text" id="user_id" v-model="employee.user_id" :disabled="isIdChecked">
					<input type="submit" id="user_id" value="ID중복확인" @click="checkId">
				</div>
				<br>
				<div>초기 비밀번호:</div>
				<div>
					<input type="text" id="user_pw" v-model="employee.user_pw">
				</div>
				<div>이름:</div>
				<div>
					<input type="text" id="name" v-model="employee.name">
				</div>
				
				<div>직급:</div>
				<div>
					<select id="jikgub_nm" v-model="employee.jikgub_nm">
						<option value="수습">수습</option>
						<option value="부장">부장</option>
						<option value="차장">차장</option>
						<option value="과장">과장</option>
						<option value="대리">대리</option>
						<option value="사원">사원</option>
					</select>
				</div>
				<div>담당부서:</div>
				<div>
					<select id="dept" v-model="employee.dept">
						<option value="">부서를 선택해주세요</option>
						<option value="영업1팀">영업1팀</option>
						<option value="영업2팀">영업2팀</option>
						<option value="총무팀">총무팀</option>
						<option value="개발팀">개발팀</option>
					</select>
				</div>
		</table>
		<br>
		<button type="button" @click="save">등록</button>
	</div>
=======
   <div id="vueapp">
      <table class="createForm">
         <h3>신규 직원 등록</h3>
         <div for="user_id">
            부여할 ID:
            <div>
               <input type="text" id="user_id" v-model="employee.user_id" :disabled="isIdChecked">
               <input type="submit" id="user_id" value="ID중복확인" @click="checkId">
            </div>
            <br>
            <div>초기 비밀번호:</div>
            <div>
               <input type="text" id="user_pw" v-model="employee.user_pw">
            </div>
            <div>이름:</div>
            <div>
               <input type="text" id="name" v-model="employee.name">
            </div>
            
            <div>직급:</div>
            <div>
               <select id="jikgub_nm" v-model="employee.jikgub_nm">
                  <option value="수습">수습</option>
                  <option value="부장">부장</option>
                  <option value="차장">차장</option>
                  <option value="과장">과장</option>
                  <option value="대리">대리</option>
                  <option value="사원">사원</option>
               </select>
            </div>
            <div>담당부서:</div>
            <div>
               <select id="dept" v-model="employee.dept">
                  <option value="">부서를 선택해주세요</option>
                  <option value="영업1팀">영업1팀</option>
                  <option value="영업2팀">영업2팀</option>
                  <option value="총무팀">총무팀</option>
                  <option value="개발팀">개발팀</option>
               </select>
            </div>
      </table>
      <br>
      <button type="button" @click="save">등록</button>
   </div>
>>>>>>> bafa1c8ec969e3ca11b829b006c894d36d6ee668

   <script>
var vueapp = new Vue({
<<<<<<< HEAD
	el: "#vueapp",
	data: {
		isIdChecked: false, // ID 중복 확인 상태
		employee: {
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
	methods: {
		checkId: function(){
			if(!this.employee.user_id.trim()){
				alert("ID를 입력해주세요.");
				return;
			}
			var params = {
				user_id: this.employee.user_id
			};
			console.log(params);
			axios.post("/system/team4/employee/checkId/", {params:params})
				.then(response => {
					if (response.data.user_id === this.employee.user_id) {
						alert("중복된 ID 입니다.");
					} else {
						alert("사용 가능한 ID 입니다.");
						this.isIdChecked = true; 
					}
				})
				.catch(error => {
					console.error("오류 발생: ", error);
					alert("오류 발생: " + error.message);
				});
		},
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
			if (!this.isIdChecked) {
				alert("ID중복확인을 클릭해주세요.");
				return;
			}
=======
   el: "#vueapp",
   data: {
      isIdChecked: false, // ID 중복 확인 상태
      employee: {
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
   methods: {
      checkId: function(){
         if(!this.employee.user_id.trim()){
            alert("ID를 입력해주세요.");
            return;
         }
         var params = {
            user_id: this.employee.user_id
         };
         console.log(params);
         axios.post("/system/team4/employee/checkId/", {params:params})
            .then(response => {
               if (response.data.user_id === this.employee.user_id) {
                  alert("중복된 ID 입니다.");
               } else {
                  alert("사용 가능한 ID 입니다.");
                  this.isIdChecked = true; 
               }
            })
            .catch(error => {
               console.error("오류 발생: ", error);
               alert("오류 발생: " + error.message);
            });
      },
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
         if (!this.isIdChecked) {
            alert("ID중복확인을 클릭해주세요.");
            return;
         }
>>>>>>> bafa1c8ec969e3ca11b829b006c894d36d6ee668

         // 저장 요청 보내기
         if (!confirm("저장하시겠습니까?")) return;

         var params = {
            user_id: this.employee.user_id,
            user_pw: this.employee.user_pw,
            name: this.employee.name,
            status_cd: this.employee.status_cd,
            jikgub_nm: this.employee.jikgub_nm,
            dept: this.employee.dept
         };

         console.log(params);

         axios.post("/system/team4/employee/save/", {params:params})
            .then(response => {
               if (response.data.status === "OK") {
                  alert("저장되었습니다.");
                  window.location.href = '/system/team4/employee/employeelist'; // 저장 후 정보창으로 이동
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