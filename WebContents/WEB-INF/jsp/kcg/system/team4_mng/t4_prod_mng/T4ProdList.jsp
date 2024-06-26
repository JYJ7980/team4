<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<!-- Imported styles on this page -->
<link rel="stylesheet" href="/static_resources/team4/css/datatables.css">
<link rel="stylesheet"
	href="/static_resources/team4/css/prodlist.css?after">
<link rel="stylesheet"
	href="/static_resources/team4/css/select2-bootstrap.css">
<link rel="stylesheet" href="/static_resources/team4/css/select2.css">
<style type="text/css">
.search-box {
	display: flex;
	width: 1000px;
	height: 120px;
	flex-flow: row wrap;
	margin: 0 auto;
	border: 1px solid #999999;
	justify-content: space-between;
}

.search-item {
	display: flex;
	flex: 1 1 40%;
	flex-flow: row wrap;
	align-items: center;
}

.label-box {
	display: flex;
	flex-basis: 20%;
	height: 30px;
	justify-content: flex-end;
	align-items: center;
	font-weight: bold;
	margin: 10px;
}

.select-box {
	display: flex;
	flex-basis: 65%;
	height: 30px;
	justify-content: flex-start;
	align-items: center;
	margin: 10px;
}

.input-box {
	display: flex;
	flex-basis: 65%;
	height: 30px;
	justify-content: flex-start;
	align-items: center;
	margin: 10px;
}

