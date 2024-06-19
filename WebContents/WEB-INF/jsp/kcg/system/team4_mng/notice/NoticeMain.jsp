<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false"/>
	<!-- Imported styles on this page -->
	<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">
<meta charset="UTF-8">
<title>Customer InfoPage</title>
<!-- Vue.js CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
<!-- axios CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style>
.has-text-centered {text-align: center}
        .has-text-prev { background-color : #ECEFF1   }
        .has-text-next { background-color : #ECEFF1 }
        .has-text-primary { background-color : #598987 }
    .modal {
        display: block;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0,0,0);
        background-color: rgba(0,0,0,0.4);
        padding-top: 60px;
    }
    .modal-content {
        background-color: #fefefe;
        margin: 5% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
    }
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }
    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
</style>
</head>
<body class="page-body">

<div class="page-container">

	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>

	<div class="main-content">

	<div id="app">
		<div>
			<h2>공지사항</h2>
			<button type="button">
				<a href="/system/team4/notice/insert">추가</a>
			</button>
			<table border='1'>
				<tr>
					<th>등록일자</th>
					<th>등록번호</th>
					<th>제목</th>
					<th>비고</th>
				</tr>
				<tr v-for="notice in notices" :key="notice.notice_id">
					<td>{{ notice.regis_date }}</td>
					<td>{{ notice.notice_id }}</td>
					<td>{{ notice.notice_title }}</td>
					<td>
                        <button @click="openEditModal(notice)">수정</button>
                        <button @click="deleteNotice(notice.notice_id)">삭제</button>
                    </td>
				</tr>
			</table>
		</div>

		<!-- Edit Notice Modal -->
		<div v-if="showModal" class="modal">
			<div class="modal-content">
				<span class="close" @click="closeEditModal">&times;</span>
				<h2>공지사항 수정</h2>
				<div class="form-group">
					<label for="title">제목</label>
					<div>
						<input type="text" id="title" v-model="selectedNotice.notice_title">
					</div>
				</div>
				<div class="form-group">
					<label for="content">내용</label>
					<div>
						<textarea rows="5" id="content" v-model="selectedNotice.notice_content" placeholder="내용을 입력하세요."></textarea>
					</div>
				</div>
				<div class="form-group">
					<button type="button" @click="updateNotice">저장 <i class="entypo-check"></i></button>
					<button type="button" @click="deleteNotice(selectedNotice.notice_id)">삭제 <i class="entypo-check"></i></button>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
	<script>
    new Vue({
        el: '#app',
        data: {
        	notices: [],
        	showModal: false,
        	selectedNotice: null,
        	update_title:"",
        	update_content:"",
        	delete_id:""
        },
        mounted() {
            this.getNoticeList();
        },
        methods: {
        	getNoticeList() {
                axios.get('/system/team4/notice/show')
                    .then(response => {
                        this.notices = response.data;
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
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
							this.getNoticeList();
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
                        this.getNoticeList();
                        this.closeEditModal();
                    } else {
                        alert('삭제 실패: ' + response.data.message);
                    }
                })
                .catch(error => {
                    alert('오류 발생: ' + error);
                });
        	}
        }
    });
    </script>

</body>
</html>
