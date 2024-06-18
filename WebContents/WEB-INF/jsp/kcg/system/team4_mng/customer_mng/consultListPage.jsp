<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer InfoPage</title>
<!-- Vue.js CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
<!-- axios CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<div id="app">
		<h4>고객상담내역 관리</h4>
		<br>
		<div></div>
		<div>
			<!-- 고객 정보 테이블 -->
			<h2>
				<span style="font-size: 18px; font-weight: bold; color: black;">${userInfoVO.name}</span>&nbsp;님
				상담내역
			</h2>
			<table border='1'>
				<tr>
					<th>제목</th>
					<th>내용</th>
					<th>고객명</th>
					<th>고객 담당자명</th>
				
				</tr>
				<tr v-for="consult in consults">
					<td>{{ consult.consult_title }}</td>
					<td>{{ consult.consult_context }}</td>
					<td>{{ consult.customer_name }}</td>
					<td>{{ consult.representative_name }}</td>
				</tr>
			</table>
		</div>
		<br>
		<button><a href="/system/team4/insertConsult">상담내역 추가하기</a></button>
	</div>
<script>
new Vue({
    el: '#app',
    data: {
    	consults: [] // 고객 정보를 저장할 배열
       ,userId: '${userInfoVO.userId}', // 현재 사용자의 userId를 저장
    },
    mounted() {
        // Vue 인스턴스가 마운트된 후에 실행되는 부분
        this.getAllConsults();
    },
    methods: {
        getAllConsults: function() {
        	 var params = {user_id: this.userId};
            // AJAX 요청을 보내고 응답 데이터를 customers에 할당
            axios.get('/system/team4/getAllconsult',{ params: params })
                .then(response => {
                    this.consults = response.data;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    }
});
</script>
</body>
</html>