.button {
	display: flex;
	justify-content: center;
	justify-items: center;
	flex: 1 1 calc(40% - 6px);
	height: 30px;
	margin: 10px;
}
</style>
<title>상품목록조회</title>
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
				<li class="active"><strong>상품목록조회</strong></li>
			</ol>
			<h2>상품관리 > 상품목록조회</h2>
			<br />

			<div class="flex-column flex-gap-10 " id="vueapp">
				<template>
					<div class="search-box">
						<div class="search-item">
							<label class="label-box">가입대상:</label> <select class="select-box"
								v-model="possible_member">
								<option value="">전체</option>
								<option value="일반개인">일반개인</option>
								<option value="청년">청년</option>
								<option value="장애인">장애인</option>
							</select>
						</div>
						<div class="search-item">
							<label class="label-box">상품유형:</label> <select class="select-box"
								v-model="product_type">
								<option value="">전체</option>
								<option value="예금">예금</option>
								<option value="적금">적금</option>
								<option value="대출">대출</option>
								<option value="목돈마련">목돈마련</option>
							</select>
						</div>
						<div class="search-item">
							<label class="label-box">상품명:</label> <input class="input-box"
								v-model="product_name" value="" />
						</div>
						<div class="search-item">
							<div class="flex flex-center flex-50">
								<button type="button"
									class="btn btn-blue btn-icon icon-left button"
									@click="getListCond(true)">
									조건검색 <i class="entypo-search"></i>
								</button>
							</div>
							<div class="flex flex-center flex-50">
								<button type="button"
									class="btn btn-blue btn-icon icon-left button"
									@click="getListAll">
									전체검색 <i class="entypo-search"></i>
								</button>
							</div>
						</div>
					</div>
			</div>

			<div class="flex flex-100 flex-padding-10 flex-gap-10"
				style="justify-content: flex-end" v-if="key">
				<button type="button"
					class="btn btn-orange btn-icon icon-left btn-small"
					@click="cf_movePage('/system/team4/product/dtl')">
					등록 <i class="entypo-plus"></i>
				</button>
			</div>
			<table class="table table-bordered datatable dataTable" id="grid_app"
				style="border: 1px solid #999999;">
				<thead>
					<tr class="replace_inputs">
						<th class="center sorting" @click="sortList(event.target)"
							sort_target="product_name">상품명</th>
						<th class="center sorting" @click="sortList(event.target)"
							sort_target="product_type">상품유형</th>
						<th class="center sorting" @click="sortList(event.target)"
							sort_target="possible_member">가입대상</th>
						<th class="center sorting" @click="sortList(event.target)"
							sort_target="lowest_money">최소가입금액</th>
						<th class="center sorting" @click="sortList(event.target)"
							sort_target="highest_money">최대가입금액</th>
						<th class="center sorting" @click="sortList(event.target)"
							sort_target="lowest_date">최소적용이율</th>
						<th class="center sorting" @click="sortList(event.target)"
							sort_target="highest_date">최대적용이율</th>
						<th class="center sorting" @click="sortList(event.target)"
							sort_target="pay_type">납입주기</th>
						<th class="center sorting" @click="sortList(event.target)"
							sort_target="taxation">이자과세</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="product in products" style="cursor: pointer;">
						<td class="left" @click="gotoDtl(product.product_id)">{{product.product_name}}</td>
						<td cless="center" @click="gotoDtl(product.product_id)"
							style="text-align: center;">{{product.product_type}}</td>
						<td cless="center" @click="gotoDtl(product.product_id)"
							style="text-align: center;">{{product.possible_member}}</td>
						<td cless="right" @click="gotoDtl(product.product_id)"
							style="text-align: right;">{{product.lowest_money}}원</td>
						<td cless="right" @click="gotoDtl(product.product_id)"
							style="text-align: right;">{{product.highest_money}}원</td>
						<td cless="right" @click="gotoDtl(product.product_id)"
							style="text-align: right;">{{product.lowest_rate}}%</td>
						<td cless="right" @click="gotoDtl(product.product_id)"
							style="text-align: right;">{{product.highest_rate}}%</td>
						<td cless="center" @click="gotoDtl(product.product_id)"
							style="text-align: center;">{{product.pay_type}}</td>
						<td cless="center" @click="gotoDtl(product.product_id)"
							style="text-align: center;">{{product.taxation}}</td>
					</tr>
				</tbody>
			</table>
			<div class="dataTables_wrapper">
				<div class="dataTables_paginate paging_simple_numbers"
					id="div_paginate"></div>
			</div>
			</template>
		</div>
	</div>
	<script>
		new Vue(
				{
					el : '#vueapp',
					data : {
						products : [],
						product_name : "",
						possible_member : "",
						product_type : "",
						all_srch : "N",
						jikgub_nm : '${userInfoVO.jikgubNm}',
						key : "",
					},
					mounted : function() {
						var fromDtl = cf_getUrlParam("fromDtl");
						var pagingConfig = cv_sessionStorage
								.getItem("pagingConfig");
						if (this.jikgub_nm === "이사") {
							this.key = true;
						} else {
							this.key = false;
						}
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
						getListAll : function(isInit) {
							this.all_srch = "Y";
							this.getList(isInit);
						},
						getListCond : function(isInit) {
							this.all_srch = "N";
							this.getList(isInit);
						},
						getList : function(isInit) {
							cv_pagingConfig.func = this.getList;
							if (isInit === true) {
								cv_pagingConfig.pageNo = 1;
							}
							var params = {}
							if (this.all_srch != "Y") {
								params = {
									product_name : this.product_name,
									possible_member : this.possible_member,
									product_type : this.product_type,
								}
							}
							cv_sessionStorage.setItem('pagingConfig',
									cv_pagingConfig).setItem('params', params);

							cf_ajax("/system/team4/product/getListPaging",
									params, this.getListCB);
						},
						getListCB : function(data) {
							this.products = data.list;
							for (var i = 0; i < this.products.length; i++) {
								this.products[i].lowest_money = this.products[i].lowest_money
										.numformat();
								this.products[i].highest_money = this.products[i].highest_money
										.numformat();
							}
							cv_pagingConfig.renderPagenation("system");
						},
						gotoDtl : function(product_id) {
							var params = {
								product_id : cf_defaultIfEmpty(product_id, ""),
							}
							cf_movePage("/system/team4/product/dtl", params);
						},
						sortList : function(obj) {
							cf_setSortConf(obj, "product_name");
							this.getList();
						},
					},
				});
	</script>
	</div>
</body>


</html>