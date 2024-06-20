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

<title>상담내역 조회</title>
</head>
<body class="page-body">

	<div class="page-container">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />

		<div class="main-content">

			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
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

			<div class="dataTables_wrapper" id="vueapp">
				<template>
					<table class="table table-bordered datatable dataTable"
						id="grid_app">
						<thead>
							<tr class="replace-inputs">
								<th style="width: 10%;" class="center sorting">등록일</th>
								<th style="width: 10%;" class="center sorting">제목</th>
								<th style="width: 10%;" class="center sorting">내용</th>
								<th style="width: 10%;" class="center sorting">고객명</th>
								<th style="width: 10%;" class="center sorting">고객 담당자명</th>
								<th style="width: 10%;" class="center sorting">고객 담당부서</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="item in dataList" style="cursor: pointer;">
								<td class="center">{{item.con_date}}</td>
								<td class="center">{{item.consult_title}}</td>
								<td class="center">{{item.consult_context}}</td>
								<td class="center">{{item.customer_name}}</td>
								<td class="center">{{item.representative_name}}</td>
								<td class="center">{{item.dept}}</td>


							</tr>
						</tbody>
					</table>
					<div class="dataTables_paginate paging_simple_numbers"
						id="div_paginate"></div>
				</template>
				<br>
				<button @click="filterList">담당 고객만 조회</button>
				<button @click="getAllList">전체 상담내역 조회</button>
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

		},
		mounted () {
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
			}

		},
	})
</script>
</html>