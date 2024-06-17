<%@ page language="java" contentType="text/html; charset=UTF-8"
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
</head>
<body>

	<div id="vueapp">
		<template>
			<div class="form-group">
				<label for="title">제목</label>
				<div>
					<input type="text" id="title" v-model="notice.title">
				</div>
			</div>

			<div class="form-group">
				<label for="content">내용</label>
				<div>
					<textarea rows="5" id="content" v-model="notice.content"
						placeholder="내용을 입력하세요."></textarea>
				</div>
			</div>

			<div class="form-group">
				<div>
					<button type="button" @click="save">
						저장 <i class="entypo-check"></i>
					</button>
				</div>
			</div>

		</template>
	</div>

	<script>
	var vueapp = new Vue({
		el: "#vueapp",
		data: {
			notice: {
				title: "",
				content: ""
			}
		},
		mounted: function() {
			// 필요한 경우 초기화 작업 수행
		},
		methods: {
			save: function () {
				// 제목과 내용이 비어있는지 검사
				if (!this.notice.title.trim()) {
					alert("제목을 입력하세요.");
					return;
				}
				if (!this.notice.content.trim()) {
					alert("내용을 입력하세요.");
					return;
				}

				// 저장 요청 보내기
				if (!confirm("저장하시겠습니까?")) return;
				
				var params = {
					title: this.notice.title,
					content: this.notice.content
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
			}
		}
	});
	</script>

</body>
</html>
