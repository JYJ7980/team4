<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
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

.modal-body {
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: left;
	justify-content: center;
	font-size: 17px;
}

.modal-content {
	background-color: #fefefe;
	margin: 10% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 550px;
	height: 350px;
}

.modal-addconsult {
	background-color: #fefefe;
	margin: 15% auto;
	text-align: center;
	align-items: center;
	padding: 20px;
	border: 1px solid #888;
	width: 600px;
	height: 550px;
}

.popup {
	display: none;
	position: fixed;
	text-align: center;
	align-items: center;
	padding: 20px;
	left: 55%;
	top: 60%;
	transform: translate(-50%, -50%);
	border: 1px solid #ccc;
	background-color: #fff;
	z-index: 1000;
	width: 600px;
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
	text-align: center; /* 내용을 가운데 정렬 */
}

.popup-content {
	text-align: center; /* 내용을 가운데 정렬 */
}

textarea {
	resize: none;
	padding: 10px;
}

.span {
	justify-content: center;
	align-items: center;
	display: flex;
}
</style>
<title>상담내역 조회</title>
</head>
<body class="page-body">

	<div class="page-container">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/team4/sidebar-menu.jsp"
			flush="false" />

		<div class="main-content"
			style="background-image: url('/static_resources/team4/images/background-test.png'); background-size: cover; background-position: center; repeat: no-repeat">
			<jsp:include page="/WEB-INF/jsp/kcg/_include/team4/header.jsp"
				flush="false" />

			<ol class="breadcrumb bc-3">
				<li><a href="#none" onclick="cf_movePage('/system/team4/main')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>상담내역 조회</strong></li>
			</ol>

			<h2>고객관리 > 상담내역 조회</h2>

			<br /> <span
				style="font-size: 18px; font-weight: bold; color: black;">${userInfoVO.name}</span><span
				style="font-size: 18px; color: black;">(${userInfoVO.dept})</span>&nbsp;
			님 상담내역

			<div class="dataTables_wrapper" id="vueapp"
				style="border-style: none; margin-top: 10px;">
				<template>
					<table class="table table-bordered datatable dataTable"
						style="border: 1px solid #ccc; border-top-left-radius: 30px; border-top-right-radius: 30px;">
						<thead>
							<tr class="replace-inputs">
								<th
									style="width: 10%; background-color: #FDEE87; color: black; border-top-left-radius: 30px;"
									class="center sorting">등록일</th>
								<th style="width: 10%; background-color: #FDEE87; color: black;"
									class="center sorting">제목</th>
								<th style="width: 10%; background-color: #FDEE87; color: black;"
									class="center sorting">고객명</th>
								<th style="width: 10%; background-color: #FDEE87; color: black;"
									class="center sorting">고객 담당자명</th>
								<th
									style="width: 10%; background-color: #FDEE87; color: black; border-top-right-radius: 30px;"
									class="center sorting">고객 담당부서</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="item in dataList" style="cursor: pointer;">
								<td class="center">{{item.con_date}}</td>
								<td class="center" @click="showConsultDetails(item)">{{item.consult_title}}</td>
								<td class="center">{{item.customer_name}}</td>
								<td class="center">{{item.representative_name}}</td>
								<td class="center">{{item.dept}}</td>


							</tr>
						</tbody>
					</table>
					<div class="dataTables_paginate paging_simple_numbers"
						id="div_paginate" style="background-color: white;"></div>
				</template>
				<br>
				<button @click="filterList">담당 고객만 조회</button>
				<button @click="getAllList">전체 상담내역 조회</button>
				<button @click="openAddConsultModal()">상담 내역 추가</button>

				<!-- 							상담내역 모달 -->
				<div class="modal" v-if="selectedConsult !== null">
					<div class="modal-content">
						<span class="close" @click="closeModal">&times;</span>
						<div class="modal-body">
							<div>
								<label style="margin-left: -110px;">상담일시: </label> <input type="text"
									v-model="selectedConsult.con_date" disabled="disabled">
							</div>
							<br>
							<div>
								<label>상담내용</label><br>
								<textarea cols="40" rows="5"
									v-model="selectedConsult.consult_context" disabled="disabled"></textarea>
							</div>
						</div>
					</div>
				</div>

				<!-- 							상담추가 모달 -->
				<div class="modal" v-if="showAddConsultModal">
					<div class="modal-addconsult">
						<span class="close" @click="closeAddConsultModal">&times;</span>
						<div class="modal-body">
							<span>**상담내역을 추가하세요**</span>
							<div class="input-form">
								<br> <br> <label for="customerName"
									style="margin-left: -80px;">고객 이름:</label> <input type="search"
									id="customerName" v-model="customerName"
									placeholder="고객을 선택하세요">
								<button type="button" class="btn" @click="popupCust()">
									<i class="fa fa-search"></i> 검색
								</button>
							</div>
							<br>
							<div class="input-form">
								<label for="consultTitle" style="margin-left: -120px;">제목:</label>
								<input type="text" id="consultTitle" v-model="consultTitle"
									size="20">
							</div>
							<br>
							<div class="input-form">
								<label for="consultContext" style="margin-left: 18px;">내용</label><br>
								<textArea rows="5" cols="40" id="consultContext"
									v-model="consultContext" style="margin-left: 10px;"></textArea>
							</div>
							<br>
							<div class="popup-overlay" :class="{active: showPopup}"
								@click="closePopup"></div>
							<div class="popup" :class="{active: showPopup}">
								<div class="popup-close" @click="closePopup">X</div>
								<br> <br>
								<div class="popup-search-container">
									<div class="popup-content">
										<label for="searchInput" style="margin-left: 40px;">고객
											이름:</label> <input type="text" id="searchInput"
											v-model="searchKeyword">
										<button type="button" class="btn" @click="searchCustomers">
											<i class="fa fa-search"></i>
										</button>
										<button type="button" class="btn"
											@click="searchCustomersReset">다시</button>
									</div>
								</div>
								<br>
								<table>
									<tr>
										<th>이름</th>
										<th>생년월일</th>
										<th>고객 담당자</th>
									</tr>
									<tr v-for="customer in customers"
										@click="selectCustomer(customer)">
										<td>{{ customer.customer_name }}</td>
										<td>{{ customer.customer_brdt }}</td>
										<td>{{ customer.name }}({{ customer.dept }}-{{
											customer.jikgub_nm }})</td>
									</tr>
								</table>
							</div>
						</div>
						<button type="button" class="btn" @click="addConsult">추가</button>
						<button type="button" class="btn" @click="resetForm">취소</button>
					</div>
				</div>
			</div>

			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp"
				flush="false" />

		</div>
	</div>

