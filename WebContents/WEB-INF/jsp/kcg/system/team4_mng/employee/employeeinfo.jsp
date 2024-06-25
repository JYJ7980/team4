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
	
	<script>
({
	el: "#vueapp",
	data: {
			 user_id:"";
			 employee:null
	},
	mounted: function() {
		// 필요한 경우 초기화 작업 수행
	},
	methods:{
		var params = {
				user_id : this.employee.user_id,
				name : this.employee.name,
				status_cd:this.employee.status_cd,
				jikgub_nm:this.employee.jikgub_nm,
				dept:this.employee.dept
		},
		employeeinfo : function(user_id){
			axios.get('/system/team4/employee/info')
				.then(response => {
					this.employee = repsonse.data;
				})
		},
		/* employeeinfo : function(){
			axios.get('/system/team4/employee/info')
				.then(response => {
					this.employee = response.data;
		})
		.catch(error => {
			console.error('Error:', error);
		});
		}, */
		update: function () {
			// 제목과 내용이 비어있는지 검사
			if (!this.employee.user_id.trim()) {
				alert("id를 입력하세요.");
				return;
			}
			if (!this.employee.name.trim()) {
				alert("이름을 입력하세요.");
				return;
			}
			if (!this.employee.status_cd.trim()) {
				alert("재직상태를 선택하세요.");
				return;
			}
			if (!this.employee.jikgub_nm.trim()) {
				alert("직급을 선택하세요.");
				return;
			}
			if (!this.employee.dept.trim()) {
				alert("담당 부서를 선택하세요.");
				return;
			}
			

			// 저장 요청 보내기
			if (!confirm("저장하시겠습니까?")) return;
			
			
			
			console.log(params);
			axios.post("/system/team4/employee/update", {params:params})
				.then(response => {
					if (response.data.status === "OK") {
						alert("저장되었습니다.");
						window.location.href = '/system/team4/employeeinfo/'; // 저장 후 redirect
					} else {
						alert("저장 실패: " + response.data.message);
					}
				})
				.catch(error => {
					alert("오류 발생: " + error);
				});
			axios.post("/system/team4/employee/delete", {params:params})
				.then(response => {
					if (response.data.status === "OK"){
						alert("삭제되었습니다.");
						window.lacation.href = '/system/team4/employeeinfo';
					} 
			})
		}
	}
});
	</script>
</body>
</html>