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
	<h2>상품정보관리</h2>
	<br>
	<div class="flex-column flex-gap-10" id="vueapp"
		style="display: flex; justify-items: center;">
		<div class="panel-body flex-100">
			<div class="left-panel flex-66">
				<div class="form-group">
					<label for="product_name" class="fix-width-33">상품명:</label> <input
						type="text" class="form-control" id="product_name"
						v-model="info.product_name"
						:disabled="info.product_id!=''&&info.product_id!=null">
				</div>
				<div class="form-group">
					<label for="product_id" class="fix-width-33">상품코드:</label> <input
						type="text" class="form-control" id="product_id"
						v-model="info.product_id"
						:disabled="info.product_id!=''&&info.product_id!=null">
				</div>
				<div class="form-group">
					<label for="product_type" class="fix-width-33">상품유형:</label> <select
						class="form-control" id="product_type" v-model="info.product_type"
						:disabled="info.product_id!=''&&info.product_id!=null">
						<option value="예금">예금</option>
						<option value="적금">적금</option>
						<option value="대출">대출</option>
					</select>
				</div>
				<div class="form-group">
					<label for="possible_member" class="fix-width-33">가입대상:</label> <select
						class="form-control" id="possible_member"
						v-model="info.possible_member"
						:disabled="info.product_id!=''&&info.product_id!=null">
						<option value="일반개인">일반개인</option>
						<option value="청년">청년우대</option>
						<option value="장애인">장애인우대</option>
					</select>
				</div>
				<div class="form-group">
					<label for="lowest_money" class="fix-width-33">가입금액:</label>
					<div class="form-control">
						<label>(최소)</label> <input type="text" class="form-control"
							id="lowest_money" v-model="info.lowest_money"
							:disabled="info.product_id!=''&&info.product_id!=null"> <label>원
							~ (최대)</label> <input type="text" class="form-control" id="highest_money"
							v-model="info.highest_money"
							:disabled="info.product_id!=''&&info.product_id!=null"> <label>원</label>
					</div>
				</div>
				<div class="form-group">
					<label for="lowest_rate" class="fix-width-33">적용이율:</label>
					<div class="form-control">
						<input type="number" id="lowest_rate" v-model="info.lowest_rate"
							:disabled="info.product_id!=''&&info.product_id!=null"> <label>%
							~</label> <input type="number" id="highest_rate"
							v-model="info.highest_rate"
							:disabled="info.product_id!=''&&info.product_id!=null"> <label>%</label>
					</div>
				</div>
				<div class="form-group">
					<label for="lowest_date" class="fix-width-33">적용기간:</label>
					<div class="form-control">
						<input type="number" id="lowest_date" v-model="info.lowest_date"
							:disabled="info.product_id!=''&&info.product_id!=null"> <label>개월
							~</label> <input type="number" id="highest_date"
							v-model="info.highest_date"
							:disabled="info.product_id!=''&&info.product_id!=null"> <label>개월</label>
					</div>
				</div>
				<div class="form-group">
					<label for="taxation" class="fix-width-33">과세구분:</label> <select
						class="form-control" id="taxation" v-model="info.taxation"
						:disabled="info.product_id!=''&&info.product_id!=null">
						<option value="일반과세">일반과세</option>
						<option value="세금우대">세금우대</option>
						<option value="비과세">비과세</option>
					</select>
				</div>
				<div class="form-group">
					<label for="product_sale_start_date" class="fix-width-33">판매기간:</label>
					<div class="form-control">
						<input type="date" id="product_sale_start_date"
							v-model="info.product_sale_start_date"> <label> ~</label>
						<input type="date" id="product_sale_end_date"
							v-model="info.product_sale_end_date">
					</div>
				</div>
				<div class="form-group">
					<label for="product_status" class="fix-width-33">판매상태:</label> <select
						class="form-control" id="product_status"
						v-model="info.product_status">
						<option value="0">정상(판매)</option>
						<option value="1">판매준비</option>
						<option value="2">판매인가</option>
						<option value="9">판매중지</option>
					</select>
				</div>
				<div class="form-group">
					<div>
						<button type="button" class="btn btn-green btn-icon btn-small"
							@click="save">
							저장 <i class="entypo-check"></i>
						</button>
						<button type="button" id="btn_delete"
							class="btn btn-red btn-icon btn-small" @click="delInfo">
							삭제 <i class="entypo-trash"></i>
						</button>
						<button type="button" class="btn btn-blue btn-icon btn-small"
							@click="gotoList">
							목록 <i class="entypo-list"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		new Vue({
			el : "#vueapp",
			data : {
				info : {
					product_id : "${product_id}",
					save_mode : "insert",
				},
			},

			mounted : function() {
				if (!cf_isEmpty(this.info.product_id)) {
					this.getInfo();
				}
			},

			methods : {
				getInfo : function() {
					cf_ajax("/system/team4/product/getInfo", this.info,
							this.getInfoCB);
				},
				getInfoCB : function(data) {
					this.info = data;
					this.info.save_mode = "update";
				},
				save : function() {
					if (cf_isEmpty(this.info.product_name)) {
						alert("상품명을 입력하세요.");
						return;
					} else if (cf_isEmpty(this.info.product_id)) {
						alert("상품코드를 입력하세요.");
						return;
					} else if (cf_isEmpty(this.info.product_type)) {
						alert("상품유형을 선택하세요.");
						return;
					}

					if (!confirm("저장하시겠습니까?"))
						return;
					cf_ajax("/system/team4/product/save", this.info,
							this.saveCB);
				},
				saveCB : function(data) {
					alert("저장되었습니다.");
					this.info.product_id = data.product_id;
					this.gotoList();
				},
				delInfo : function() {
					if (!confirm("삭제하시겠습니까?"))
						return;
					cf_ajax("/system/team4/product/delete", this.info,
							this.delInfoCB);
				},
				delInfoCB : function() {
					this.gotoList();
				},
				gotoList : function() {
					cf_movePage('/system/team4/product/list');
				},
			}
		})
	</script>
</body>
</html>