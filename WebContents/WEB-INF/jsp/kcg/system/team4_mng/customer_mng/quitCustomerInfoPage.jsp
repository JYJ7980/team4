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

<title>탈퇴고객 조회</title>
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
				<li class="active"><strong>탈퇴고객 조회</strong></li>
			</ol>

			<h2>고객관리 > 탈퇴고객 조회</h2>
			<br />

			<div class="dataTables_wrapper" id="vueapp">
				<template>
					<table class="table table-bordered datatable dataTable"
						id="grid_app">
						<thead>
							<tr class="replace-inputs">
								<th style="width: 10%;" class="center sorting">성명</th>
								<th style="width: 10%;" class="center sorting">주민번호</th>
								<th style="width: 10%;" class="center sorting">담당부서</th>
								<th style="width: 10%;" class="center sorting">담당직원</th>
								<th style="width: 10%;" class="center sorting">휴면해제</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="item in dataList" style="cursor: pointer;">
								<td class="center">{{item.customer_name}}</td>
								<td class="center">{{ maskIdNumber(item.customer_id_number)
									}}</td>
								<td class="center">{{item.dept}}</td>
								<td class="center">{{item.name}}</td>
								<td class="center"><buttun @click="releaseQuitCust(item)" type="button" class="btn">계정 복구</buttun></td>
							</tr>
						</tbody>
					</table>
					<div class="dataTables_paginate paging_simple_numbers"
						id="div_paginate"></div>
				</template>
			</div>

			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp"
				flush="false" />

		</div>
	</div>

</body>
<script>
	var vueapp = new Vue(
			{
				el : "#vueapp",
				data : {
					dataList : [],

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
					maskIdNumber : function(idNumber) {
						// 예시: 문자열로 변환 후 8자리까지만 표시하고 나머지는 '*'로 대체
						if (idNumber && typeof idNumber === 'string') {
							return idNumber.substring(0, 8)
									+ '*'.repeat(idNumber.length - 8);
						} else {
							return '';
						}
					},
					releaseQuitCust: function(item) {
						if (item !== null) {
			                // 확인 메시지 추가
			                if (confirm('해당 고객을 휴면해제합니다')) {
			                    var params = {
			                        customer_id:item.customer_id
			                    };
			                    console.log(params);
			                    axios.post('/system/team4/releaseQuitCust', { params: params })
			                        .then(response => {
			                            if (response.data.status === 'OK') {
			                                alert('고객 계정이 복구처리 되었습니다.\n담당자 변경은 관리자에게 문의하세요');
			                                this.getList(); // 고객 목록을 다시 불러옵니다.
			              
			                            } else {
			                                alert('휴면해제를 실패했습니다.');
			                            }
			                        })
			                        .catch(error => {
			                            console.error('Error:', error);
			                        });
			                }
			            }
			        },
					getList : function(isInit) {

						cv_pagingConfig.func = this.getList;

						if (isInit === true) {
							cv_pagingConfig.pageNo = 1;
						}

						var params = {};
						if (this.all_srch != "Y") {

						}

						cv_sessionStorage.setItem('pagingConfig',
								cv_pagingConfig).setItem('params', params);

						cf_ajax("/system/team4/getQuitCustInfo", params,
								this.getListCB);
					},
					getListCB : function(data) {
						this.dataList = data.list;
						cv_pagingConfig.renderPagenation("system");
					},

				},
			})
</script>
</html>