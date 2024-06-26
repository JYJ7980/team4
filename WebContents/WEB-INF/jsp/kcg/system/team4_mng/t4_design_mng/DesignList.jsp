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
	href="/static_resources/team4/css/datatables/datatables.css">
<link rel="stylesheet"
	href="/static_resources/team4/css/select2/select2-bootstrap.css">
<link rel="stylesheet"
	href="/static_resources/team4/css/select2/select2.css">
<link rel="stylesheet"
	href="/static_resources/team4/css/prodlist.css?after">
<style type="text/css">
.jh-div {
	display: flex;
	align-items: center;
	margin-top: 10px;
	margin-bottom: 10px;
}

.box {
	display: flex;
	width: 1000px;
	flex-flow: row wrap;
	margin: 0 auto;
}

.search-box {
	display: flex;
	width: 80%;
	height: 120px;
	flex-flow: row wrap;
	border: 1px solid #999999;
	justify-content: space-between;
}

.button-box {
	display: flex;
	width: 20%;
	height: 120px;
	flex-flow: row wrap;
	border: 1px solid #999999;
	justify-content: space-between;
}

.search-item {
	position: relative;
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
	align-content: center;
	align-items: center;
	flex: 1 1 calc(40% - 6px);
	height: 30px;
	margin: 10px;
	flex: 1 1 calc(40% - 6px);
}

.date-button {
	display: flex;
	position: absolute;
	right: 8%;
}

.modal-content1 {
	position: relative;
	dispaly: flex;
	width: 1000px;
	margin: 0 auto;
	background-color: #fff;
	border: 1px solid #999;
	border: 1px solid rgba(0, 0, 0, 0.2);
	border-radius: 3px;
	-webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
	box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
	background-clip: padding-box;
	outline: 0;
	background-color: #fff;
	margin: 0 auto;
	background-color: #fff;
}

.form-group1 {
	position: relative;
	display: flex;
	align-items: center;
	justify-content: flex-start;
	width: 100%;
	padding-top: 8px;
}

.form-group1 label {
	font-weight: bold;
	text-align: right;
}

.label-box1 {
	display: flex;
	width: 30%;
	justify-content: flex-end;
	align-items: center;
}

.label-box2 {
	display: flex;
	width: 20%;
	justify-content: flex-end;
	align-items: center;
}

.input-box {
	position: relative;
	display: flex;
	width: 60%;
}

.input-box input {
	width: 100%;
	height: 30px;
	justify-content: flex-start;
	margin-left: 10px;
	align-items: center;
	border: 1px solid rgb(212, 212, 212);
	align-items: center;
}

.label-position2 {
	position: absolute;
	right: 5px;
}

