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
	display: flex;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: 40px;
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
	height: 380px;
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
	padding-top: 5px;
	padding-left: 5px;
	padding-bottom: 5px;
	background-color: #FDEE87;
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

.modal {
	display: block;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	margin-left: 100px;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
	padding-top: 60px;
}

.modal-content {
	background-color: #fefefe;
	margin: 10% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 550px;
	height: 350px;
}

.modal-body {
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: left;
	justify-content: center;
	font-size: 17px;
}

.modal-addconsult {
	background-color: #fefefe;
	margin: 15% auto;
	text-align: center;
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

textarea {
	resize: none;
	padding: 10px;
}

.my-hr3 {
	border: 0;
	height: 3px;
	background: #ccc;
}

.search-icon {
	width: 30px;
	height: 30px;
	margin-left: 30px;
}
</style>


</head>
<body class="page-body">
	<div class="page-container">
		<jsp:include page="/WEB-INF/jsp/kcg/_include/team4/sidebar-menu.jsp"
			flush="false" />

		<div class="main-content"
			style="background-image: url('/static_resources/team4/images/background-2.png'); background-size: cover; background-position: center; repeat: no-repeat">
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
					style="font-size: 18px; font-weight: bold; color: black; margin-left: -30px;">${userInfoVO.name}(${userInfoVO.dept})</span>&nbsp;
				님 고객관리 <br>
				<div style="margin-top: 30px;">
					<img src="/static_resources/team4/images/돋보기.PNG"
						class="search-icon"> <input id="keywordInput" type="text"
						name="keyword" v-model="searchKeyword" class="inputtext"
						placeholder="이름을 입력하세요">
					<button @click="searchCustomers" class="btn">이름 검색</button>
					<button @click="getAllCustomers" class="btn">전체 조회</button>
				</div>

				<br>
				<div id="customerTable" class="customer-container">
					<div class="customer-one">
						<div class="customer-list" style="margin-left: -40px;">

							<h3 v-show="filteredCustomers.length >= 0">전체 고객 정보</h3>
							<div v-show="filteredCustomers.length == 0">
								<p>담당고객이 없습니다</p>
							</div>
							<div v-show="filteredCustomers.length > 0">
								<div class="table-header">
									<div class="table-cell">선택</div>
									<div class="table-cell">이름</div>
									<div class="table-cell">생년월일</div>

								</div>
								<div class="customer-item" v-for="customer in filteredCustomers"
									:key="customer.customer_id">
									<div class="table-cell">
										<input type="radio" name="selectedCustomer"
											v-model="selectedCustomer" :value="customer">
									</div>
									<div class="table-cell">{{ customer.customer_name }}</div>
									<div class="table-cell">{{ customer.customer_brdt }}</div>

								</div>
							</div>
						</div>
						<div class="customer-list" v-if="selectedCustomer !== null"
							style="margin-left: -40px; height: 220px; background-color: white;">
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
									<div class="modal-body">
										<div>
											<label style="margin-left: -120px;">상담일시: </label><input type="text"
												v-model="selectedConsult.con_date" disabled="disabled">
										</div>
										<br>
										<div>
											<label>상담내용</label><br>
											<textarea cols="40" rows="5"
												v-model="selectedConsult.consult_context"
												disabled="disabled"></textarea>
										</div>
									</div>
								</div>
							</div>
							<!-- 							상담추가 모달 -->
							<div class="modal" v-if="showAddConsultModal">
								<div class="modal-addconsult">
									<span class="close" @click="closeAddConsultModal">&times;</span>
									<div class="modal-body">
										<span>**상담내역을 추가해주세요**</span><br>
										<div>
											<label for="consultTitle" style="margin-left: -50px;">제목:
											</label> <input type="text" id="consultTitle" v-model="consultTitle">

										</div>
										<div>
											<label for="consultContext" style="margin-left: 10px;">내용:</label>
											<textArea rows="5" cols="25" id="consultContext"
												v-model="consultContext"></textArea>
										</div>
									</div>
									<button type="button" class="btn" @click="addConsult">추가</button>
									<button type="button" class="btn" @click="resetConsultForm">취소</button>
								</div>
							</div>

						</div>
					</div>
					<!-- 선택된 고객의 상세 정보 입력 폼 -->
					<div class="customer-details" v-if="selectedCustomer !== null"
						style="height: 670px; margin-top: -40px;">
						<div class="details-container">
							<div class="customer-info">
								<h3>고객 정보</h3>
								<div class="input-form">
									<label for="customerSubDate" style="margin-left: 45px;">등록일
										: </label> <input type="text" id="customerSubDate"
										v-model="selectedCustomer.customer_sub_date"
										style="margin-left: 10px;" readonly>
								</div>
								<div class="input-form">
									<label for="customerName" style="margin-left: 28px;">고객
										이름 : </label> <input type="text" id="customerName"
										v-model="selectedCustomer.customer_name"
										style="margin-left: 10px;">
									<button type="button" class="btn"
										@click="openAddConsultModal()" style="margin-left: 10px;">상담추가</button>
								</div>
								<div class="input-form">
									<label for="customerIdNumber">고객 주민번호 : </label> <input
										type="text" id="customerIdNumber"
										:value="maskIdNumber(selectedCustomer.customer_id_number)"
										readonly style="margin-left: 10px;">
									<button @click="toggleMasking" style="margin-left: 10px;">확인</button>
								</div>
								<div class="input-form">
									<label for="customerLevel" style="margin-left: 28px;">고객
										등급 : </label> <select id="customerLevel"
										v-model="selectedCustomer.customer_level"
										style="margin-left: 10px;">
										<option value="1" style="text-align: center;">일반</option>
										<option value="2" style="text-align: center;">우수</option>
										<option value="3" style="text-align: center;">VIP</option>
										<option value="4" style="text-align: center;">VVIP</option>
										<option value="5" style="text-align: center;">플래티넘</option>
									</select>

								</div>
								<div class="input-form">
									<label for="customerPhone">고객 전화번호 : </label> <input
										type="text" id="customerPhone"
										v-model="selectedCustomer.customer_phone"
										style="margin-left: 10px;">
								</div>
								<div class="input-form">
									<label for="customerSubTel" style="margin-left: 18px;">비상연락망
										: </label> <input type="text" id="customerSubTel"
										style="margin-left: 10px;"
										v-model="selectedCustomer.customer_sub_tel">
								</div>
								<div class="input-form">
									<label for="customerEmail" style="margin-left: 15px;">고객
										이메일 : </label> <input type="text" id="customerEmail"
										v-model="selectedCustomer.customer_email"
										style="margin-left: 10px;">
								</div>
								<div class="input-form">
									<label for="customerJob" style="margin-left: 29px;">고객
										직업 : </label> <input type="text" id="customerJob"
										v-model="selectedCustomer.customer_job"
										style="margin-left: 10px;">
								</div>
								<div class="input-form">
									<label for="customerAddr" style="margin-left: 29px;">고객
										주소 : </label> <input type="text" id="customerAddr"
										v-model="selectedCustomer.customer_addr"
										style="margin-left: 10px;">
								</div>
								<br>
								<div style="margin-left: 150px;">
									<button @click="deleteCustomer" class="btn">삭제</button>
									<button @click="updateCustomer" class="btn">수정</button>
									<button @click="resetForm" class="btn">신규</button>
								</div>
								<hr>
								<div class="manager-info" style="border-style: none;">
									<h3>담당자 정보</h3>
									<div class="input-form">
										<label for="userName" style="margin-left: 10px;">관리자
											이름 : </label> <input type="text" id="userName"
											value="${userInfoVO.name}" disabled
											style="margin-left: 10px;">
									</div>
									<div class="input-form">
										<label for="userDept" style="margin-left: 10px;">관리자
											부서 : </label> <input type="text" id="userDept"
											value="${userInfoVO.dept}" disabled
											style="margin-left: 10px;">
									</div>
									<div class="input-form">
										<label for="userjikgub" style="margin-left: 10px;">관리자
											직급 : </label> <input type="text" id="userJikgub"
											value="${userInfoVO.jikgubNm}" disabled
											style="margin-left: 10px;">
									</div>
								</div>
							</div>
							<div class="other-info">

								<br>
								<div class="sub-product" style="border-style: none;">

									<h3 style="margin-top: -5px;">가입상품 정보</h3>
									<div v-if="subProducts.length > 0">
										<div class="table-header">
											<div class="table-cell">가입일</div>
											<div class="table-cell">가입 상품</div>
										</div>

										<!-- Iterate over consults array to display each consultation item -->
										<div class="customer-item" v-for="subProduct in subProducts">
											<div class="table-cell">{{ subProduct.sub_start_date }}</div>
											<div class="table-cell"
												@click="moveProductInfoForm(subProduct.sub_id, subProduct.product_id, subProduct.customer_id)">{{
												subProduct.product_name }}</div>
										</div>
									</div>
									<div v-else>
										<p>가입상품 내역이 없습니다.</p>
									</div>

								</div>
								<hr class="my-hr3">
								<br>
								<div class="design-product" style="border-style: none;">
									<h3 style="margin-top: -5px;">설계상품 정보</h3>
									<div v-if="designProducts.length > 0">
										<div class="table-header">
											<div class="table-cell">설계일</div>
											<div class="table-cell">설계 상품</div>
										</div>

										<!-- Iterate over consults array to display each consultation item -->
										<div class="customer-item"
											v-for="designProduct in designProducts">
											<div class="table-cell">{{ designProduct.design_date }}</div>
											<div class="table-cell"
												@click="moveDesignInfoForm(designProduct.design_id, designProduct.product_id, designProduct.customer_id)">{{
												designProduct.product_name}}</div>
										</div>
									</div>
									<div v-else>
										<p>설계상품 내역이 없습니다.</p>
									</div>

								</div>
							</div>
						</div>
					</div>
					<div class="customer-details" v-else style="margin-top: -50px;">
						<div class="details-container">
							<div class="customer-info">
								<!-- 선택된 고객이 없는 경우의 메시지 -->
								<p>고객을 신규 등록해 주세요.</p>
								<p>**표시는 필수 입력값 입니다. [최조 등록 시 고객 등급은 일반 등급으로 등록]</p>
								<h3>고객 정보</h3>
								<div class="input-form">
									<label for="customerName" style="margin-left: 57px;">**고객
										이름 : </label> <input type="text" id="customerName"
										v-model="customerName" required style="margin-left: 10px;">
								</div>
								<div class="input-form">
									<label for="customerIdNumber" style="margin-left: 30px;">**고객
										주민번호 : </label> <input type="text" id="customerIdNumber"
										v-model="customerIdNumber" required maxlength="14"
										style="margin-left: 10px;">

								</div>
								<div class="input-form" style="margin-left: 210px;">
									<small>예시: YYMMDD-1234567</small>
								</div>
								<div class="input-form">
									<label for="customerPhone" style="margin-left: 30px;">**고객
										전화번호 : </label> <input type="text" id="customerPhone"
										v-model="customerPhone" required style="margin-left: 10px;">
								</div>
								<div class="input-form">
									<label for="customerSubTel" style="margin-left: 17px;">**고객
										비상연락망 : </label> <input type="text" id="customerSubTel"
										v-model="customerSubTel" style="margin-left: 10px;">
								</div>
								<div class="input-form">
									<label for="customerEmail" style="margin-left: 45px;">**고객
										이메일 : </label> <input type="email" id="customerEmail"
										v-model="customerEmail" required style="margin-left: 10px;">
								</div>
								<div class="input-form">
									<label for="customerJob" style="margin-left: 70px;">고객
										직업 : </label> <input type="text" id="customerJob"
										v-model="customerJob" style="margin-left: 10px;">
								</div>
								<div class="input-form">
									<label for="customerAddr" style="margin-left: 70px;">고객
										주소 : </label> <input type="text" id="customerAddr"
										v-model="customerAddr" style="margin-left: 10px;">
								</div>
								<div style="margin-left: 250px;">
									<button @click="addCustomer" class="btn">등록</button>
									<button @click="resetForm" class="btn">초기화</button>
								</div>
							</div>
							<div class="manager-info">
								<h3>담당자 정보</h3>
								<div class="input-form">
									<label for="userName" style="margin-left: 10px;">관리자 이름
										: </label> <input type="text" id="userName" value="${userInfoVO.name}"
										disabled style="margin-left: 10px;">
								</div>
								<div class="input-form">
									<label for="userDept" style="margin-left: 10px;">관리자 부서
										: </label> <input type="text" id="userDept" value="${userInfoVO.dept}"
										disabled style="margin-left: 10px;">
								</div>
								<div class="input-form">
									<label for="userjikgub" style="margin-left: 10px;">관리자
										직급 : </label> <input type="text" id="userJikgub"
										value="${userInfoVO.jikgubNm}" disabled
										style="margin-left: 10px;">
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</body>

<script>
new Vue({
    el: '#app',
    data: {
        customers: [], // 고객 정보를 저장할 배열
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
        	 axios.get('/system/team4/getCustInfo')
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
            // userInfoVO.userId와 customer.user_id가 같은 고객만 필터링
            this.filteredCustomers = this.customers.filter(customer => customer.user_id === this.userId);
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
            axios.get('/system/team4/getCustInfo')
                .then(response => {
                    this.customers = response.data;
                    this.filteredCustomers = this.customers.filter(customer => 
                        customer.user_id === this.userId && 
                        customer.customer_name.includes(this.searchKeyword)
                    );
                })
                .catch(error => {
                    console.error('Error:', error);
                });
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


    },
    

    mounted: function() {
        // 페이지 로딩 시 
        this.getAllCustomers(); //전체 고객 조회화면
        this.selectedCustomer = null;
    }
});
</script>


</body>

</html>