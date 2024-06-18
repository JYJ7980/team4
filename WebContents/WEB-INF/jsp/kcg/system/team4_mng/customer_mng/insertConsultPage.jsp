<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

.popup {
	display: none;
	position: fixed;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	border: 1px solid #ccc;
	background-color: #fff;
	z-index: 1000;
	width: 300px;
	height: 400px;
	overflow-y: auto;
}

.popup.active {
	display: block;
}

.popup-overlay {
	display: none;
	position: fixed;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 999;
}

.popup-overlay.active {
	display: block;
}

.popup-close {
	position: absolute;
	right: 10px;
	top: 10px;
	cursor: pointer;
}

.popup table {
	width: 100%;
	border-collapse: collapse;
}

.popup table th, .popup table td {
	border: 1px solid #ccc;
	padding: 5px;
	text-align: left;
}
</style>
<title>상담내역 추가 페이지</title>
</head>
<body>
	<div id="app">
		<h4>상담 내역을 추가히세요!</h4>
		<div class="input-form">
			<label for="customerName">고객 이름:</label> <input type="text"
				id="customerName" v-model="customerName">
			<button type="button" class="btn" @click="popupCust()">
				<i class="fa fa-search"></i> 검색
			</button>
		</div>
		<br>
		<div class="input-form">
			<label for="consultTitle">제목:</label> <input type="text"
				id="consultTitle" v-model="consultTitle">
		</div>
		<div class="input-form">
			<label for="consultContext">내용:</label> <input type="text"
				id="consultContext" v-model="consultContext">
		</div>
		<br>
		<button @click="addConsult">추가</button>
		

		<div class="popup-overlay" :class="{active: showPopup}" @click="closePopup"></div>
		<div class="popup" :class="{active: showPopup}">
			<div class="popup-close" @click="closePopup">X</div>
			<h4>고객 검색</h4>
			<table>
				<tr>
					<th>이름</th>
					<th>생년월일</th>
				</tr>
				<tr v-for="customer in customers" @click="selectCustomer(customer)">
					<td>{{ customer.customer_name }}</td>
					<td>{{ customer.customer_brdt }}</td>
				</tr>
			</table>
		</div>
	</div>
	<script>
		new Vue({
			el: '#app',
			data: {
				customers: [], // 고객 정보를 저장할 배열
				userId:'${userInfoVO.userId}',
				showPopup: false,
				customerConId:'',
				customerName: '',
				consultTitle: '',
				consultContext: ''
			},
			mounted() {
				// Vue 인스턴스가 마운트된 후에 실행되는 부분
				this.getAllCustomers();
			},
			methods: {
				getAllCustomers: function() {
					// AJAX 요청을 보내고 응답 데이터를 customers에 할당
					axios.get('/system/team4/getCustInfo')
						.then(response => {
							this.customers = response.data;
						})
						.catch(error => {
							console.error('Error:', error);
						});
				},
				popupCust: function() {
					this.showPopup = true;
				},
				closePopup: function() {
					this.showPopup = false;
				},
				selectCustomer: function(customer) {
					this.customerName = customer.customer_name;
					this.customerConId = customer.con_id;
					this.showPopup = false;
				},
				addConsult:function(){
					var params = {
						user_id : this.userId,
						consult_title : this.consultTitle,
						consult_context : this.consultContext,
						con_id : this.customerConId
							
					};
					   //서버에 POST 요청으로 새로운 상담내용 등록
		            axios.post('/system/team4/addConsult', { params: params })
		                .then(response => {
		                    if (response.data.status === 'OK') {
		                        alert('새로운 상담내역이 등록되었습니다.');
		                        window.location.href = '/system/team4/consultListPage';
		                    } else {
		                        alert('상담내역 등록에 실패했습니다.');
		                    }
		                })
		                .catch(error => {
		                    console.error('Error:', error);
		                    alert('상담내역 등록 중 오류가 발생했습니다.');
		                });
					
				}
			}
		});
	</script>
</body>
</html>
