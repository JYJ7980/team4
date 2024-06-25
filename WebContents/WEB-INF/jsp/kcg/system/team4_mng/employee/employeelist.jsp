<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 리스트</title>
<!-- Vue.js CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
<!-- axios CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<!-- 이름으로 리스트 만들기 -->
	<div id="vueapp">

		<h3>직원 리스트</h3>
		<div>
			<input type="text" v-model="name" placeholder="이름을 입력하세요." />
			<button @click="employeeSearch()">이름검색</button>
			<button @click="employeeSearchAll">전체검색</button>
		</div>
		<table border="1">
			<thead>
				<tr>
					<th>이름</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="employee in employees" :key="employee.user_id">
					<td id="name" name="name" @click="employeeInfo(employee.user_id)">{{employee.name}}</td>
				</tr>
			</tbody>
		</table>
		<div>
			<h3>직원 정보</h3>
			<table>
				<tr>
					<td>입사 날자 :</td>
					<td><input type="text" v-model="emp_nfo.reg_dt" disabled></td>
				</tr>
				<tr>
					<td>직원ID:</td>
					<td><input type="text" v-model="emp_nfo.user_id" readonly></td>
				</tr>
				<tr>
					<td>이름:</td>
					<td><input type="text" v-model="emp_nfo.name"></td>
				</tr>
				<tr>
					<td>비밀번호 수정</td>
					<td><button type="button" @click="input">비밀번호 수정</button></td>
				</tr>
				<tr v-if="key">
					<td>비밀번호:</td>
					<td><input type="text" v-model="userPw">
						<button type="submit" @click="updatePw" @click>저장</button></td>
				</tr>
				<tr>
					<td>재직정보:</td>
					<td><select v-model="emp_nfo.status_cd">
							<option value="재직">재직</option>
							<option value="휴가">휴가</option>
							<option value="퇴사">퇴사</option>
					</select></td>
				</tr>
				<tr>
					<td>직급:</td>
					<td><select v-model="emp_nfo.jikgub_nm">
							<option value="수습" name="수습">수습</option>
							<option value="부장" name="부장">부장</option>
							<option value="차장" name="차장">차장</option>
							<option value="과장" name="과장">과장</option>
							<option value="대리" name="대리">대리</option>
							<option value="사원" name="사원">사원</option>
					</select></td>
				</tr>
				<tr>
					<td>부서명:</td>
					<td><select v-model="emp_nfo.dept">
							<option id="영업1팀">영업1팀</option>
							<option id="영업2팀">영업2팀</option>
							<option id="총무팀">총무팀</option>
							<option id="개발팀">개발팀</option>
					</select></td>
				</tr>
			</table>
			<button @click="update">수정</button>
			<button @click="deleteEmployee">삭제</button>
		</div>
	</div>

	<script>
    new Vue({
        el: "#vueapp",
        data: {
            employees: [], // 직원 목록을 저장하는 배열
            name: "", // 검색어를 저장하는 변수 추가
            user_id: "",
            key:false,
            userPw:"",  //새 비밀번호 저장 변수
            emp_nfo: { // 선택된 직원 정보를 저장하는 객체
                user_id: "",
                name: "",
                user_pw:"",
                status_cd: "",
                jikgub_nm: "",
                dept: "",
                reg_dt :""
            } ,
        },
        mounted: function() {
            this.loadEmployees();
        },
        methods: {
        	input :function(){
        		this.key = !this.key;
        	},
            loadEmployees: function() {
                axios.get("/system/team4/employee/list")
                    .then(response => {
                        this.employees = response.data;
                    })
                    .catch(error => {
                        console.error("데이터 로드 오류:", error);
                    });
            },
            employeeInfo: function(user_id) {
                axios.get("/system/team4/employee/info", { params: { user_id: user_id } })
                    .then(response => {
                        this.emp_nfo = response.data;
                        console.log(this.emp_nfo.user_id);
                    })
                    .catch(error => {
                        console.error("데이터 로드 오류:", error);
                    });
                
            },
            updatePw: function() {
                var params = {
                    user_id: this.emp_nfo.user_id,
                    user_pw: this.userPw
                };
                console.log(params);
                
                axios.post("/system/team4/employee/updatePw", {params:params})
                    .then(response => {
                        if (response.data.status === "OK") {
                            alert("저장 되었습니다.");
                            this.key = false;
                            this.employeeInfo(this.emp_nfo.user_id);
                        } else {
                            alert("저장 실패: " + response.data.message);
                        }
                    })
                    .catch(error => {
                        console.error("데이터 로드 오류:", error);
                        alert("오류 발생: " + error.message);
                    });
            },
            employeeSearch :function(){
            	var params = {
            			name : this.name,
            	};
            	console.log(params);
            	axios.get("/system/team4/employee/search", { params: params })
                .then(response => {
                	this.employees = response.data;
                })
                .catch(error => {
                    console.error("데이터 로드 오류:", error);
                });
            },
            employeeSearchAll : function(){
            	axios.get("/system/team4/employee/searchAll")
                .then(response => {
                    this.employees = response.data;
                })
                .catch(error => {
                    console.error("데이터 로드 오류:", error);
                });
            },
            update: function() {
                var params = {
                		user_id : this.emp_nfo.user_id,
                    	name : this.emp_nfo.name,
                    	status_cd: this.emp_nfo.status_cd,
                    	jikgub_nm : this.emp_nfo.jikgub_nm,
                    	dept : this.emp_nfo.dept
                }
                axios.post('/system/team4/employee/update', {params:params})
                    .then(response => {
                        if (response.data.status === 'OK') {
                            alert("수정되었습니다.");
                            this.loadEmployees();
                            window.location.href = "/system/team4/employee/employeelist" ;
                        } else {
                            alert("수정 실패: " + response.data.message);
                        }
                    })
                    .catch(error => {
                        alert("오류 발생: " + error);
                    });
            },
            deleteEmployee: function() {
        	   var params = {
        		   user_id: this.emp_nfo.user_id
        	   }
                axios.post('/system/team4/employee/delete', { params, params })
                    .then(response => {
                        if (response.data.status === 'OK') {
                            alert("삭제되었습니다.");
                            this.loadEmployees(); // 직원 목록 재로드
                        } else {
                            alert("삭제 실패: " + response.data.message);
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
