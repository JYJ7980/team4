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
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/promion.css">

<!-- Bilboard Chart(https://naver.github.io/billboard.js) -->
<script src="https://d3js.org/d3.v6.min.js"></script>
<script src="/static_resources/system/js/datatables/billboard.js"></script>
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/billboard.css">

<title>상품가입</title>
</head>
<body class="page-body">

	<div class="page-container">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />

		<div class="main-content">

			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
				flush="false" />

			<ol class="breadcrumb bc-3">
				<li><a href="#none" onclick="cf_movePage('/system')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>상품가입</strong></li>
			</ol>

			<h2>상품가입 양식</h2>
			<br />
			<div id=subFrom>
	<!-- 			상품선택 -->
				<div class="form-group" style="justify-content: left">
					<label>상품ID:</label>
					 <input class="form-control" id="product_id"
						v-model="info.product_id" disabled /> 
				</div>
				<div class="form-group" style="justify-content: left">
					<label>상품명:</label>	
						<input class="form-control"
						id="product_name" v-model="info.product_name" disabled />	
					<button type="button" class="btn" @click="popupProd()">
						<i class="fa fa-search"></i>
					</button>				
				</div>
				
	<!-- 			고객선택 -->
				<div class="form-group" style="justify-content: left">
					<label>고객ID:</label> 
					<input class="form-control" id="customer_id"
						v-model="info.customer_id"  disabled /> 
				</div>

				<div class="form-group" style="justify-content: left">
					<label>고객명:</label>
					<input class="form-control"
						id="customer_name" v-model="info.customer_name" disabled />
					<button type="button" class="btn" @click="popupProd()">
						<i class="fa fa-search"></i>
					</button>				
				</div>
				
				<!-- 		예금, 적금, 대출 일 때 나눠서 저장하기 위함 -->
			    <div v-if="info.product_type === '예금'">
			    	<label>예치 금액:</label>
			        <input type="text" name="start_money">
			        <span>원</span>
			    </div>
			    <div v-else-if="info.product_type === '적금'">
			    	<label>납입 금액:</label>
			        <input type="text" name="cycle_money">
			        <span>원</span>
			    </div>
			    <div v-else-if="info.product_type === '대출'">
			    	<label>대출 금액:</label>
			        <input type="text" name="loan">
			    	<span>원</span>       
			    </div>
			    <div v-else>
    			</div>
    			<br>
			    <label>이자율 :</label> 	    
				<input type="text" name="pro_interest_rate">
				<span>(%)</span>
				 <br><br>
			    <label>만기 날짜:</label> 
				<input type="text" name="sub_end_date"> 
			</div>

			<!-- 상품팝업 -->
			<div class="modal fade" id="pop_prod">
				<template>
					<div class="modal-dialog" style="width: 500px;">
						<div class="modal-content">
							<div class="modal-body">
								<div class="dataTables_wrapper">
									<div class="dt-buttons">
											<label>상품명:</label>
											<input type="search" id="pop_product_name" style="width: 200px;"
												v-model="pop_product_name">
											<button type="button" class="btn btn-red"
												style="margin-left: 5px;" @click="getList">검색</button>
									</div>
								</div>
								<div style="height: 400px; overflow: auto;"
									class="dataTables_wrapper">
									<table class="table table-bordered datatable dataTable">
										<thead style="position: sticky; top: 0px;">
											<tr>
												<th class="center" style="width: 25%;">상품ID</th>
												<th class="center" style="width: 50%;">상품명</th>
												<th class="center" style="width: 25%;">상품 유형</th>
											</tr>
										</thead>
										<tbody>
											<tr v-for="item in dataList" @click="selProd(item.product_id)"
												style="cursor: pointer;">
												<td class="center">{{item.product_id}}</td>
												<td class="left">{{item.product_name}}</td>
												<td class="left">{{item.product_type}}</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</template>
			</div>

			<!-- 고객팝업 -->
			<div class="modal fade" id="pop_cust">
				<template>
					<div class="modal-dialog" style="width: 500px;">
						<div class="modal-content">
							<div class="modal-body">
								<div class="dataTables_wrapper">
									<div class="dt-buttons">
										<div>
											<label>고객명:</label> <input type="search" id="pop_customer_name"
												style="width: 250px;" v-model="pop_customer_name">
											<button type="button" class="btn btn-red"
												style="margin-left: 5px;" @click="getList">검색</button>
										</div>
									</div>
								</div>
								<div style="height: 400px; overflow: auto;"
									class="dataTables_wrapper">
									<table class="table table-bordered datatable dataTable">
										<thead style="position: sticky; top: 0px;">
											<tr>
												<th class="center" style="width: 25%;">고객ID</th>											
												<th class="center" style="width: 25%;">고객명</th>
												<th class="center" style="width: 20%;">생년월일</th>
											</tr>
										</thead>
										<tbody>
											<tr v-for="item in dataList" @click="selCust(item)"
												style="cursor: pointer;">
												<td class="center">{{item.customer_id}}</td>
												<td class="center">{{item.customer_name}}</td>
												<td class="center">{{item.cust_id_number}}</td>
											</tr>
										</tbody>
									</table>
									<div class="dataTables_paginate paging_simple_numbers"
										id="div_paginate"></div>
								</div>
							</div>
						</div>
					</div>
				</template>
			</div>
</body>
<script>

var vueapp = new Vue({
    el: "#subFrom",
    data: {
        info: {
            product_id: "",
            product_name: "",
            customer_id: "",
            customer_name: "",
            product_type: ""
        },
    },
    methods: {
        popupProd: function() {
        	console.log("실행되었습니다.")
            $("#pop_prod").modal("show");
        },
        popupCust: function() {
            $("#pop_cust").modal("show");
        },
        getProdInfo: function() {
            // 상품 정보를 가져오는 로직
        },
        getCustInfo: function() {
            // 고객 정보를 가져오는 로직
        },
    },
});


var pop_prod = new Vue({
	el : "#pop_prod",
	data : {
		dataList : [],
		pop_product_name: "",
		pop_product_type: "",
		pop_product_id:""
	},
	methods : {
		getList : function(){
			this.dataList = [];
			var params = {
				product_name : this.pop_product_name,
			}
			console.log(params);
			cf_ajax("/design/productList", params, function(proList){
				pop_prod.dataList = proList;
			});
		},
		selProd : function(product_id){
			
			vueapp.info.product_id = product_id;
			vueapp.getProdInfo();
			
			$("#pop_prod").modal("hide");
		},
	},
});

// var pop_cust = new Vue({
// 	el : "#pop_cust",
// 	data : {
// 		dataList : [],
// 		pop_cust_nm  : "",
// 	},
// 	mounted : function(){
// 		//this.getList();
// 	},
// 	methods : {
// 		getList : function(isInit){
// 			var params = {
// 				cust_nm : this.pop_cust_nm,
// 				cust_evt_ty_cd : "",
// 				dept_nm : "",
// 				wrt_dt : "",
// 			}
// 			cf_ajax("/design/getCustList", params, function(data){
// 				pop_cust.dataList = data;
// 			});
// 		},
// 		selCust : function(item){
// 			vueapp.info.cust_mbl_telno = item.cust_mbl_telno;
// 			vueapp.getCustInfo();
			
// 			$("#pop_cust").modal("hide");
// 		},
// 	},
// });

</script>

<script>
    function numberFormat(num) {
		num = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return num;
	}
    
    function getToday() {
    	const today = new Date(); 
    	const year = today.getFullYear(); 	// 년도
    	const month = (today.getMonth() + 1).toString().padStart(2, '0');  	// 월
    	const day = today.getDate().toString().padStart(2, '0'); 	// 일
    	
    	return year + "-" + month + "-" + day;
    }
    
</script>
</html>