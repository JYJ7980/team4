<%@ page language="java" contentType="text/html; charset=UTF-8"
<<<<<<< HEAD
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer InfoPage</title>
<!-- Vue.js CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
<!-- axios CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false"/>
	<!-- Imported styles on this page -->
	<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">
	
	
</head>
<body class="page-body">

<div class="page-container">

	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>
    <div id="app" style="margin-left: 70px;">
        <h4>고객상담내역 관리</h4>
        <br>
        <div>
            <!-- 고객 정보 테이블 -->
            <h2>
                <span style="font-size: 18px; font-weight: bold; color: black;">${userInfoVO.name}</span>&nbsp;님
                상담내역
            </h2>
            <br>
            <button @click="getAllConsults">전체 내역 조회하기</button>
            <button @click="getAllMyConsults">담당 고객만 조회하기</button>
            <br>
            <!-- 로딩 중일 때 메시지 표시 -->
            <div v-if="isLoading">
                <p>로딩 중...</p>
            </div>
            <!-- 상담 내역이 없을 때 메시지 표시 -->
            <div v-if="!isLoading && filteredConsults.length === 0">
                <p>상담내역이 없습니다</p>
            </div>
            <!-- 상담 내역이 있을 때 테이블 표시 -->
            <table border='1' v-if="!isLoading && filteredConsults.length > 0">
                <tr>
                    <th>등록일</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th>고객명</th>
                    <th>고객 담당자명</th>
                </tr>
                <tr v-for="consult in filteredConsults" :key="consult.con_id">
                    <td>{{ consult.con_date }}</td>
                    <td>{{ consult.consult_title }}</td>
                    <td>{{ consult.consult_context }}</td>
                    <td>{{ consult.customer_name }}</td>
                    <td>{{ consult.representative_name }}</td>
                </tr>
            </table>
        </div>
        <br>
        <button>
            <a href="/system/team4/insertConsult">상담내역 추가하기</a>
        </button>
    </div>
    <script>
      new Vue({
         el: '#app',
         data: {
            consults: [], // 모든 상담 내역을 저장할 배열
            filteredConsults: [], // 필터링된 상담 내역을 저장할 배열
            userId: '${userInfoVO.userId}', // 현재 사용자의 userId를 저장하는 변수
            userName: '${userInfoVO.name}',
            isLoading: false // 로딩 상태를 저장하는 변수
         },
         mounted() {
            // Vue 인스턴스가 마운트된 후에 실행되는 부분
            this.getAllConsults();
         },
         methods: {
            getAllConsults: function() {
               this.isLoading = true; // 로딩 시작
               var params = { user_id: this.userId };
               // AJAX 요청을 보내고 응답 데이터를 consults에 할당
               axios.get('/system/team4/getAllconsult', { params: params })
                  .then(response => {
                     this.consults = response.data;
                     this.filteredConsults = this.consults; // 모든 상담 내역을 먼저 표시
                     this.isLoading = false; // 로딩 완료
                  })
                  .catch(error => {
                     console.error('Error:', error);
                     this.isLoading = false; // 로딩 완료
                  });
            },
            getAllMyConsults: function() {
               this.isLoading = true; // 로딩 시작
               // 현재 사용자의 상담 내역만 필터링하여 보여줍니다.
               this.filteredConsults = this.consults.filter(consult => consult.representative_name === this.userName);
               this.isLoading = false; // 로딩 완료
            }
         }
      });
   </script>
   </div>
</body>
=======
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
				<button @click="window.location.href = '/system/team4/insertConsult'">상담 내역 추가</button>
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
>>>>>>> 23b3514df8f0f58caeda31bdbc964c8281449e23
</html>