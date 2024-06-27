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

<title>퇴직자 조회</title>
<style>
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
				<li class="active"><strong>퇴직자 조회</strong></li>
			</ol>

			<h2>직원관리 > 퇴직자 조회</h2>
			<br />

			<div class="dataTables_wrapper" id="vueapp">
				<template>
					<table class="table table-bordered datatable dataTable"
						id="grid_app">
						<thead>
							<tr class="replace-inputs">
								<th style="width: 10%;" class="center sorting">성명</th>
								<th style="width: 10%;" class="center sorting">부서</th>
								<th style="width: 10%;" class="center sorting">직급</th>
								<th style="width: 10%;" class="center sorting">담당 고객</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="(item, index) in dataList" :key="index" style="cursor: pointer;">
								<td class="center">{{item.name}}</td>
								<td class="center">{{item.dept}}</td>
								<td class="center">{{item.jikgub_nm}}</td>
								<td class="center"><button type="button" class="btn"
										@click="customerPopup(item, index)">보기</button></td>
							</tr>
						</tbody>
					</table>
					<div class="dataTables_paginate paging_simple_numbers"
						id="div_paginate"></div>
				</template>


				<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp"
					flush="false" />
				<div class="popup-overlay" :class="{active: showPopup}"
					@click="closePopup"></div>
				<div class="popup" :class="{active: showPopup}">
					<div class="popup-close" @click="closePopup">X</div>
					<br>
					<table>
						<br>
						<tr>
							<th>이름</th>
							<th>생년월일</th>
							<th>관리자 수정</th>
						</tr>
						<tr v-for="(customer, customerIndex) in customers" :key="customerIndex">
							<td>{{ customer.customer_name }}</td>
							<td>{{ customer.customer_brdt }}</td>
							<td>
								<select v-model="customer.selectedAdmin">
									<option v-for="admin in adminList" :key="admin.user_id" :value="admin">
										{{ admin.name }}({{ admin.dept }}-{{ admin.jikgub_nm }})
									</option>
								</select>
								<button @click="updateAdmin(customer)">수정</button>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>
<script>
	var vueapp = new Vue(
			{
				el : "#vueapp",
				data : {
					dataList : [],
					customers : [],
					adminList: [],
					showPopup: false,
					userId: null
				},
				mounted : function() {
					var fromDtl = cf_getUrlParam("fromDtl");
					var pagingConfig = cv_sessionStorage
							.getItem("pagingConfig");
					if ("Y" === fromDtl && !cf_isEmpty(pagingConfig)) {
						cv_pagingConfig.pageNo = pagingConfig.pageNo;
						cv_pagingConfig.orders = pagingConfig.orders;

						this.getList();
					} else {
						cv_sessionStorage.removeItem("pagingConfig")
								.removeItem("params");
						this.getList(true);
					}
				},
				methods : {
					getList : function(isInit) {
						cv_pagingConfig.func = this.getList;

						if (isInit === true) {
							cv_pagingConfig.pageNo = 1;
						}

						var params = {};
					
						cv_sessionStorage.setItem('pagingConfig',
								cv_pagingConfig).setItem('params', params);

						cf_ajax("/system/team4/employee/getQuitUser", params,
								this.getListCB);
					},
					getListCB : function(data) {
						this.dataList = data.list;
						cv_pagingConfig.renderPagenation("system");
					},
					customerPopup: function(item, index) {
						this.userId = item.user_id;
						var params = {
							user_id : this.userId,
						};

						axios.get("/system/team4/employee/getQuitUserCustomerInfo",{ params: params })
						.then(response => {
							// 복사하지 않고 직접 customers 배열에 추가
							this.customers = [...response.data];
							this.customers.forEach(customer => {
								customer.selectedAdmin = null; // 각 고객에 대한 선택된 관리자 초기화
							});
						})
						.catch(error => {
							console.error('Error:', error);
						});
						
						axios.get("/system/team4/employee/getCurrentUserInfo")
						.then(response => {
							this.adminList = response.data;
							this.showPopup = true; // 팝업 보이기
						})
						.catch(error => {
							console.error('에러:', error);
						});
						this.showPopup = true; // 팝업 표시
					},
					closePopup: function() {
						this.showPopup = false; // 팝업 숨기기
					},
					updateAdmin: function(customer) {
						if (!customer.selectedAdmin) {
							alert('관리자를 선택해 주세요.');
							return;
						}

						var params = {
							customer_id: customer.customer_id,
							user_id: customer.selectedAdmin.user_id
						};

						axios.post("/system/team4/employee/changeQuitUser",{ params: params })
						.then(response => {
							if (response.data.status === 'OK') {
								alert('관리자 정보가 수정되었습니다.');
								this.closePopup(); // 팝업 닫기
							} else {
								alert('관리자 정보 수정 중 오류가 발생했습니다.');
							}
						})
						.catch(error => {
							console.error('에러:', error);
							alert('관리자 정보 수정 중 오류가 발생했습니다.');
						});
					}
				}
			})
</script>
</html>