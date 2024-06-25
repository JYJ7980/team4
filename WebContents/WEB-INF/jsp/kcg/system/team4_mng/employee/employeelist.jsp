<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<meta charset="UTF-8">
<title>직원 리스트</title>
<!-- Vue.js CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
<!-- axios CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style>
.customer-one {
	display: flex;
	flex-direction: column; /* 세로로 정렬 */
	gap: 10px; /* 요소들 사이의 간격 설정 */
	padding: 10px;
}

.input-form {
	margin-bottom: 10px;
}

.input-form label {
	display: block;
	font-weight: bold;
}

/* Flexbox 레이아웃 스타일 */
.customer-container {
	display: flex;
	justify-content: space-between;
	gap: 20px;
}

.customer-details {
	flex: 1;
	padding: 10px;
	border: 1px solid #ccc;
	padding: 10px;
}

.details-container {
	display: flex;
	gap: 10px;
}

.customer-info, .other-info {
	flex: 1; /* 각 섹션이 동일한 너비를 갖도록 설정 */
	padding: 5px;
	border: 1px solid #ccc;
}

.manager-info {
	flex: 1; /* 각 섹션이 동일한 너비를 갖도록 설정 */
	padding: 5px;
	border: 1px solid #ccc;
}

.sub-product, .design-product {
	flex: 1; /* 각 섹션이 동일한 너비를 갖도록 설정 */
	padding: 5px;
	width: 500px;
	height: 250px;
	overflow-y: auto;
	border: 1px solid #ccc;
}

.customer-list {
	width: 500px;
	height: 400px;
	overflow-y: auto;
	border: 1px solid #ccc;
	padding: 10px;
	height: 400px;
}

.customer-item {
	display: flex;
	align-items: center;
	padding: 5px 0;
	border-bottom: 1px solid #eee;
}

.customer-details>div {
	margin-right: 10px;
}

.table-header {
	display: flex;
	font-weight: bold;
	border-bottom: 2px solid #ccc;
	padding-bottom: 5px;
}

.table-row {
	display: flex;
	align-items: center;
	padding: 5px 0;
	border-bottom: 1px solid #eee;
}

.table-cell {
	flex: 1;
	padding: 5px;
}
</style>

