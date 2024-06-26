<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false"/>
	<!-- Imported styles on this page -->
	<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">
	
	<title>가입상품조회</title>
</head>
<body class="page-body">

<div class="page-container">

	<jsp:include page="/WEB-INF/jsp/kcg/_include/team4/sidebar-menu.jsp" flush="false"/>

	<div class="main-content">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false"/>
		
		<ol class="breadcrumb bc-3">
			<li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
			<li class="active"><strong>가입상품조회</strong></li>
		</ol>
	
		<h2>가입상품조회</h2>
		<br/>
		
		<div class="dataTables_wrapper" id="vueapp">
		<template>
			<div class="dataTables_filter" style="float: none;">
				
				<table style="width: 100%;">
					<tr>
						<td class="left">
							<label class="sys_label_01 control-label">고객명:</label>
							<div class="sys_col_02" style="width: 246px;">
								<input class="form-control" v-model="customer_name" value="" />
							</div>
							
							<label class="sys_label_01 control-label">관리담당자:</label>
							<div class="sys_col_02" style="width: 246px;">
								<input class="form-control" v-model="user_id" value="" />
							</div>
						</td>
						<td class="right" style="width: 200px;">
							<button type="button" class="btn btn-blue btn-icon icon-left" @click="getListCond(true)">
								조건검색
								<i class="entypo-search"></i>
							</button>
						</td>
					</tr>
					<tr>
						<td class="left">
							
							<label class="sys_label_01 control-label">가입날짜</label>
							<div class="sys_col_02" style="width: 210px;">
								<div class="input-group">
									<input type="text" class="form-control datepicker2" v-model="sub_start_date" data-format="yyyy-mm-dd" style="width: 180px;">
								</div>
							</div>
							<button type="button" class="btn btn-primary btn-sm datepicker2" id="wrdtbtn" style="float: left;">
								<i class="fa fa-calendar"></i>
							</button>
							<label class="sys_label_01 control-label">상품명:</label>
							<div class="sys_col_02" style="width: 246px;">
								<input class="form-control" v-model="product_name" value="" />
							</div>
						</td>
						<td class="right" style="width: 200px;">
							<button type="button" class="btn btn-blue btn-icon icon-left" @click="getListAll(true)">
								전체검색
								<i class="entypo-search"></i>
							</button>
						</td>
					</tr>
				</table>
			</div>
			
			<div class="dataTables_filter" style="float: none;">
			<div class="sub flex flex-90">
                <span class="sub-button flex-center flex-10 flex-wrap">
					<button type="button" class="btn btn-orange btn-icon icon-left btn-small" @click="cf_movePage('/team4/subscriptionForm')">
						등록
						<i class="entypo-plus"></i>
					</button>
                </span>
            </div>
            </div>
            
            
			<table class="table table-bordered datatable dataTable" id="grid_app">                                    
				<thead>
					<tr class="replace-inputs">
						<th style="width: 5%;" class="center hidden-xs nosort"><input type="checkbox" id="allCheck" @click="all_check(event.target)"></th>
						<th style="width: 10%;" class="center sorting" @click="sortList(event.target)" sort_target="sub_id">ID</th>
						<th style="width: 10%;" class="center sorting" @click="sortList(event.target)" sort_target="customer_id">회원ID</th>
						<th style="width: 10%;" class="center sorting" @click="sortList(event.target)" sort_target="customer_name">성명</th>						
						<th style="width: 10%;" class="center sorting" @click="sortList(event.target)" sort_target="sub_start_date">가입일</th>
						<th style="width: 10%;" class="center sorting" @click="sortList(event.target)" sort_target="sub_end_date">만기일</th>
						<th style="width: 13%;" class="center sorting" @click="sortList(event.target)" sort_target="customer_phone">전화번호</th>
						<th style="width: 10%;" class="center sorting" @click="sortList(event.target)" sort_target="product_type">상품유형</th>						
						<th style="width: 25%;" class="center sorting" @click="sortList(event.target)" sort_target="product_name">상품명</th>			
						<th style="width: 31%;" class="center sorting" >금액</th>	
						<th style="width: 10%;" class="center">삭제</th>
						<th style="width: 10%;" class="center">변경</th>														
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in dataList" style="cursor: pointer;">
					    <td class="center">
						  <input type="checkbox" v-model="selectedIds" :value="item.sub_id" @click="onCheck(item)" name="is_check">
					    </td>
					    <td class="left">{{item.sub_id}}</td>
					    <td class="left">{{item.customer_id}}</td>
					    <td class="left">{{item.customer_name}}</td>
					    <td class="center">{{item.sub_start_date}}</td>
					    <td class="left">{{item.sub_end_date}}</td>
					    <td class="center">{{item.customer_phone}}</td>
					    <td class="left">{{item.product_name}}</td>
					    <td class="left">{{item.product_type}}</td>
					    <td class="right" v-if="item.product_type === '예금'">{{item.start_money}}</td>
					    <td class="right" v-else-if="item.product_type === '적금'">{{item.cycle_money}}</td>
					    <td class="right" v-else-if="item.product_type === '대출'">{{item.loan}}</td>
					    <td class="left"  v-else>-</td>
					    <td class="left">				   
					        <input type="button" value="삭제" @click="deleteItem(item.sub_id)">
					    </td>
					 
					    <td class="left">
					        <input type="button" value="변경" @click="gotoDtl(item.sub_id, item.customer_id, item.product_id)">
					    </td>
					</tr>
				</tbody>
			</table>
			<input type="button" value="+삭제" @click="deleteSelected">
			<div class="dataTables_paginate paging_simple_numbers" id="div_paginate">
			</div>
		</template>
		</div>
		
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp" flush="false"/>
		
	</div>
