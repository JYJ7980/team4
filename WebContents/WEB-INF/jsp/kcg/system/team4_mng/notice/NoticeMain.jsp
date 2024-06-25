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
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
	padding-top: 60px;
}

.modal-content {
	background-color: #fefefe;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 50%;
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
<title>공지사항 조회</title>

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
				<li class="active"><strong>공지사항 조회</strong></li>
			</ol>

			<h2>활동관리 > 공지사항 조회</h2>
			<br />
			
			<div class="dataTables_wrapper" id="vueapp">
				<template>
				<button @click="window.location.href = 'insert'">공지사항
				추가</button><br>
					<table class="table table-bordered datatable dataTable"
						id="grid_app">
						<thead>
							<tr class="replace-inputs">
								<th style="width: 10%;" class="center sorting">등록일자</th>
								<th style="width: 10%;" class="center sorting">등록번호</th>
								<th style="width: 10%;" class="center sorting">제목</th>
								<th style="width: 10%;" class="center sorting">비고</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="notice in dataList" :key="notice.notice_id">
								<td>{{ notice.regis_date }}</td>
								<td>{{ notice.notice_id }}</td>
								<td>{{ notice.notice_title }}</td>
								<td>
									<button @click="openEditModal(notice)">수정</button>
									<button @click="deleteNotice(notice.notice_id)">삭제</button>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="dataTables_paginate paging_simple_numbers"
						id="div_paginate"></div>

					<div v-if="showModal" class="modal">
						<div class="modal-content">
							<span class="close" @click="closeEditModal">&times;</span>
							<h2>공지사항 수정</h2>
							<div class="form-group">
								<label for="title">제목</label>
								<div>
									<input type="text" id="title"
										v-model="selectedNotice.notice_title">
								</div>
							</div>
							<div class="form-group">
								<label for="content">내용</label>
								<div>
									<textarea rows="5" id="content"
										v-model="selectedNotice.notice_content"
										placeholder="내용을 입력하세요."></textarea>
								</div>
							</div>
							<div class="form-group">
								<button type="button" @click="updateNotice">
									저장 <i class="entypo-check"></i>
								</button>
								<button type="button"
									@click="deleteNotice(selectedNotice.notice_id)">
									삭제 <i class="entypo-check"></i>
								</button>
							</div>
						</div>
					</div>
				</template>

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
        	showModal: false,
        	selectedNotice: null,
        	update_title:"",
        	update_content:"",
        	delete_id:""
			

		},
		mounted() {
			this.getAllList();
			
		},
		methods : {

			getList : function(isInit) {

				cv_pagingConfig.func = this.getList;

				if (isInit === true) {
					cv_pagingConfig.pageNo = 1;
				}

				var params = {};
				if (this.all_srch != "Y") {

				}

				cv_sessionStorage.setItem('pagingConfig', cv_pagingConfig)
						.setItem('params', params);

				cf_ajax("/system/team4/notice/getAllNotice", params,
						this.getListCB);
			},
			getListCB : function(data) {
				this.dataList = data.list;
				cv_pagingConfig.renderPagenation("system");
			},
			openEditModal(notice) {
        		this.selectedNotice = Object.assign({}, notice);
        		this.showModal = true;
        	},
        	closeEditModal() {
        		this.showModal = false;
        		this.selectedNotice = null;
        	},
        	updateNotice : function() {
        		if (!this.selectedNotice.notice_title.trim()) {
					alert("제목을 입력하세요.");
					return;
				}
				if (!this.selectedNotice.notice_content.trim()) {
					alert("내용을 입력하세요.");
					return;
				}
				
				var params ={
						
						update_id : this.selectedNotice.notice_id,
						update_title : this.selectedNotice.notice_title,
						update_content : this.selectedNotice.notice_content
				};
				
				axios.post('/system/team4/notice/update',{params:params} )
					.then(response => {
						if (response.data.status === "OK") {
							alert("저장되었습니다.");
							this.getAllList();
							this.closeEditModal();
						} else {
							alert("저장 실패: " + response.data.message);
						}
					})
					.catch(error => {
						alert("오류 발생: " + error);
					});
        	},
        	deleteNotice(notice_id) {
        		if (!confirm('정말로 삭제하시겠습니까?')) return;
        		var params = {
        				delete_id: notice_id
        		};
        		
				console.log(params);
        		axios.post('/system/team4/notice/delete', { params: params })
        		.then(response => {
                    if (response.data.status === 'OK') {
                        alert('삭제되었습니다.');
                        this.getAllList();
                        this.closeEditModal();
                    } else {
                        alert('삭제 실패: ' + response.data.message);
                    }
                })
                .catch(error => {
                    alert('오류 발생: ' + error);
                });
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