</head>
<body class="page-body">
	<div class="page-container">
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />
		<div class="main-content">
			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
				flush="false" />
			<!-- 이름으로 리스트 만들기 -->
			<div id="vueapp" style="margin-left: 70px;">
				<div id="listPage">
					<h3>직원 리스트</h3>
					<div>
						<input type="text" v-model="name" class="inputtext"
							placeholder="이름을 입력하세요.">

						<button @click="employeeSearch()">이름검색</button>
						<button @click="employeeSearchAll">전체검색</button>

					</div>
					<div class="customer-container">
						<div class="customer-one">
							<div class="customer-list">
								<div class="table-header">
									<div class="table-cell">이름</div>
									<div class="table-cell">직급</div>
								</div>


								<div class="customer-item" v-for="employee in employees"
									:key="employee.user_id">

									<div class="table-cell" id="name" name="name"
										@click="employeeInfo(employee.user_id)">{{employee.name}}</div>
									<div class="table-cell" id="jikgub_nm" name="jikgub_nm"
										@click="employeeInfo(employee.jikgub_nm)">{{employee.jikgub_nm}}</div>

								</div>

							</div>
						</div>

						<div class="customer-details">
							<div class="details-container">
								<div class="customer-info">
									<h3>직원 정보</h3>
									<div class="input-form">
										<label>입사 날짜 : </label> <input type="text"
											v-model="emp_nfo.reg_dt" disabled>

									</div>


									<div class="input-form">
										<label>직원ID : </label> <input type="text"
											v-model="emp_nfo.user_id" readonly>

									</div>

									<div class="input-form">
										<label>이름 : </label> <input type="text" v-model="emp_nfo.name">
									</div>

									<div class="input-form">
										<label>비밀번호 수정</label>
										<button type="button" @click="input">비밀번호 수정</button>
										<div v-if="key">
											<label>비밀번호 : </label> <input type="text" v-model="userPw">
											<button type="submit" @click="updatePw" @click>저장</button>
										</div>
									</div>

									<div class="input-form">
										<label>재직정보 : </label> <select v-model="emp_nfo.status_cd">
											<option value="재직">재직</option>
											<option value="휴가">휴가</option>
											<option value="퇴사">퇴사</option>
										</select>
									</div>
									<div class="input-form">
										<label>직급 : </label> <select v-model="emp_nfo.jikgub_nm">
											<option value="수습" name="수습">수습</option>
											<option value="부장" name="부장">부장</option>
											<option value="차장" name="차장">차장</option>
											<option value="과장" name="과장">과장</option>
											<option value="대리" name="대리">대리</option>
											<option value="사원" name="사원">사원</option>
										</select>
									</div>

									<div class="input-form">
										<label>부서명 : </label> <select v-model="emp_nfo.dept">
											<option id="영업1팀">영업1팀</option>
											<option id="영업2팀">영업2팀</option>
											<option id="총무팀">총무팀</option>
											<option id="개발팀">개발팀</option>
										</select>
									</div>
									<button @click="update">수정</button>
									<button @click="deleteEmployee">삭제</button>
								</div>

							</div>

						</div>




						<div class="customer-details">
							<div class="details-container">
								<div class="customer-info">
									<h3>신규 직원</h3>
									<div class="input-form">
										<label>부여할 ID : </label> <input type="text" id="user_id"
											v-model="newEmployee.new_user_id" :disabled="isIdChecked">
										<input type="submit" id="new_user_id" value="ID중복확인"
											@click="checkId">
									</div>

									<div class="input-form">
										<label>이름 : </label> <input type="text" id="new_name"
											v-model="newEmployee.new_name">
									</div>

									<div class="input-form">
										<label>초기 비밀번호 : </label> <input type="text" id="new_user_pw"
											v-model="newEmployee.new_user_pw">
									</div>


									<div class="input-form">
										<label>직급 : </label> <select id="jikgub_nm"
											v-model="newEmployee.new_jikgub_nm">
											<option value="수습">수습</option>
											<option value="부장">부장</option>
											<option value="차장">차장</option>
											<option value="과장">과장</option>
											<option value="대리">대리</option>
											<option value="사원">사원</option>
										</select>
									</div>

									<div class="input-form">
										<label>부서명 : </label> <select id="dept"
											v-model="newEmployee.new_dept">
											<option value="">부서를 선택해주세요</option>
											<option value="영업1팀">영업1팀</option>
											<option value="영업2팀">영업2팀</option>
											<option value="총무팀">총무팀</option>
											<option value="개발팀">개발팀</option>
										</select>
									</div>
									<button type="button" @click="save">등록</button>
								</div>

							</div>

						</div>



					</div>
				</div>

			</div>
		</div>
	</div>

	<script>
    var vueapp = new Vue({
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
            isIdChecked: false, // ID 중복 확인 상태
    		newEmployee: {
    			new_user_id:"",
    			new_user_pw:"",
    			new_name:"",
    			new_auth_cd:"",
    			new_status_cd:"",
    			new_jikgub_nm:"",
    			new_dept:"",
    			new_email:""
    		}
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
            },
            checkId: function(){
    			if(!this.newEmployee.new_user_id.trim()){
    				alert("ID를 입력해주세요.");
    				return;
    			}
    			var params = {
    				user_id: this.newEmployee.new_user_id
    			};
    			console.log(params);
    			axios.post("/system/team4/employee/checkId/", {params:params})
    				.then(response => {
    					if (response.data.user_id === this.newEmployee.new_user_id) {
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
    			if (!this.newEmployee.new_user_id.trim()) {
    				alert("부여 할 아이디를 입력하세요.");
    				return;
    			}
    			if (!this.newEmployee.new_user_pw.trim()) {
    				alert("비밀번호를 입력하세요.");
    				return;
    			}
    			if (!this.newEmployee.new_name.trim()) {
    				alert("이름을 입력하세요.");
    				return;
    			}
    			if (!this.newEmployee.new_jikgub_nm.trim()) {
    				alert("직급을 선택 해주세요.");
    				return;
    			}
    			if (!this.newEmployee.new_dept.trim()) {
    				alert("부서를 선택하세요.");
    				return;
    			}
    			if (!this.isIdChecked) {
    				alert("ID중복확인을 클릭해주세요.");
    				return;
    			}

    			// 저장 요청 보내기
    			if (!confirm("저장하시겠습니까?")) return;

    			var params = {
    				user_id: this.newEmployee.new_user_id,
    				user_pw: this.newEmployee.new_user_pw,
    				name: this.newEmployee.new_name,
    				status_cd: this.newEmployee.new_status_cd,
    				jikgub_nm: this.newEmployee.new_jikgub_nm,
    				dept: this.newEmployee.new_dept
    			};

    			console.log(params);

    			axios.post("/system/team4/employee/save/", {params:params})
    				.then(response => {
    					if (response.data.status === "OK") {
    						alert("저장되었습니다.");
    						window.location.href = '/system/team4/employee/employeeList'; // 저장 후 정보창으로 이동
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
	</div>
	</div>
</body>
</html>