</style>
<title>설계조회</title>
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
				<li><a href="#none" onclick="cf_movePage('/system')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>설계조회</strong></li>
			</ol>

			<h2>설계조회</h2>
			<br />

			<div class="flex-column flex-gap-10 " id="vueapp">
				<template>
					<div class="box">
						<div class="search-box">
							<div class="search-item">
								<label class="label-box">고객명:</label> <input class="input-box"
									v-model="customer_name" value="" />
							</div>
							<div class="search-item">
								<label class="label-box">상품명:</label> <input class="input-box"
									v-model="user_id" value="" />
							</div>
							<div class="search-item">
								<label class="label-box">가입날짜:</label> <input type="text"
									class="input-box datepicker2" v-model="design_date"
									data-format="yyyy-mm-dd">
								<div class="date-button">
									<button type="button"
										class="btn btn-primary btn-sm datepicker2" id="wrdtbtn"
										style="float: left;">
										<i class="fa fa-calendar"></i>
									</button>
								</div>
							</div>
							<div class="search-item">
								<label class="label-box">관리자명:</label> <input class="input-box"
									v-model="my_name" readonly />
							</div>
						</div>
						<div class="button-box">
							<div class="flex flex-center flex-80">
								<button type="button"
									class="btn btn-blue btn-icon icon-left button"
									@click="getListCond(true)">
									조건검색 <i class="entypo-search"></i>
								</button>
							</div>
							<div class="flex flex-center flex-80">
								<button type="button"
									class="btn btn-blue btn-icon icon-left button"
									@click="getListAll(true)">
									전체검색 <i class="entypo-search"></i>
								</button>
							</div>
						</div>

					</div>
			</div>
			<div class="flex flex-100 flex-padding-10 flex-gap-10"
				style="justify-content: flex-end">
				<button type="button"
					class="btn btn-green btn-icon icon-left btn-small"
					@click="cf_movePage('/team4/calculate')">
					등록 <i class="entypo-plus"></i>
				</button>
				<button type="button" value="+삭제" @click="deleteSelected"
					class="btn btn-red btn-icon icon-left btn-small">
					선택 삭제 <i class="entypo-trash"></i>

				</button>
			</div>
			<table class="table table-bordered datatable dataTable" id="grid_app"
				style="border-top-right-radius: 20px; border-top-left-radius: 20px;">
				<thead>
					<tr class="replace-inputs" style="text-align: center;">
						<th
							style="width: 40px; background-color: #3EAB6F; color: white; border-top-left-radius: 20px;"
							class="center hidden-xs nosort"><input type="checkbox"
							id="allCheck" @click="all_check(event.target)"></th>
						<th style="width: 60px; background-color: #3EAB6F; color: white;"
							class="center sorting" @click="sortList(event.target)"
							sort_target="design_id">ID</th>
						<th style="width: 100px; background-color: #3EAB6F; color: white;"
							class="center sorting" @click="sortList(event.target)"
							sort_target="user_id">관리자 ID</th>
						<th style="width: 100px; background-color: #3EAB6F; color: white;"
							class="center sorting" @click="sortList(event.target)"
							sort_target="name">관리자 성명</th>
						<th style="width: 100px; background-color: #3EAB6F; color: white;"
							class="center sorting" @click="sortList(event.target)"
							sort_target="customer_id">회원ID</th>
						<th style="width: 100px; background-color: #3EAB6F; color: white;"
							class="center sorting" @click="sortList(event.target)"
							sort_target="customer_name">회원성명</th>
						<th style="width: 70px; background-color: #3EAB6F; color: white;"
							class="center sorting" @click="sortList(event.target)"
							sort_target="product_type">상품유형</th>
						<th style="width: 190px; background-color: #3EAB6F; color: white;"
							class="center sorting" @click="sortList(event.target)"
							sort_target="product_name">상품명</th>
						<th style="width: 100px; background-color: #3EAB6F; color: white;"
							class="center sorting" @click="sortList(event.target)"
							sort_target="design_date">설계일</th>
						<th style="width: 70px; background-color: #3EAB6F; color: white;"
							class="center">삭제</th>
						<th
							style="width: 70px; background-color: #3EAB6F; color: white; border-top-right-radius: 20px;"
							class="center">상세정보</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in dataList"
						style="cursor: pointer; text-align: center; background-color: white;">
						<td class="center"><input type="checkbox"
							v-model="selectedIds" :value="item.design_id"
							@click="onCheck(item)" name="is_check"></td>
						<td class="left">{{item.design_id}}</td>
						<td class="left">{{item.user_id}}</td>
						<td class="left">{{item.name}}</td>
						<td class="left">{{item.customer_id}}</td>
						<td class="left">{{item.customer_name}}</td>
						<td class="left">{{item.product_type}}</td>
						<td class="left">{{item.product_name}}</td>
						<td class="center">{{item.design_date}}</td>
						<td class="left">
							<button type="button" value="삭제"
								@click="deleteItem(item.design_id)" class="btn btn-red"
								style="border-style: none;">
								<i class="entypo-trash"></i>
							</button>
						</td>

						<td class="left"><input type="button" value="정보"
							@click="gotoDtl(item.design_id, item.customer_id, item.product_id)"
							class="btn btn-orange" style="border-style: none;"></td>
					</tr>
				</tbody>
			</table>
			<div class="dataTables_wrapper" style="border-style: none;">
				<div class="dataTables_paginate paging_simple_numbers"
					id="div_paginate" style="background-color: white;"></div>
			</div>
			</template>
		</div>
	</div>

	<!-- 설계 정보 조회 팝업 -->
	<div class="modal fade" id="pop_sub_info"
		style="margin-top: 100px; margin-left: 50px;">
		<template>
			<div class="modal-dialog" style="width: 80%;">
				<div class="modal-content1">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true" id="btn_popClose">&times;</button>
						<h4 class="modal-title" id="modify_nm">설계 정보 조회</h4>
					</div>
					<div class="modal-body">
						<div class="panel-body"
							style="display: flex; border: 1px solid #FF0000; width: 100%;">
							<div class="left-panel" style="width: 50%;">
								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">ID :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control" id="pop_design_id"
											v-model="info.design_id" readonly>
									</div>
								</div>

								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">상품명 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control" id="pop_product_name"
											v-model="info.product_name" readonly>
									</div>
								</div>

								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">고객ID :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control" id="pop_customer_id"
											v-model="info.customer_id" readonly>
									</div>
								</div>

								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">고객명 :</label>
									</div>
									<div class="input-box">
										<input class="form-control" type="text" class="form-control"
											id="pop_customer_name" v-model="info.customer_name" readonly>
									</div>
								</div>
								<div class="form-group1" v-if="info.product_type === '예금'">
									<div class="label-box1">
										<label>예치 금액 :</label>
									</div>
									<div class="input-box">
										<input class="form-control" type="text" id="pop_sub_money"
											v-model="info.sub_money" readonly> <span>원</span>
									</div>
								</div>
								<div class="form-group1" v-else-if="info.product_type === '적금'">
									<div class="label-box1">
										<label>납입 금액 :</label>
									</div>
									<div class="input-box">
										<input class="form-control" type="text" id="pop_cycle_money"
											v-model="info.cycle_money" readonly> <label
											class="label-position2">원</label>
									</div>
								</div>
								<div class="form-group1" v-else-if="info.product_type === '대출'">
									<div class="label-box1">
										<label>대출 금액 :</label>
									</div>
									<div class="input-box">
										<input class="form-control" type="text" id="pop_sub_money"
											v-model="info.sub_money" readonly> <label
											class="label-position2">원</label>
									</div>
								</div>
								<div class="form-group1" v-if="info.product_type === '대출'">
									<div class="label-box1">
										<label for="err_eng_nm">대출 유형 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control"
											id="pop_info.loan_repayment_type"
											v-model="info.loan_repayment_type" readonly>
									</div>
								</div>
								<div class="form-group1" v-else>
									<div class="label-box1">
										<label for="err_eng_nm">이자 유형 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control"
											id="pop_info.interest_type" v-model="info.interest_type"
											readonly>
									</div>
								</div>

								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">고정금리 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control"
											id="pop_f_interest_rate" v-model="info.f_interest_rate"
											readonly> <label class="label-position2">%</label>
									</div>
								</div>
								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">고정금리 기간 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control"
											id="pop_f_select_month" v-model="info.f_select_month"
											readonly> <label class="label-position2">월</label>
									</div>
								</div>

								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">변동금리 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control"
											id="pop_v_interest_rate" v-model="info.v_interest_rate"
											readonly> <label class="label-position2">%</label>
									</div>
								</div>
								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">변동금리 기간 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control"
											id="pop_v_select_month" v-model="info.v_select_month"
											readonly> <label class="label-position2">월</label>
									</div>
								</div>
								<div class="form-group1" v-if="info.product_type === '대출'">
									<div class="label-box1">
										<label for="err_eng_nm">중도상환수수료 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control" id="pop_rate"
											v-model="info.rate" readonly> <label
											class="label-position2">%</label>
									</div>
								</div>
								<div class="form-group1" v-else>
									<div class="label-box1">
										<label for="err_eng_nm">세율 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control" id="pop_rate"
											v-model="info.rate" readonly> <label
											class="label-position2">%</label>
									</div>
								</div>

								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">최종 금액 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control" id="pop_final_money"
											v-model="info.final_money" readonly>
									</div>
								</div>
								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">최종 이자 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control"
											id="pop_final_interest" v-model="info.final_interest"
											readonly>
									</div>
								</div>
								<div class="form-group1">
									<div class="label-box1">
										<label for="err_eng_nm">설계 날짜 :</label>
									</div>
									<div class="input-box">
										<input type="text" class="form-control" id="pop_design_date"
											v-model="info.design_date" readonly>
									</div>
								</div>

							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="update"
							class="btn btn-green btn-icon btn-small" data-dismiss="modal"
							@click="updateProduct()">
							CHANGE <i class="entypo-check"></i>
						</button>
						<button type="button" id="update"
							class="btn btn-red btn-icon btn-small" data-dismiss="modal"
							@click="deleteDesign(info.design_id)">
							DELETE<i class="entypo-trash"></i>
						</button>
						<button type="button" id="cancle"
							class="btn btn-gray btn-icon btn-small" data-dismiss="modal"
							@click="close()">
							CLOSE</i>
						</button>
					</div>

				</div>
			</div>
		</template>
	</div>


