<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
</head>
<body>
	<div class="flex-column flex-gap-10" id="vueapp">
		<div class="form-group flex-40">
			<label class="form-control">상품명:</label> <input class="form-control"
				v-model="product_name" value="" />
		</div>
		<div class="form-group flex-40">
			<label class="form-control">가입대상:</label> <select class="form-select"
				v-model="possible_member">
				<option value="">전체</option>
				<option value="일반개인">일반개인</option>
				<option value="청년">청년</option>
			</select>
		</div>
		<div v-if="key">
			<button type="button"
				class="btn btn-orange btn-icon icon-left btn-small" 
				@click="cf_movePage('/system/team4/product/dtl')">
				등록 <i class="entypo-plus"></i>
			</button>
		</div>
		<div
			class="flex-wrap flex-33 flex flex-center flex-gap-10 flex-padding-10">
			<div class="form-group" style="width: 45%;">
				<button type="button"
					class="btn btn-blue btn-icon icon-left form-control "
					@click="getListCond(true)">
					조건조회 <i class="entypo-search"></i>
				</button>
			</div>
		</div>
		<br>
		<div
			class="flex-wrap flex-33 flex flex-center flex-gap-10 flex-padding-10">
			<div class="form-group" style="width: 45%;">
				<button class="btn btn-blue btn-icon icon-left form-control"
					@click="getListAll">
					{{message}}<i class="entypo-search"></i>
				</button>
			</div>
		</div>
		<table class="table table-bordered datatable dataTable" id="grid_app"
			style="border: 1px solid #999999;">
			<thead>
				<tr>
					<th>상품명</th>
					<th>상품유형</th>
					<th>가입대상</th>
					<th>최소가입금액</th>
					<th>최대가입금액</th>
					<th>최소적용이율</th>
					<th>최대적용이율</th>
					<th>이자과세</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="product in products" style="cursor: pointer;">
					<td @click="gotoDtl(product.product_id)">{{product.product_name}}</td>
					<td @click="gotoDtl(product.product_id)">{{product.product_type}}</td>
					<td @click="gotoDtl(product.product_id)">{{product.possible_member}}</td>
					<td @click="gotoDtl(product.product_id)">{{product.lowest_money}}</td>
					<td @click="gotoDtl(product.product_id)">{{product.highest_money}}</td>
					<td @click="gotoDtl(product.product_id)">{{product.lowest_rate}}</td>
					<td @click="gotoDtl(product.product_id)">{{product.highest_rate}}</td>
					<td @click="gotoDtl(product.product_id)">{{product.taxation}}</td>
				</tr>
			</tbody>
		</table>
		<div class="dataTables_paginate paging_simple_numbers"
			id="div_paginate"></div>
	</div>
	<script>
		new Vue(
				{
					el : '#vueapp',
					data : {
						products : [],
						product_name : "",
						possible_member : "",
						all_srch : "N",
						message : '전체조회',
						jikgub_nm: '${userInfoVO.jikgubNm}',
						key : "",
					},
					mounted : function() {
						var fromDtl = cf_getUrlParam("fromDtl");
						var pagingConfig = cv_sessionStorage
								.getItem("pagingConfig");
						if(this.jikgub_nm==="이사"){
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
					},
				});
	</script>
</body>


</html>