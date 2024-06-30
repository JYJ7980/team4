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
	margin: 10% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 500px;
	height: 370px;
}

.modal-content-read {
	background-color: #fefefe;
	margin: 10% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 500px;
	height: 350px;
}

.modal-content-change {
	background-color: #fefefe;
	margin: 10% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 500px;
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

.readDiv {
	width: 100%;
	height: 200px;
	border: 1px solid black;
	font-size: 18px;
}

.contentArea {
	width: 100%;
	height: 200px;
	font-size: 18px;
	resize: none;
}

.orange_btn{
    border-radius:30px;
    line-height:0;
    width:120px;
    height:30px;
    border:2px solid #70C653;
    color:#FFFFFF;
    background:#0EA06F;
    margin-bottom: -10px;
}

.btn {
	margin-right: 10px;
	width: 50px;
	height: 30px;
	border-radius: 5px;
	box-shadow: $shadow;
	cursor: pointer;
	transition: .3s ease; & __primary { grid-column : 1/ 2;
	grid-row: 4/5; background : #FDEE87; box-shadow : inset .2rem .2rem
	1rem #E4EBF5, inset -.2rem -.2rem 1rem #9baacf, $ shadow; width : 10rem;
	height : 3rem; border-radius : 1rem; box-shadow : $ shadow; cursor :
	pointer; transition : .3s ease; & __primary { grid-column : 1/ 2;
	grid-row: 4/5;
	background: #6d5dfc;
	box-shadow: inset .2rem .2rem 1rem #8abdff, inset -.2rem -.2rem 1rem
		#5b0eeb,$shadow;
	color: #E4EBF5;
	background: #FDEE87;
	box-shadow: inset .2rem .2rem 1rem #E4EBF5, inset -.2rem -.2rem 1rem
		#9baacf,$shadow;
	width: 10rem;
	height: 3rem;
	border-radius: 1rem;
	box-shadow: $ shadow;
	cursor: pointer;
	transition: .3s ease;
	&:
	hover
	{
	color
	:
	#FFFFFF;
}

&
:active {
	box-shadow: inset .2rem .2rem 1rem #5b0eeb, inset -.2rem -.2rem 1rem
		#8abdff;
}

}
}
}
</style>
<title>공지사항 조회</title>

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
				<li class="active"><strong>공지사항 조회</strong></li>
			</ol>

			<h2>활동관리 > 공지사항 조회</h2>
			<br />

			<div class="dataTables_wrapper" id="vueapp"
				style="border-style: none;">
				<template>



					<c:if test="${userInfoVO.jikgubCd == '1'}">
						<div
							style="align-items: flex-start; display: flex; justify-content: flex-start;">
							<button @click="showInsertForm" class="orange_btn">공지사항 추가</button>
						</div>
					</c:if>
					<br>
					<table class="table table-bordered datatable dataTable"
						id="grid_app"
						style="border-top-left-radius: 20px; border-top-right-radius: 20px;">
						<thead>
							<tr class="replace-inputs">
								<th
									style="width: 20px; background-color: #3EAB6F; color: white; border-top-left-radius: 20px;"
									class="center sorting">최초 등록 일자</th>
								<th
									style="width: 20px; background-color: #3EAB6F; color: white;"
									class="center sorting">최종 수정 일자</th>
								<th
									style="width: 10px; background-color: #3EAB6F; color: white;"
									class="center sorting">등록번호</th>
								<th
									style="width: 200px; background-color: #3EAB6F; color: white;"
									class="center sorting">제목</th>
								
									<th
										style="width: 10%; background-color: #3EAB6F; color: white; border-top-right-radius: 20px;"
										class="center sorting">비고</th>
								
							</tr>
						</thead>
						<tbody>
							<tr v-for="notice in dataList" :key="notice.notice_id">
								<td align="center">{{ notice.regis_date }}</td>
								<td align="center">{{ notice.cor_date }}</td>
								<td align="center">{{ notice.notice_id }}</td>
								<td @click="readNoticeOpen(notice)">{{ notice.notice_title
									}}</td>
								<c:if test="${userInfoVO.jikgubCd == '1'}">
									<td>
										<button @click="openEditModal(notice)" class="btn">수정</button>
										<button @click="deleteNotice(notice.notice_id)" class="btn">삭제</button>
									</td>
								</c:if>
								<c:if test="${userInfoVO.jikgubCd != '1'}">
								<td style="text-align: center;">
								-
								</td>
								</c:if>
							</tr>
						</tbody>
					</table>

					<div class="dataTables_paginate paging_simple_numbers"
						id="div_paginate" style="background-color: white;"></div>

					<div v-if="showModal" class="modal">
						<div class="modal-content-change">
							<span class="close" @click="closeEditModal">&times;</span>
							<h2>공지사항 수정</h2>
							<div class="form-group">
								<label for="title">제목</label>
								<div>
									<input type="text" id="title"
										v-model="selectedNotice.notice_title" style="width: 100%;">
								</div>
							</div>
							<div class="form-group">
								<label for="content">내용</label>
								<div>
									<textarea rows="5" id="content"
										v-model="selectedNotice.notice_content"
										placeholder="내용을 입력하세요." class="contentArea"></textarea>
								</div>
							</div>
							<div class="form-group"
								style="justify-content: center; display: flex;">
								<button type="button" @click="updateNotice"
									style="margin: 10px;">
									저장 <i class="entypo-check"></i>
								</button>
								<button type="button"
									@click="deleteNotice(selectedNotice.notice_id)"
									style="margin: 10px;">
									삭제 <i class="entypo-trash"></i>
								</button>
							</div>
						</div>
					</div>


					<div v-if="insertForm" class="modal">
						<div class="modal-content">
							<span class="close" @click="closeInsertForm">&times;</span>
							<div>
								<label for="insertTitle">제목 : </label>
								<div>
									<input type="text" id="insertNotice.insertTitle"
										v-model="insertNotice.insertTitle" style="width: 100%;">
								</div>
							</div>
							<div>
								<label for="insertContent">내용 : </label>
							</div>
							<div>
								<textarea rows="5" id="insertNotice.insertContent"
									v-model="insertNotice.insertContent" placeholder="내용을 입력하세요."
									class="contentArea"></textarea>
							</div>
							<div
								style="align-items: center; justify-content: center; display: flex;">
								<button type="button" @click="save">저장</button>
							</div>
						</div>
					</div>

					<div v-if="readNotice" class="modal">
						<div class="modal-content-read">
							<span class="close" @click="closeReadNotice">&times;</span>

							<div class="form-group">

								<div>
									<h2>{{selectedNotice.notice_title}}</h2>
								</div>
							</div>
							<div class="form-group">
								<label for="content">내용</label>
								<div>
									<textarea class="contentArea" disabled="disabled">{{selectedNotice.notice_content}}</textarea>
								</div>
							</div>

						</div>
					</div>
				</template>

			</div>


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
        	delete_id:"",
        	insertForm: false,
        	readNotice: false,
			insertNotice: {
				insertTitle:"",
				insertContent:""
			},
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
        	readNoticeOpen(notice) {
        		this.selectedNotice = Object.assign({}, notice);
        		this.readNotice = true;
        	},
        	closeReadNotice() {
        		this.readNotice = false;
        		this.selectedNotice = null;
        	},
        	closeEditModal() {
        		this.showModal = false;
        		this.selectedNotice = null;
        	},
        	
        	showInsertForm() {
        		this.insertForm = true;
        	},
        	closeInsertForm() {
        		this.insertForm = false;
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
    		},
    		
    		save: function () {
				// 제목과 내용이 비어있는지 검사
				if (!this.insertNotice.insertTitle.trim()) {
					alert("제목을 입력하세요.");
					return;
				}
				if (!this.insertNotice.insertContent.trim()) {
					alert("내용을 입력하세요.");
					return;
				}

				// 저장 요청 보내기
				if (!confirm("저장하시겠습니까?")) return;
				
				var params = {
					title: this.insertNotice.insertTitle,
					content: this.insertNotice.insertContent
				};
				
				console.log(params);
				axios.post("/system/team4/notice/save", {params:params})
					.then(response => {
						if (response.data.status === "OK") {
							alert("저장되었습니다.");
							window.location.href = '/system/team4/notice/'; // 저장 후 목록으로 이동
						} else {
							alert("저장 실패: " + response.data.message);
						}
					})
					.catch(error => {
						alert("오류 발생: " + error);
					});
			},

		},
	})
</script>
</html>