</body>
<script>

function setDatePicker() {
	setTimeout(
			function(){
				if($("#wrdtbtn").length == 1){
					var $this = $(".datepicker2"),
					opts = {
						format: attrDefault($this, 'format', 'mm/dd/yyyy'),
						daysOfWeekDisabled: attrDefault($this, 'disabledDays', ''),
						startView: attrDefault($this, 'startView', 0),
						rtl: rtl(),
						todayBtn: true,
						language : 'ko',
						autoclose : true,
						todayHighlight : true,
					},
					$n = $this.next(),
					$p = $this.prev();
					$this.datepicker(opts).on("changeDate",function(e){
						var objID = e.currentTarget.id;
						if(objID == 'wrdtbtn'){	//시작일시
							vueapp.wrt_dt = e.date.format('yyyy-MM-dd')
						}
					});
				} 
			},
			300
		);
}
setDatePicker();

var todaystr = "${today}";							
var today = todaystr.toDate();	

var vueapp = new Vue({
	el : "#vueapp",
	data : {
		dataList : [],
		design_id : "",
		user_id : "",
		name : "",
		customer_id  : "",
		customer_name : "",
		product_type : "",
		product_name : "",
		design_date  : "",
		all_srch : "N",
		selectedIds: [],
		des_id : "${design_id}",
		cus_id : "${customer_id}",
		pro_id : "${product_id}",
		des_flag: "${flag}",
		my_name: "${name}"
	},
	mounted : function(){
		var fromDtl = cf_getUrlParam("fromDtl");
		var pagingConfig = cv_sessionStorage.getItem("pagingConfig");		
		
		if("Y" === fromDtl && !cf_isEmpty(pagingConfig)){
			cv_pagingConfig.pageNo = pagingConfig.pageNo;
			cv_pagingConfig.orders = [{target : "sub_id", isAsc : false}];
	 		
			this.getList();
		} else {
			cv_sessionStorage
				.removeItem("pagingConfig")
				.removeItem("params");
			this.getList(true);
		}
		if (this.des_flag === "Y"){
			this.gotoDtl(this.des_id, this.cus_id, this.pro_id);
		}

	},
	methods : {
		getListAll : function(isInit){
			this.all_srch = "Y";
			this.getList(isInit);
		},
		getListCond : function(isInit){
			this.all_srch = "N";
			this.getList(isInit);
		},
		getList : function(isInit){
			//첫화면시 바로 여기로 넘어오게 됨
			//이 때 isInit은 true
			cv_pagingConfig.func = this.getList;
			
			if(isInit === true){
				cv_pagingConfig.pageNo = 1;
				cv_pagingConfig.orders = [{target : "DESIGN_ID", isAsc : false}];
			}
			
			var params = {};
			if(this.all_srch != "Y") {
				params = {
					customer_name : this.customer_name,
					design_date : this.design_date,
					product_name : this.product_name,
					name : this.name,
				}
			}
			//첫 화면시 여기로 출력
			cv_sessionStorage
				.setItem('pagingConfig', cv_pagingConfig)
				.setItem('params', params);

			cf_ajax("/team4/designListPaging", params, this.getListCB);
		},
		getListCB : function(data){
 			this.dataList = data.list;
	   		 for (var i = 0; i < this.dataList.length; i++) {
	   		    if (this.dataList[i].suggest_amt !== null && this.dataList[i].suggest_amt !== undefined) {
	   		        this.dataList[i].suggest_amt = this.dataList[i].suggest_amt.numformat();
	   		    }
	   		}
			
			cv_pagingConfig.renderPagenation("system");
		},
		gotoDtl : function(design_id, customer_id, product_id){
        	var params = {
        			design_id : design_id,
        			customer_id : customer_id,
        			product_id : customer_id
        			}
            console.log(JSON.stringify(params));
            axios.post('/team4/moveDesignInfoForm', { params : params })
            .then(response => {
            	alert("상세 정보 페이지로 이동합니다.")
                var resultMap = response.data;
                console.log(JSON.stringify(resultMap));
                // Pass the resultMap to pop_sub_info function
                var result = pop_sub_info(resultMap);

            	})
            .catch(error => {
                console.error('항목 삭제 중 에러 발생:', error);
            });

		},
		sortList : function(obj){
			cf_setSortConf(obj, "prod_nm");
			this.getList();
		},
		all_check : function(obj){
			$('[name=is_check]').prop('checked',obj.checked);
		},
	    onCheck: function (item) {
	        if (this.selectedIds.includes(item.design_id)) {
	            this.selectedIds = this.selectedIds.filter(id => id !== item.design_id);
	        } else {
	            this.selectedIds.push(item.design_id);
	        }
	        console.log(this.selectedIds); // 선택된 ID 목록을 콘솔에 출력
	    },
	    deleteSelected: function () {
	        console.log("======================22============================"); // 선택된 ID 목록을 콘솔에 출력
	        console.log(this.selectedIds); // 선택된 ID 목록을 콘솔에 출력
	        var params ={
	        		selectedIds: this.selectedIds
	        }
	        console.log(JSON.stringify(params))
	        console.log("======================33============================"); // 선택된 ID 목록을 콘솔에 출력

	        if (this.selectedIds.length > 0) {
	            if (confirm('정말로 선택된 항목을 삭제하시겠습니까?')) {
	                axios.post('/team4/deleteDesign', {params : params})
	                    .then(response => {
	                        alert("정상적으로 삭제처리되었습니다.");
	                        this.getListAll(false); // 목록을 다시 로드
	                    })
	                    .catch(error => {
	                        console.error('아이템 삭제 중 에러 발생:', error);
	                    });
	            } else {
	                console.log('삭제가 취소되었습니다.');
	            }
	        } else {
	            console.warn('삭제할 아이템이 선택되지 않았습니다.');
	        }
	    },
        
        deleteItem: function (design_id) {
	        console.log("=================================================="); // 선택된 ID 목록을 콘솔에 출력
	        console.log(design_id)
        	var params = {design_id : design_id}
            if (confirm('이 항목을 삭제하시겠습니까?')) {
                axios.post('/team4/deleteSingleDesign', { params : params })
                    .then(response => {
                        alert("항목 삭제 완료");
                        // Spring 컨트롤러에서 받은 URL로 페이지를 새로고침하며 이동합니다
                        this.getList(false); // 목록을 다시 로드
                        })
                    .catch(error => {
                        console.error('항목 삭제 중 에러 발생:', error);
                    });
            }
        },
	},
})