</body>
<script>
	var vueapp = new Vue({
		el : "#vueapp",
		data : {
			dataList : [],
			userId : '${userInfoVO.userId}', // 현재 사용자의 userId를 저장하는 변수
			userName : '${userInfoVO.name}',
			showAddConsultModal: false, //상담추가 모달 표시 여부
			customers: [], // 고객 정보를 저장할 배열
			showPopup: false,
			customerConId:'',
			customerName: '',
			consultTitle: '',
			consultContext: '',
			searchKeyword: '', // 팝업에 있는 고객이름 검색 keyword
			selectedConsult: null, // 선택된 상담 객체

		},
		mounted () {
			this.getAllCustomers();
			this.getAllList();
		},
		methods : {
			getList : function(isInit) {

				cv_pagingConfig.func = this.getList;

				if (isInit === true) {
					cv_pagingConfig.pageNo = 1;
				}
				var params = {
					user_id : this.userId,

				};

				cv_sessionStorage.setItem('pagingConfig', cv_pagingConfig)
						.setItem('params', params);

				cf_ajax("/system/team4/getAllconsult", params, this.getListCB);
			},
			getListCB : function(data) {
				this.dataList = data.list;
				cv_pagingConfig.renderPagenation("system");
			},

			getListMyConsult : function(isInit) {
				cv_pagingConfig.func = this.getListMyConsult;
				var params = {
					user_id_number : this.userId,
					user_name : this.userName
				};

				cv_sessionStorage.setItem('pagingConfig', cv_pagingConfig)
						.setItem('params', params);

				cf_ajax("/system/team4/getAllMyconsult", params,
						this.getListFilter);
			},
			
			
			
			getListFilter : function(data) {
				this.dataList = data.list;
				cv_pagingConfig.renderPagenation("system");
			},

			filterList : function() {
				if (cv_pagingConfig.pageNo != 1) {
					cv_pagingConfig.pageNo = 1;
				};
				var fromDtl = cf_getUrlParam("fromDtl");
				var pagingConfig = cv_sessionStorage.getItem("pagingConfig");
				if ("Y" === fromDtl &&!cf_isEmpty(pagingConfig)) {
					cv_pagingConfig.pageNo = pagingConfig.pageNo;
					cv_pagingConfig.orders = pagingConfig.orders;
					this.getListMyConsult();
				} else {
					cv_sessionStorage.removeItem("pagingConfig").removeItem(
							"params");
					this.getListMyConsult(true);
				}
			},
			
			getAllList:function() {
				var fromDtl = cf_getUrlParam("fromDtl");
				var pagingConfig = cv_sessionStorage.getItem("pagingConfig");
				if ("Y" === fromDtl && !cf_isEmpty(pagingConfig)) {
					cv_pagingConfig.pageNo = pagingConfig.pageNo;
					cv_pagingConfig.orders = pagingConfig.orders;

					this.getList();
				} else {
					cv_sessionStorage.removeItem("pagingConfig").removeItem(
							"params");
					this.getList(true);
				}
			},
		    openAddConsultModal() {
	            this.showAddConsultModal = true;
	        },
	        closeAddConsultModal() {
	            this.showAddConsultModal = false;
	        },
			getAllCustomers: function() {
				// AJAX 요청을 보내고 응답 데이터를 customers에 할당
				axios.get('/system/team4/getCustAndUserInfo')
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
		            axios.get('/system/team4/getCustAndUserInfo')
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
		        	axios.get('/system/team4/getCustAndUserInfo')
					.then(response => {
						this.customers = response.data;
						 this.searchKeyword = '';
					})
					.catch(error => {
						console.error('Error:', error);
					});
		        	
		        },
			popupCust: function() {
				axios.get('/system/team4/getCustAndUserInfo')
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
			},
		    showConsultDetails(item) {
		        this.selectedConsult = item;
		        this.showModal = true;
		    },
		    closeModal() {
		        this.selectedConsult = null;
		        this.showModal = false;
		    },

		},
	})
</script>
</html>