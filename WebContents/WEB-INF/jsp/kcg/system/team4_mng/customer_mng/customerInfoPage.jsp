<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer InfoPage</title>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<!-- Vue.js CDN 추가 -->
<!-- <script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script> -->
<!-- axios CDN 추가 -->
<!-- <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script> -->
<style>
/* 테이블 숨기기 */
#customerTable {
	display: none;
}
</style>
</head>
<body>
	<div id="app">
		<h4>고객 정보 관리</h4>
		<br>
		<div>
			<!-- 전체 조회 버튼 -->
			<button @click="getAllCustomers">전체 조회</button>
		</div>
		<div id="customerTable">
			<!-- 고객 정보 테이블 -->
			<h2>전체 고객 정보</h2>
			<table border='1'>
				<tr>
					<th>Name</th>
					<th>Job</th>
				</tr>
				<tr v-for="customer in customers">
					<td>{{ customer.customer_name }}</td>
					<td>{{ customer.customer_job }}</td>
				</tr>
			</table>
		</div>
	</div>

	<script>
    new Vue({
        el: '#app',
        data: {
            customers: [] // 고객 정보를 저장할 배열
        },
        methods: {
            getAllCustomers: function() {
                // AJAX 요청을 보내고 응답 데이터를 customers에 할당
                axios.get('/system/team4/getCustInfo')
                    .then(response => {
                        this.customers = response.data;
                        // 테이블을 보이도록 변경
                        document.getElementById('customerTable').style.display = 'block';
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