function pop_sub_info(mapData) {
	  // 원하는 작업을 수행하고, 결과를 반환하는 로직을 구현
	  // 예를 들어 Vue 인스턴스의 데이터에 접근하여 그 값을 반환할 수 있습니다.
	  var pop_sub_info = new Vue({
			el : "#pop_sub_info",
			data: {
			    info: {
	                customer_id: mapData.customer_id,
	                customer_name: mapData.customer_name,
	                design_id: mapData.design_id,
	                design_date: mapData.design_date,
	                sub_money: mapData.sub_money,
	                cycle_money: mapData.cycle_money,
					interest_type: mapData.interest_type,
					loan_repayment_type: mapData.loan_repayment_type,
	                f_interest_rate: mapData.f_interest_rate,
	                v_interest_rate: mapData.v_interest_rate,
	                f_select_month: mapData.f_select_month,
	                v_select_month: mapData.v_select_month,
	                rate: mapData.rate,
	                final_money: mapData.final_money,
	                final_interest: mapData.final_interest,
	                product_id: mapData.product_id,
	                product_name: mapData.product_name,
	                product_type: mapData.product_type,
	                prod_ty_cd:""
			    }
			},
			mounted : function(){
				$('#pop_sub_info').modal('show');
			},

			methods : {
				updateProduct : function(){
					if(this.info.product_type == '예금'){
						this.info.prod_ty_cd = "3";
					} else if(this.info.product_type == '적금'){
						this.info.prod_ty_cd = "1";
					} else if(this.info.product_type == '대출'){
						this.info.prod_ty_cd = "4";
					}
					if(this.info.product_name.includes("목돈")){
						this.info.prod_ty_cd = "2";
					}
					console.log("prod_ty_cd : " + this.info.prod_ty_cd)

					
					var params = {
						product_id: this.info.product_id,
						customer_id: this.info.customer_id,
						design_id: this.info.design_id,
						prod_ty_cd: this.info.prod_ty_cd
						
					};		
					console.log("========update params값=================")
               		console.log(JSON.stringify(params));
		            if (confirm('이 항목을 변경하시겠습니까?')) {
		    			cf_movePage("/team4/calculate", params);
		            }
				},
				close : function(){
                    window.location.href = "/team4/designList";                       
				},
		        deleteDesign: function (design_id) {
			        console.log("=================================================="); // 선택된 ID 목록을 콘솔에 출력
			        console.log(design_id)
		        	var params = {design_id : design_id}
		            if (confirm('이 항목을 삭제하시겠습니까?')) {
		                axios.post('/team4/deleteSingleDesign', { params : params })
		                    .then(response => {
		                        alert("항목 삭제 완료");
		                        window.location.href = "/team4/designList";                       
		                        })
		                    .catch(error => {
		                        console.error('항목 삭제 중 에러 발생:', error);
		                    });
		            }else{
	                    window.location.href = "/team4/designList";                       
		            }
		        },

			},
		});

	}



</script>
</html>