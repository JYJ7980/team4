<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<meta charset="UTF-8">
<title>Customer InfoPage</title>
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

.popup {
	display: none;
	position: fixed;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	border: 1px solid #ccc;
	background-color: #fff;
	z-index: 1000;
	width: 500px;
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

.modal {
	display: block;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	overflow: auto;
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 450px;
	height: 200px;
}

.modal-addconsult {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 400px;
	height: 450px;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
</style>


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
				<li class="active"><strong>고객정보 관리</strong></li>
			</ol>
			<div id="app" style="margin-left: 70px;">

				<h2>고객관리 > 고객정보 관리</h2>
				<br /> <span
					style="font-size: 18px; font-weight: bold; color: black;">${userInfoVO.dept}</span>&nbsp;
				고객관리 화면 <br> <a href="/system/team4/main">메인으로 돌아가기</a> <br>
	
					<br> <input id="keywordInput" type="text" name="keyword"
						v-model="searchKeyword" class="inputtext"
						placeholder="고객 이름을 입력하세요">
					<button @click="searchCustomers">이름 검색</button>
					<button @click="getAllCustomers">전체 조회</button>
					<label for="managerSelect">담당자별 조회:</label> <select
						id="managerSelect" v-model="selectedManager"
						@change="filterByManager">
						<option value="">전체</option>
						<option v-for="manager in filteredManager" :key="manager.user_id"
							:value="manager.name">{{ manager.name }}({{
							manager.jikgub_nm }})</option>

					</select>


				<br>
				<div id="customerTable" class="customer-container">
					<div class="customer-one">
						<div class="customer-list">

							<h3 v-show="filteredCustomers.length >= 0">전체 고객 정보</h3>
							<div v-show="filteredCustomers.length == 0">
								<p>담당고객이 없습니다</p>
							</div>
							<div v-show="filteredCustomers.length > 0">
								<div class="table-header">
									<div class="table-cell">선택</div>
									<div class="table-cell">이름</div>
									<div class="table-cell">생년월일</div>
									<div class="table-cell">담당자</div>
								</div>
								<div class="customer-item" v-for="customer in filteredCustomers"
									:key="customer.customer_id">
									<div class="table-cell">
										<input type="radio" name="selectedCustomer"
											v-model="selectedCustomer" :value="customer">
									</div>
									<div class="table-cell">{{ customer.customer_name }}</div>
									<div class="table-cell">{{ customer.customer_brdt }}</div>
									<div class="table-cell">{{ customer.name }}({{
										customer.jikgub_nm }})</div>
								</div>
							</div>
						</div>
						<div class="customer-list" v-if="selectedCustomer !== null">
							<h3>상담내역</h3>
							<div v-if="consults.length > 0">
								<div class="table-header">
									<div class="table-cell">상담일</div>
									<div class="table-cell">상담제목</div>
									<div class="table-cell">상담 담당자</div>
								</div>

								<!-- Iterate over consults array to display each consultation item -->
								<div class="customer-item" v-for="consult in consults"
									@click="showConsultDetails(consult)">
									<div class="table-cell">{{ consult.con_date }}</div>
									<div class="table-cell">{{ consult.consult_title }}</div>
									<div class="table-cell">{{ consult.name }} ({{
										consult.dept }} {{ consult.jikgub_nm }})</div>
								</div>
							</div>
							<div v-else>
								<p>상담 내역이 없습니다.</p>
							</div>
							<!-- 							상세내역 모달 -->
							<div class="modal" v-if="selectedConsult !== null">
								<div class="modal-content">
									<span class="close" @click="closeModal">&times;</span>
									<p>{{ selectedConsult.consult_context }}</p>

								</div>
							</div>
							<!-- 							상담추가 모달 -->
							<div class="modal" v-if="showAddConsultModal">
								<div class="modal-addconsult">
									<span class="close" @click="closeAddConsultModal">&times;</span>
									<div class="input-form">
										<label for="consultTitle">제목:</label> <input type="text"
											id="consultTitle" v-model="consultTitle">

									</div>
									<div class="input-form">
										<label for="consultContext">내용:</label>
										<textArea rows="4" cols="35" id="consultContext"
											v-model="consultContext"></textArea>
									</div>

									<br>
									<button @click="addConsult">추가</button>
									<button @click="resetConsultForm">취소</button>
								</div>
							</div>

						</div>
					</div>
					<!-- 선택된 고객의 상세 정보 입력 폼 -->
					<div class="customer-details" v-if="selectedCustomer !== null">
						<div class="details-container">
							<div class="customer-info">
								<h3>고객 정보</h3>
								<div class="input-form">
									<label for="customerSubDate">등록일</label> <input type="text"
										id="customerSubDate"
										v-model="selectedCustomer.customer_sub_date" readonly>
								</div>
								<div class="input-form">
									<label for="customerName">고객 이름</label> <input type="text"
										id="customerName" v-model="selectedCustomer.customer_name">
									<button type="button" class="btn"
										@click="openAddConsultModal()">상담추가</button>
								</div>
								<div class="input-form">
									<label for="customerIdNumber">고객 주민번호</label> <input
										type="text" id="customerIdNumber"
										:value="maskIdNumber(selectedCustomer.customer_id_number)"
										readonly>
									<button @click="toggleMasking">확인</button>
								</div>
								<div class="input-form">
									<label for="customerLevel">고객 등급</label> <select
										id="customerLevel" v-model="selectedCustomer.customer_level">
										<option value="1">일반</option>
										<option value="2">우수</option>
										<option value="3">VIP</option>
										<option value="4">VVIP</option>
										<option value="5">플래티넘</option>
									</select>

								</div>
								<div class="input-form">
									<label for="customerPhone">고객 전화번호</label> <input type="text"
										id="customerPhone" v-model="selectedCustomer.customer_phone">
								</div>
								<div class="input-form">
									<label for="customerSubTel">고객 비상연락망</label> <input type="text"
										id="customerSubTel"
										v-model="selectedCustomer.customer_sub_tel">
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
								<button @click="resetForm">신규</button>
							</div>
							<div class="other-info">
								<div class="manager-info">
									<h3>관리자 정보</h3>
									<div class="input-form">
										<label for="userName">관리자 이름</label> <input type="text"
											id="userName" v-model="selectedCustomer.name" disabled>
										<button type="button" class="btn" @click="popupUser()">
											<i class="fa fa-search"></i> 검색
										</button>
									</div>
									<div class="input-form">
										<label for="userDept">관리자 부서</label> <input type="text"
											id="userDept" v-model="selectedCustomer.dept" disabled>
									</div>
									<div class="input-form">
										<label for="userjikgub">관리자 직급</label> <input type="text"
											id="userJikgub" v-model="selectedCustomer.jikgub_nm" disabled>
										<button @click="updateUser">수정</button>
									</div>
								</div>
								<br>
								<div class="sub-product">

									<h3>가입상품 정보</h3>
									<div v-if="subProducts.length > 0">
										<div class="table-header">
											<div class="table-cell">가입일</div>
											<div class="table-cell">가입 상품</div>
										</div>

										<!-- Iterate over consults array to display each consultation item -->
										<div class="customer-item" v-for="subProduct in subProducts">
											<div class="table-cell">{{ subProduct.sub_start_date }}</div>
											<div class="table-cell" @click="moveProductInfoForm(subProduct.sub_id, subProduct.product_id, subProduct.customer_id)">{{ subProduct.product_name }}</div>
										</div>
									</div>
									<div v-else>
										<p>가입상품 내역이 없습니다.</p>
									</div>

								</div>
								<br>
								<div class="design-product">
									<h3>설계상품 정보</h3>
									<div v-if="designProducts.length > 0">
										<div class="table-header">
											<div class="table-cell">설계일</div>
											<div class="table-cell">설계 상품</div>
										</div>

										<!-- Iterate over consults array to display each consultation item -->
										<div class="customer-item"
											v-for="designProduct in designProducts">
											<div class="table-cell">{{ designProduct.design_date }}</div>
											<div class="table-cell" @click="moveDesignInfoForm(designProduct.design_id, designProduct.product_id, designProduct.customer_id)">{{ designProduct.product_name}}</div>
										</div>
									</div>
									<div v-else>
										<p>설계상품 내역이 없습니다.</p>
									</div>

								</div>
							</div>
						</div>
					</div>
					<div class="customer-details" v-else>
						<div class="details-container">
							<div class="customer-info">
								<!-- 선택된 고객이 없는 경우의 메시지 -->
								<p>고객을 신규 등록해 주세요.</p>
								<p>**표시는 필수 입력값 입니다. [최조 등록 시 고객 등급은 일반 등급으로 등록]</p>
								<h3>고객 정보</h3>
								<div class="input-form">
									<label for="customerName">**고객 이름</label> <input type="text"
										id="customerName" v-model="customerName" required>
								</div>
								<div class="input-form">
									<label for="customerIdNumber">**고객 주민번호</label> <input
										type="text" id="customerIdNumber" v-model="customerIdNumber"
										required maxlength="14"> <small>예시:
										YYMMDD-1234567</small>
								</div>
								<div class="input-form">
									<label for="customerPhone">**고객 전화번호</label> <input type="text"
										id="customerPhone" v-model="customerPhone" required>
								</div>
								<div class="input-form">
									<label for="customerSubTel">**고객 비상연락망</label> <input
										type="text" id="customerSubTel" v-model="customerSubTel">
								</div>
								<div class="input-form">
									<label for="customerEmail">**고객 이메일</label> <input type="email"
										id="customerEmail" v-model="customerEmail" required>
								</div>
								<div class="input-form">
									<label for="customerJob">고객 직업</label> <input type="text"
										id="customerJob" v-model="customerJob">
								</div>
								<div class="input-form">
									<label for="customerAddr">고객 주소</label> <input type="text"
										id="customerAddr" v-model="customerAddr">
								</div>
								<button @click="addCustomer">등록</button>
								<button @click="resetForm">초기화</button>
							</div>
							<div class="manager-info">
								<h3>관리자 정보</h3>
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
										id="userJikgub" value="${userInfoVO.jikgubNm}" disabled>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="popup-overlay" :class="{active: showPopup}"
					@click="closePopup"></div>
				<div class="popup" :class="{active: showPopup}">
					<div class="popup-close" @click="closePopup">X</div>
					<br> <br>
					<div class="popup-search-container"></div>
					<label for="searchInput">관리자 이름:</label> <input type="text"
						id="searchInput" v-model="searchManagerName">
					<button @click="searchManager">
						<i class="fa fa-search"></i>
					</button>
					<button @click="searchManagerReset">다시</button>
					<br>

					<table>

						<br>
						<tr>
							<th>이름</th>
							<th>소속 부서</th>
						</tr>
						<tr v-for="manager in Managers" @click="selectManager(manager)">
							<td>{{ manager.name }}</td>
							<td>{{ manager.dept }}</td>
						</tr>
					</table>
				</div>
			</div>
			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp"
				flush="false" />
		</div>
	</div>
</body>

<script>
new Vue({
    el: '#app',
    data: {
        customers: [], // 고객 정보를 저장할 배열
        Managers: [], //관리자 정보를 저장할 배열
        filteredCustomers: [], // 필터된 고객 정보를 저장할 배열
        consults:[], // 고객 별 상담내역
        subProducts:[], //고객 별 가입상품 내역
        designProducts:[], //고객 별 설계상품 내역
        selectedCustomer: null, // 선택된 고객 정보
        userId: '${userInfoVO.userId}', // 현재 사용자의 userId를 저장
        userDept:'${userInfoVO.dept}',
        customerSubDate:'',
        customerName: '', // 고객 이름을 저장할 변수
        customerIdNumber:'',
        customerLevel:'',
        customerPhone: '',
        customerSubTel: '',
        customerEmail:'', // 고객 이메일을 저장할 변수
        customerJob: '', 
        customerAddr: '',
        searchKeyword: '', // 검색 키워드 저장
        searchManagerName:'', // 관리자 이름 키워드 저장
        errorMessage: '', // 오류 메시지 저장
        showFullIdNumber: false, // 주민등록번호 표시 여부를 저장하는 데이터 변수
        showPopup: false,
        selectedManager: '',
        filteredManager: [], 
        selectedConsult: null, // 선택된 상담 객체
        showModal: false, // 모달 표시 여부,
        showAddConsultModal: false, //상담추가 모달 표시 여부
        customerConId:'',
		consultTitle: '',
		consultContext: '',
		
    },
    watch: {
        // selectedCustomer의 변경을 감지하는 watch
        selectedCustomer(newCustomer, oldCustomer) {
            if (newCustomer !== null) {
                // 선택된 고객이 변경되면 상담 내역을 가져오는 메서드를 호출합니다.
                this.getCustConsults();
                this.getSubProducts();
                this.getDesignProducts();
              
            } else {
                // 선택된 고객이 없으면 상담 내역 배열을 초기화합니다.
                this.consults = [];
                this.subProducts = [];
                this.designProducts=[];
            }
        },
    },
    methods: {
    	moveProductInfoForm(sub_id, product_id, customer_id){
    		var params = {
    			customer_id : customer_id,
    			product_id : product_id,
    			sub_id : sub_id,
    			flag : "Y",
    		}
			cf_movePage("/team4/subscriptionList", params);
    	},
    	moveDesignInfoForm(design_id, product_id, customer_id){
    		var params = {
    			customer_id : customer_id,
    			product_id : product_id,
    			design_id : design_id,
    			flag : "Y",
    		}
			cf_movePage("/team4/designList", params);
    	},
        getAllCustomers: function() {
            // AJAX 요청을 보내고 응답 데이터를 customers에 할당
            axios.get('/system/team4/getCustAndUserInfo')
                .then(response => {
                    this.customers = response.data;
                    this.filterCustomers(); // 고객 필터링 함수 호출
                    
                    this.selectedCustomer = null; // 선택 고객 초기화
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        },
        filterCustomers: function() {
             //같은 부서 직원끼리 필터링
            this.filteredCustomers = this.customers.filter(customer => customer.dept === this.userDept);
        },
        filterManagersByDept: function() {
            axios.get('/system/team4/getUserInfo')
            .then(response => {
                // API 호출로부터 데이터를 받은 후에 필터링을 수행
                this.Managers = response.data;
                this.filteredManager = this.Managers.filter(manager => manager.dept === this.userDept);
            })
            .catch(error => {
                console.error('Error:', error);
            });
        },
        getCustConsults: function() {
        	var params = {
                    customer_id: this.selectedCustomer.customer_id,
                    
                };
      
            axios.get('/system/team4/getCustConsult',{ params: params })
                .then(response => {
                    this.consults = response.data;
                    
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        },
        getSubProducts: function() {
        	var params = {
                    customer_id: this.selectedCustomer.customer_id,
                    
                };
         
            axios.get('/system/team4/getSubProductInfo',{ params: params })
                .then(response => {
                    this.subProducts = response.data;
                    
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        },
        getDesignProducts: function() {
        	var params = {
                    customer_id: this.selectedCustomer.customer_id,
                    
                };
         
            axios.get('/system/team4/getDesignProductInfo',{ params: params })
                .then(response => {
                    this.designProducts = response.data;
                    
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        },
        toggleMasking: function() {
            // 현재 마스킹 상태를 확인하여 토글
            this.showFullIdNumber = !this.showFullIdNumber;
        },

        maskIdNumber: function(idNumber) {
            // 예시: 문자열로 변환 후 8자리까지만 표시하고 나머지는 '*'로 대체
            if (!this.showFullIdNumber) {
                if (idNumber && typeof idNumber === 'string') {
                    return idNumber.substring(0, 8) + '*'.repeat(idNumber.length - 8);
                } else {
                    return '';
                }
            } else {
                // 마스킹 해제 상태에서는 원래의 주민등록번호 표시
                return idNumber;
            }
        },

        searchCustomers: function() {
            if (this.searchKeyword.trim() === '') {
                alert('검색어를 입력하세요.');
                return;
            }
            // 선택된 담당자가 있는 경우에 대해서만 필터링된 결과에서 검색 수행
            if (this.selectedManager !== '') {
                this.filteredCustomers = this.customers.filter(customer =>
                    customer.customer_name.includes(this.searchKeyword) &&
                    customer.name === this.selectedManager &&
                    customer.dept === this.userDept
                );
            } else {
                // 선택된 담당자가 없는 경우 전체 고객에서 검색 수행
                this.filteredCustomers = this.customers.filter(customer => 
                    customer.customer_name.includes(this.searchKeyword) &&
                    customer.dept === this.userDept
                );
            }
            this.searchKeyword = '';
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

           
                axios.put('/system/team4/updateCust', { params: params })
                    .then(response => {
                        if (response.data.status === 'OK') {
                            alert('고객 정보가 수정되었습니다.');
                        } else if (response.data.status === 'ERROR') {
                            alert(response.data.message); // 서버로부터 받은 에러 메시지를 표시
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('고객 정보 수정 중 오류가 발생했습니다.');
                    });
            } else {
                alert('수정할 고객을 선택해주세요.');
            }
        },
        addCustomer: function() {
        	
        	//폼에 비어있는 칸이 있나 확인하기
        	 if (
        this.customerName.trim() === '' ||
        this.customerIdNumber.trim() === '' ||
       
        this.customerPhone.trim() === '' ||
        this.customerSubTel.trim() === '' ||
        this.customerEmail.trim() === ''
    ) {
        alert('모든 필수 입력 필드를 입력해주세요.');
        return; 
    }
        	   // 주민등록 번호 자릿수 확인 (YYMMDD-1234567 형식으로 입력될 것을 가정)
             if (this.customerIdNumber.trim().length !== 14) {
                 this.errorMessage = alert('올바른 주민등록 번호 형식이 아닙니다. YYMMDD-1234567 형식으로 입력해주세요.');
                 return;
             }
        	
            // 새로운 고객 정보 생성
            var params = {
                customer_name: this.customerName,
                customer_id_number: this.customerIdNumber,
                customer_phone: this.customerPhone,
                customer_sub_tel: this.customerSubTel,
                customer_email: this.customerEmail,
                customer_job: this.customerJob,
                customer_addr: this.customerAddr,
                user_id: this.userId // 현재 사용자의 userId 추가
            };

            // 서버에 POST 요청으로 새로운 고객 등록
            axios.post('/system/team4/addCust', { params: params })
                .then(response => {
                    if (response.data.status === 'OK') {
                        alert('새로운 고객이 등록되었습니다.');
                        this.getAllCustomers(); // 고객 목록을 다시 불러옵니다.
                        this.resetForm(); // 입력 폼 초기화
                    }else if (response.data.status === 'ERROR') {
                        this.errorMessage = response.data.message; // 오류 메시지 저장
                        alert(response.data.message); // 사용자에게 오류 메시지 alert으로 표시
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('고객 등록 중 오류가 발생했습니다.');
                });
        },
		popupUser: function() {
			axios.get('/system/team4/getUserInfo')
			.then(response => {
				this.Managers = response.data;
			})
			.catch(error => {
				console.error('Error:', error);
			});
			this.showPopup = true;
		},
		closePopup: function() {
			this.showPopup = false;
		},
		searchManager: function() {
	            if (this.searchManagerName.trim() === '') {
	                alert('검색어를 입력하세요.');
	                return;
	            }
	            axios.get('/system/team4/getUserInfo')
	                .then(response => {
	                   	this.Managers = response.data;
	                    this.Managers = this.Managers.filter(manager =>
	                    manager.name.includes(this.searchManagerName)
	                );
	                    
	                })
	                .catch(error => {
	                    console.error('Error:', error);
	                });
	        },
	        searchManagerReset:function(){
	        	axios.get('/system/team4/getUserInfo')
				.then(response => {
					this.Managers = response.data;
					 this.searchManagerName = '';
				})
				.catch(error => {
					console.error('Error:', error);
				});
	        	
	        },
		
	    showConsultDetails(consult) {
	        this.selectedConsult = consult;
	        this.showModal = true;
	    },
	    closeModal() {
	        this.selectedConsult = null;
	        this.showModal = false;
	    },
	    
	    openAddConsultModal() {
            this.showAddConsultModal = true;
        },
        closeAddConsultModal() {
            this.showAddConsultModal = false;
        },
		addConsult:function(){
			
		
			   if (
				        this.consultTitle.trim() === '' ||
				        this.consultContext.trim() === ''
				        
				    ) {
				        alert('모든 필수 입력 필드를 입력해주세요.');
				        return; 
				    }
   
			var params = {
				user_id : this.userId,
				consult_title : this.consultTitle,
				consult_context : this.consultContext,
				con_id : this.selectedCustomer.con_id,
				
			};
			   //서버에 POST 요청으로 새로운 상담내용 등록
         axios.post('/system/team4/addConsult', { params: params })
             .then(response => {
                 if (response.data.status === 'OK') {
                     alert('새로운 상담내역이 등록되었습니다.');
                     this.showAddConsultModal = false;
                     this.getCustConsults();
                 } else {
                     alert('상담내역 등록에 실패했습니다.');
                 }
             })
             .catch(error => {
                 console.error('Error:', error);
                 alert('상담내역 등록 중 오류가 발생했습니다.');
             });
			
		},
		resetConsultForm: function() {
			this.consultTitle = '';
			this.consultContext = '';
		},
        
		selectManager: function(manager) {
			this.selectedCustomer.name = manager.name;
			this.selectedCustomer.dept = manager.dept;
			this.selectedCustomer.jikgub_nm = manager.jikgub_nm;
			this.selectedCustomer.user_id = manager.user_id;
			
			
			this.showPopup = false;
		},
        resetForm: function() {
            // 입력 폼 데이터 초기화
            this.selectedCustomer = null; // 선택된 고객 초기화
            this.customerName = ''; // 고객 이름 초기화
            this.customerIdNumber = ''; // 고객 주민번호 초기화
            this.customerLevel = ''; // 고객 등급 초기화
            this.customerPhone = ''; // 고객 전화번호 초기화
            this.customerSubTel = ''; // 고객 비상연락망 초기화
            this.customerEmail = ''; // 고객 이메일 초기화
            this.customerJob = ''; // 고객 직업 초기화
            this.customerAddr = ''; // 고객 주소 초기화
        },
        updateUser: function() {
            // 선택된 고객이 존재하는지 확인
            if (this.selectedCustomer !== null) {
                // 서버에 보낼 관리자 정보 준비
                var params = {
                    customer_id: this.selectedCustomer.customer_id,
                    user_id: this.selectedCustomer.user_id
                };

                // 서버에 PUT 또는 POST 요청 보내기 (수정에 따라 다름)
                axios.post('/system/team4/updateUser', { params: params })
                    .then(response => {
                        if (response.data.status === 'OK') {
                            alert('관리자 정보가 수정되었습니다.');
                            this.getAllCustomers();
                        } else if (response.data.status === 'ERROR') {
                            alert(response.data.message); // 서버로부터 받은 에러 메시지를 표시
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('관리자 정보 수정 중 오류가 발생했습니다.');
                    });
            } else {
                alert('수정할 관리자를 선택해주세요.');
            }
        },
        filterByManager: function() {
            // 선택된 담당자가 있는지 확인
            if (this.selectedManager !== '') {
                // 모든 고객 목록에서 선택된 담당자에 해당하는 고객들을 필터링
                this.filteredCustomers = this.customers.filter(customer =>
                    customer.name === this.selectedManager && customer.dept === this.userDept
                );
            } else {
                // 선택된 담당자가 없을 경우 전체 고객 목록을 보여줍니다.
                this.filterCustomers(); // 또는 getAllCustomers() 메서드를 호출하여 전체 고객 목록을 다시 불러올 수 있습니다.
            }
        },
    },
    

    mounted: function() {
        // 페이지 로딩 시 
        this.getAllCustomers(); //전체 고객 조회화면
        this.filterManagersByDept(); //해당 부서 사원 in 셀렉트 박스
        this.selectedCustomer = null;
    }
});
</script>


</html>