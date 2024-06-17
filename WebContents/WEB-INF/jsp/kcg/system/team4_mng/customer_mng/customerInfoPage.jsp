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
					<label for="customerName">고객 이름</label> <input type="text"
						id="customerName" v-model="selectedCustomer.customer_name">
				</div>
				<div class="input-form">
					<label for="customerIdNumber">고객 주민번호</label> <input type="text"
						id="customerIdNumber"
						v-model="selectedCustomer.customer_id_number" readonly>
				</div>
				<div class="input-form">
					<label for="customerLevel">고객 등급</label> <input type="text"
						id="customerLevel" v-model="selectedCustomer.customer_level">
				</div>
				<div class="input-form">
					<label for="customerPhone">고객 전화번호</label> <input type="text"
						id="customerPhone" v-model="selectedCustomer.customer_phone">
				</div>
				<div class="input-form">
					<label for="customerSubTel">고객 비상연락망</label> <input type="text"
						id="customerSubTel" v-model="selectedCustomer.customer_sub_tel">
				</div>
				<div class="input-form">
					<label for="customerEmail">고객 이메일</label> <input type="text"
						id="customerEmail" v-model="selectedCustomer.customer_email">
				</div>
				<div class="input-form">
					<label for="customerJob">고객 직업</label> <input type="text"
						id="customerJob" v-model="selectedCustomer.customer_job">
				</div>
				<div class="input-form">
					<label for="customerAddr">고객 주소</label> <input type="text"
						id="customerAddr" v-model="selectedCustomer.customer_addr">
				</div>
				<br>
				<button @click="deleteCustomer">삭제</button>
				<button @click="updateCustomer">수정</button>
				<br> <br>
				<h2>관리자 정보</h2>
				<div class="input-form">
					<label for="userName">관리자 이름</label> <input type="text"
						id="userName" value="${userInfoVO.name}" disabled>
				</div>
				<div class="input-form">
					<label for="userDept">관리자 부서</label> <input type="text"
						id="userDept" value="${userInfoVO.dept}" disabled>
				</div>
				<div class="input-form">
					<label for="userjikgub">관리자 직급</label> <input type="text"
						id="userjikgub" value="${userInfoVO.jikgubNm}" disabled>
				</div>
				<!-- 필요한 입력 폼 추가 -->
			</div>
			<div class="customer-details" v-else>
				<!-- 선택된 고객이 없는 경우의 메시지 -->
				<p>고객을 선택해주세요.</p>
				<h2>고객 정보</h2>
				<div class="input-form">
					<label for="customerName">고객 이름</label> <input type="text"
						id="customerName" v-model="customerName">
				</div>
				<div class="input-form">
					<label for="customerIdNumber">고객 주민번호</label> <input type="text"
						id="customerIdNumber" v-model="customerIdNumber">
				</div>
				<div class="input-form">
					<label for="customerLevel">고객 등급</label> <input type="text"
						id="customerLevel" v-model="customerLevel">
				</div>
				<div class="input-form">
					<label for="customerPhone">고객 전화번호</label> <input type="text"
						id="customerPhone" v-model="customerPhone">
				</div>
				<div class="input-form">
					<label for="customerSubTel">고객 비상연락망</label> <input type="text"
						id="customerSubTel" v-model="customerSubTel">
				</div>
				<div class="input-form">
					<label for="customerEmail">고객 이메일</label> <input type="text"
						id="customerEmail" v-model="customerEmail">
				</div>
				<div class="input-form">
					<label for="customerJob">고객 직업</label> <input type="text"
						id="customerJob" v-model="customerJob">
				</div>
				<div class="input-form">
					<label for="customerAddr">고객 주소</label> <input type="text"
						id="customerAddr" v-model="customerAddr">
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
        customerName: '', // 고객 이름을 저장할 변수
        customerIdNumber:'',
        customerLevel:'',
        customerPhone: '',
        customerSubTel: '',
        customerEmail:'', // 고객 이메일을 저장할 변수
        customerJob: '', 
        customerAddr: '',
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
        },
        deleteCustomer: function() {
            if (this.selectedCustomer !== null) {
                // 확인 메시지 추가
                if (confirm('정말로 고객을 삭제하시겠습니까?')) {
                    var params = {
                        customer_id: this.selectedCustomer.customer_id
                    };
                    console.log(params);
                    axios.post('/system/team4/deleteCust', { params: params })
                        .then(response => {
                            if (response.data.status === 'OK') {
                                alert('고객이 삭제되었습니다.');
                                this.getAllCustomers(); // 고객 목록을 다시 불러옵니다.
                                this.selectedCustomer = null; // 선택된 고객 초기화
                            } else {
                                alert('고객 삭제에 실패했습니다.');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
                }
            } else {
                alert('삭제할 고객을 선택해주세요.');
            }
        },
        updateCustomer: function() {
            // 선택된 고객이 존재하는지 확인
            if (this.selectedCustomer !== null) {
                // 서버에 보낼 고객 정보 준비
                var params = {
                    customer_id: this.selectedCustomer.customer_id,
                    customer_name: this.selectedCustomer.customer_name,
                    customer_id_number: this.selectedCustomer.customer_id_number,
                    customer_level: this.selectedCustomer.customer_level,
                    customer_phone: this.selectedCustomer.customer_phone,
                    customer_sub_tel: this.selectedCustomer.customer_sub_tel,
                    customer_email: this.selectedCustomer.customer_email,
                    customer_job: this.selectedCustomer.customer_job,
                    customer_addr: this.selectedCustomer.customer_addr
                };

                // 서버에 PUT 또는 POST 요청 보내기 (수정에 따라 다름)
                axios.put('/system/team4/updateCust', { params: params })
                    .then(response => {
                        if (response.data.status === 'OK') {
                            alert('고객 정보가 수정되었습니다.');
                            // 수정된 고객 정보를 다시 불러오기
                            this.getAllCustomers();
                        } else {
                            alert('고객 정보 수정에 실패했습니다.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('고객 정보 수정 중 오류가 발생했습니다.');
                    });
            } else {
                alert('수정할 고객을 선택해주세요.');
            }
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
