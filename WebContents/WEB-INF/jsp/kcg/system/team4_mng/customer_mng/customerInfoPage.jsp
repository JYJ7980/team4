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
<style>
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
}

.customer-details {
	flex: 1;
	padding: 10px;
	border: 1px solid #ccc;
}

.customer-table {
	flex: 1;
}
</style>
</head>
<body>
	<div id="app">
		<span style="font-size: 18px; font-weight: bold; color: black;">${userInfoVO.userId}</span>&nbsp;님
		화면
		<h4>고객 정보 관리</h4>
		<br>
		<div>
			<!-- 전체 조회 버튼 -->
			<button @click="getAllCustomers">전체 조회</button>
		</div>
		<div id="customerTable" class="customer-container">
			<div class="customer-table">
				<!-- 고객 정보 테이블 -->
				<h2 v-show="filteredCustomers.length > 0">전체 고객 정보</h2>
				<table border='1' v-show="filteredCustomers.length > 0">
					<tr>
						<th>Select</th>
						<th>Name</th>
						<th>Job</th>
					</tr>
					<tr v-for="customer in filteredCustomers"
						:key="customer.customer_id">
						<td><input type="radio" name="selectedCustomer"
							v-model="selectedCustomer" :value="customer"></td>
						<td>{{ customer.customer_name }}</td>
						<td>{{ customer.customer_job }}</td>
					</tr>
				</table>
			</div>
			<!-- 선택된 고객의 상세 정보 입력 폼 -->
			 <div class="customer-details" v-if="selectedCustomer !== null">
				<h2>고객 정보</h2>
				<div class="input-form">
					<label for="customerId">고객 ID</label> <input type="text"
						id="customerId" v-model="selectedCustomer.customer_id" readonly>
				</div>
				<div class="input-form">
					<label for="customerName">고객 이름</label> <input type="text"
						id="customerName" v-model="selectedCustomer.customer_name"
						readonly>
				</div>
				<div class="input-form">
					<label for="customerPhone">고객 전화번호</label> <input type="text"
						id="customerPhone" v-model="selectedCustomer.customer_phone">
				</div>
				<div class="input-form">
					<label for="customerEmail">고객 이메일</label> <input type="text"
						id="customerEmail" v-model="selectedCustomer.customer_email">
				</div>
				<br> <br>
				<h2>관리자 정보</h2>
				<div class="input-form">
					<label for="userName">관리자 이름</label> <input type="text"
						id="userName" value="${userInfoVO.name}">
				</div>
				<div class="input-form">
					<label for="userDept">관리자 부서</label> <input type="text"
						id="userDept" value="${userInfoVO.dept}">
				</div>
				<div class="input-form">
					<label for="userjikgub">관리자 직급</label> <input type="text"
						id="userjikgub" value="${userInfoVO.jikgubNm}">
				</div>
				<!-- 필요한 입력 폼 추가 -->
			</div>
			 <div class="customer-details" v-else>
				<!-- 선택된 고객이 없는 경우의 메시지 -->
				<p>고객을 선택해주세요.</p>
				<h2>고객 정보</h2>
				<div class="input-form">
					<label for="customerId">고객 아이디</label> <input type="text"
						id="customerId" v-model="customerName">
				</div>
				<div class="input-form">
					<label for="customerName">고객 이름</label> <input type="text"
						id="customerName" v-model="customerName">
				</div>
				<div class="input-form">
					<label for="customerPhone">고객 전화번호</label> <input type="text"
						id="customerPhone" v-model="customerPhone">
				</div>
				<div class="input-form">
					<label for="customerEmail">이메일</label> <input type="text"
						id="customerEmail" v-model="customerEmail">
				</div>
				<br> <br>
				<h2>관리자 정보</h2>
				<div class="input-form">
					<label for="userName">관리자 이름</label> <input type="text"
						id="userName" value="">
				</div>
				<div class="input-form">
					<label for="userDept">관리자 부서</label> <input type="text"
						id="userDept" value="">
				</div>
				<div class="input-form">
					<label for="userjikgub">관리자 직급</label> <input type="text"
						id="userjikgub" value="">
				</div>
			</div>
		</div>
	</div>

	<script>
new Vue({
    el: '#app',
    data: {
        customers: [], // 고객 정보를 저장할 배열
        filteredCustomers: [], // 필터된 고객 정보를 저장할 배열
        selectedCustomer: null, // 선택된 고객 정보
        userId: '${userInfoVO.userId}', // 현재 사용자의 userId를 저장
        customerID: '',
        customerName: '', // 고객 이름을 저장할 변수
        customerPhone: '',
        customerEmail: '' // 고객 이메일을 저장할 변수
    },
    methods: {
        getAllCustomers: function() {
            // AJAX 요청을 보내고 응답 데이터를 customers에 할당
            axios.get('/system/team4/getCustInfo')
                .then(response => {
                    this.customers = response.data;
                    this.filterCustomers(); // 고객 필터링 함수 호출
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        },
        filterCustomers: function() {
            // userInfoVO.userId와 customer.user_id가 같은 고객만 필터링
            this.filteredCustomers = this.customers.filter(customer => customer.user_id === this.userId);
        }
    },
    mounted: function() {
        // 페이지 로딩 시 초기화
        this.selectedCustomer = null;
    }
});
</script>
</body>
</html>