</div>

<!-- 가입 정보 조회 팝업 -->
<div class="modal fade" id="pop_sub_info">
<template>
	<div class="modal-dialog" style="width: 80%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="btn_popClose">&times;</button>
				<h4 class="modal-title" id="modify_nm">가입 정보 조회</h4>
			</div>
			<div class="modal-body">
                <div class="panel-body" style="display: flex;border: 1px solid #FF0000;width: 100%;">			
                    <div class="left-panel" style="width: 50%;">
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">ID:</label>
                            <input type="text" class="form-control" id="pop_sub_id" v-model="info.sub_id" readonly>
                        </div>
                    
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">상품ID:</label>
                            <input type="text" class="form-control" id="pop_product_id" v-model="info.product_id" readonly>
                        </div>
      
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">상품명:</label>
                            <input type="text" class="form-control" id="pop_product_name" v-model="info.product_name" readonly>
                        </div>
    
    
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">고객ID:</label>
                            <input type="text" class="form-control" id="pop_customer_id" v-model="info.customer_id" readonly>
                        </div>
      
    
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">고객명:</label>
                            <input type="text" class="form-control" id="pop_customer_name" v-model="info.customer_name" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">가입금액</label>
							    <div v-if="info.product_type === '예금'">
							    	<label>예치 금액:</label>
							        <input type="text" id="pop_start_money" v-model="info.start_money">
							        <span>원</span>
							    </div>
							    <div v-else-if="info.product_type === '적금'">
							    	<label>납입 금액:</label>
							        <input type="text" id="pop_cycle_money" v-model="info.cycle_money">
							        <span>원</span>
							    </div>
							    <div v-else-if="info.product_type === '대출'">
							    	<label>대출 금액:</label>
							        <input type="text" id="pop_loan" v-model="info.loan">
							    	<span>원</span>       
							    </div>
							    <div v-else>
				    			</div>
                        </div>                     
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">이자율:</label>
                            <input type="text" class="form-control" id="pop_pro_interest_rate" v-model="info.pro_interest_rate">
                            <span>%</span>                        
                        </div>
                            <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">가입날짜:</label>
                            <input type="text" class="form-control" id="pop_sub_start_date" v-model="info.sub_start_date">
                        </div>      
    
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">만기날짜:</label>
                            <input type="text" class="form-control" id="pop_sub_end_date" v-model="info.sub_end_date">
                        </div>      
                    </div>
                </div>          
			</div>
			<div class="modal-footer" >
                <button type="button" id="update" class="btn btn-secondary" data-dismiss="modal" @click="updateProduct()">CHANGE</button>
         	</div>
			<div class="modal-footer" >
                <button type="button" id="cancle" class="btn btn-secondary" data-dismiss="modal" @click="close()">CLOSE</button>
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
		product_name : "",
		customer_name  : "",
		user_id : "",
		sub_start_date : "",
		all_srch : "N",
		selectedIds: []
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
				cv_pagingConfig.orders = [{target : "SUB_ID", isAsc : false}];
			}
			
			var params = {};
			if(this.all_srch != "Y") {
				params = {
					customer_name : this.customer_name,
					user_id : this.user_id,
					sub_start_date : this.sub_start_date,
					product_name : this.product_name,
				}
			}
			//첫 화면시 여기로 출력
			cv_sessionStorage
				.setItem('pagingConfig', cv_pagingConfig)
				.setItem('params', params);

			cf_ajax("/team4/getListPaging", params, this.getListCB);
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
		gotoDtl : function(sub_id, customer_id, product_id){
        	var params = {
        			sub_id : sub_id,
        			customer_id : customer_id,
        			product_id : customer_id
        			}
            console.log(JSON.stringify(params));
            axios.post('/team4/moveUpdateForm', { params : params })
            .then(response => {
            	alert("변경폼으로 이동합니다.")
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
	        if (this.selectedIds.includes(item.sub_id)) {
	            this.selectedIds = this.selectedIds.filter(id => id !== item.sub_id);
	        } else {
	            this.selectedIds.push(item.sub_id);
	        }
	        console.log(this.selectedIds); // 선택된 ID 목록을 콘솔에 출력
	    },
	    deleteSelected: function () {
	        console.log("=================================================="); // 선택된 ID 목록을 콘솔에 출력
	        console.log(this.selectedIds); // 선택된 ID 목록을 콘솔에 출력
	        var params ={
	        		selectedIds: this.selectedIds
	        }
	        console.log(this.params)
	        console.log("=================================================="); // 선택된 ID 목록을 콘솔에 출력

	        if (this.selectedIds.length > 0) {
	            if (confirm('정말로 선택된 항목을 삭제하시겠습니까?')) {
	                axios.post('/team4/deleteProduct', {params : params})
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
        
        deleteItem: function (sub_id) {
        	var params = {sub_id : sub_id}
            if (confirm('이 항목을 삭제하시겠습니까?')) {
                axios.post('/team4/deleteSingleItem', { params : params })
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

		popupPrint : function(prod_cd){
			var chkedList = $("[name=is_check]:checked");			 
			if(chkedList.length == 0){
				alert("출력할 대상을 선택하여 주십시오.");
				return;
			}
			//check list 가져오기..
			var dateCopyList = [];
			var idx;
			chkedList.each(function(i) {
				idx = $(this).attr("data-idx");
				dateCopyList.push(vueapp.dataList.getElementFirst("prod_cd", idx));
			});			
			
			console.log(dateCopyList);		
			
			//출력팝업 띄우기
			popup_print.init(dateCopyList);
			$('#popup_print').modal('show');
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
	                sub_id: mapData.sub_id,
	                product_id: mapData.product_id,
	                product_name: mapData.product_name,
	                pro_interest_rate: mapData.pro_interest_rate,
	                product_type: mapData.product_type,
	                customer_id: mapData.customer_id,
	                customer_name: mapData.customer_name,
	                start_money: mapData.start_money,
	                cycle_money: mapData.cycle_money,
	                loan: mapData.loan,
	                sub_start_date: mapData.sub_start_date,
	                sub_end_date: mapData.sub_end_date,
			    }
			},
			mounted : function(){
				$('#pop_sub_info').modal('show');
			},

			methods : {
				updateProduct : function(){
					var params = {
						sub_id: this.info.sub_id,
						product_id: this.info.product_id,
						product_name: this.info.product_name,
						pro_interest_rate: this.info.pro_interest_rate,
						product_type: this.info.product_type,
						customer_id: this.info.customer_id,
						customer_name: this.info.customer_name,
						start_money: this.info.start_money,
						cycle_money: this.info.cycle_money,
						loan: this.info.loan,
						sub_start_date: this.info.sub_start_date,
						sub_end_date: this.info.sub_end_date
					};		
					console.log("================================")
                console.log(JSON.stringify(params));
		            if (confirm('이 항목을 변경하시겠습니까?')) {
		                axios.post('/team4/updateSubscription', { params : params })
		                    .then(response => {
		                    		alert("변경 완료");
			                        vueapp.getList(false); // 목록을 다시 로드
		                        })
		                    .catch(error => {
		                        console.error('항목 삭제 중 에러 발생:', error);
		                    });
		            }

				},
				close : function(){
					$('#pop_sub_info').modal('hide');
					window.location.reload();
				}
			},
		});

	}



</script>
</html>