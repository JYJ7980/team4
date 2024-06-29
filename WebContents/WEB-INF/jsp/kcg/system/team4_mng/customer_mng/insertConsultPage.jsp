<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담내역 추가</title>
<!-- Vue.js CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
<!-- axios CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<!-- Imported styles on this page -->
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/datatables.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2-bootstrap.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2.css">

<style>
#app {
	margin-left: auto;
	margin-right: auto;
	width: 50%; /* Adjust width as per your design */
	/* Optionally, you can add padding, background color, etc. */
	padding: 20px;
	background-color: #f0f0f0;
	border: 1px solid #ccc;
}

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
	width: 400px;
	height: 450px;
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

.popup-search-container {
	display: flex; /* Flexbox 사용 */
	align-items: center; /* 요소들을 세로 중앙 정렬 */
	gap: 10px; /* 요소들 사이 간격 조정 */
}
</style>
<title>상담내역 추가 페이지</title>

</head>
<body class="page-body">

	<div class="page-container">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/team4/sidebar-menu.jsp"
			flush="false" />

		<div class="main-content">
			<jsp:include page="/WEB-INF/jsp/kcg/_include/team4/header.jsp"
				flush="false" />
			<ol class="breadcrumb bc-3">
				<li><a href="#none" onclick="cf_movePage('/system/team4/main')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>상담내역 추가</strong></li>
			</ol>

			<h2>고객관리 > 상담내역 추가</h2>
			<br><br>

			<div id="app">

			
				<div class="input-form">
				<span>**상담내역을 추가하세요**</span>
				<br><br>
					<label for="customerName">고객 이름:</label> <input type="search"
						id="customerName" v-model="customerName" placeholder="고객을 선택하세요">
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
					<label for="consultContext">내용:</label>
					<textArea rows="4" cols="50" id="consultContext"
						v-model="consultContext"></textArea>
				</div>
				<br>
				<button @click="addConsult">추가</button>
				<button @click="resetForm">취소</button>
				<button onclick="cf_movePage('/system/team4/consultListPage')">상담내역 목록으로</button>

				<div class="popup-overlay" :class="{active: showPopup}"
					@click="closePopup"></div>
				<div class="popup" :class="{active: showPopup}">
					<div class="popup-close" @click="closePopup">X</div>
					<br> <br>
					<div class="popup-search-container">
						<label for="searchInput">고객 이름:</label> <input type="text"
							id="searchInput" v-model="searchKeyword">
						<button @click="searchCustomers">
							<i class="fa fa-search"></i>
						</button>
						<button @click="searchCustomersReset">다시</button>
						
					</div>


					<br>

					<table>
						<tr>
							<th>이름</th>
							<th>생년월일</th>
						</tr>
						<tr v-for="customer in customers"
							@click="selectCustomer(customer)">
							<td>{{ customer.customer_name }}</td>
							<td>{{ customer.customer_brdt }}</td>
						</tr>
					</table>
				</div>
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
				consultContext: '',
				searchKeyword: '' // 팝업에 있는 고객이름 검색 keyword
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
				 searchCustomers: function() {
			            if (this.searchKeyword.trim() === '') {
			                alert('검색어를 입력하세요.');
			                return;
			            }
			            axios.get('/system/team4/getCustInfo')
			                .then(response => {
			                	this.customers = response.data;
			                    this.customers = this.customers.filter(customer => 
			                        customer.customer_name.includes(this.searchKeyword)
			                        
			                    );
			                    this.searchKeyword = '';
			                    
			                })
			                .catch(error => {
			                    console.error('Error:', error);
			                });
			        },
			        searchCustomersReset:function(){
			        	axios.get('/system/team4/getCustInfo')
						.then(response => {
							this.customers = response.data;
							 this.searchKeyword = '';
						})
						.catch(error => {
							console.error('Error:', error);
						});
			        	
			        },
				popupCust: function() {
					axios.get('/system/team4/getCustInfo')
					.then(response => {
						this.customers = response.data;
					})
					.catch(error => {
						console.error('Error:', error);
					});
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
					   if (
						        this.consultTitle.trim() === '' ||
						        this.consultContext.trim() === '' ||
						        this.customerName.trim() === ''
						    ) {
						        alert('모든 필수 입력 필드를 입력해주세요.');
						        return; 
						    }
		        
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
					
				},
				resetForm: function() {
					this.customerName = '';
					this.consultTitle = '';
					this.consultContext = '';
				}
			}
		});
	</script>
	</div>
</body>
</html>