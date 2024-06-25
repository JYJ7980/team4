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
	<link rel="stylesheet" href="/static_resources/system/js/datatables/promion.css">
	
	<!-- Bilboard Chart(https://naver.github.io/billboard.js) -->
	<script src="https://d3js.org/d3.v6.min.js"></script>
	<script src="/static_resources/system/js/datatables/billboard.js"></script>
	<link rel="stylesheet" href="/static_resources/system/js/datatables/billboard.css">
	
	<title>금융계산기</title>
</head>
<body class="page-body">

<div class="page-container">

	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>

	<div class="main-content">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false"/>
		
		<ol class="breadcrumb bc-3">
			<li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
			<li class="active"><strong>금융계산기</strong></li>
		</ol>
	
		<h2>프로모션 > 금융계산기 (대출 설계)</h2>
		<br/>
		
		<div class="row">
			<div class="dataTables_wrapper flex" id="vueapp">
			<template>
			
				<div class="left flex-column flex-gap-10 flex-40" v-if="info.simpl_ty_cd == '1'">
                    <label>고객정보:</label>
                    <div class="form-group">
                        <label>성명:</label>
                        <input class="form-control" v-model="custInfo.customer_name" disabled />
                        <button type="button" class="btn" @click="popupCust()">
                             <i class="fa fa-search"></i>
                         </button>
                    </div>
                    <div class="form-group">
                        <label>주민번호:</label>
                        <input class="form-control" v-model="custInfo.customer_id_number" disabled />
                    </div>
                    <div class="form-group">
                        <label>E-mail:</label>
                        <input class="form-control" v-model="custInfo.customer_email" disabled />
                    </div>
                    <div class="form-group">
                        <label>전화번호:</label>
                        <input class="form-control" v-model="custInfo.customer_phone" disabled />
                    </div>
                    <div class="form-group">
                        <label>비상연락처:</label>
                        <input class="form-control" v-model="custInfo.customer_sub_tel" disabled />
                    </div>
                    <div class="form-group">
                        <label>직업:</label>
                        <input class="form-control" v-model="custInfo.customer_job" disabled />
                    </div>
                    <div class="form-group">
                        <label>주소:</label>
                        <input class="form-control" v-model="custInfo.customer_addr" disabled />
                    </div>
                    <div class="form-group">
                        <label>관리담당자ID:</label>
                        <input class="form-control" v-model="custInfo.user_id" disabled />
                    </div>
                    <div class="form-group">
                        <label>관리담당자:</label>
                        <input class="form-control" v-model="custInfo.name" disabled />
                    </div>
                    
                    <div class="form-group">
                        <label>부서:</label>
                        <input class="form-control" v-model="custInfo.dept" disabled />
                    </div>
                    <div class="form-group">
                        <label>직위:</label>
                        <input class="form-control" v-model="custInfo.jikgub_nm" disabled />
                    </div>
                </div>
                
				<div class="right flex-column flex-100">
                    <div class="right-top">
                        <ul class="nav">
                            <li class="nav-tab" @click="tabChange(1)">적금 설계</li>
                            <li class="nav-tab" @click="tabChange(2)">목돈마련적금 설계</li>
                            <li class="nav-tab " @click="tabChange(3)">예금 설계</li>
                            <li class="nav-tab active" @click="tabChange(4)">대출 설계</li>
                        </ul>
                        <div class="nav-content flex-column flex-gap-10">
                        	<div class="form-group" style="justify-content: left">
                                <label>설계번호:</label>
                                <input class="form-control" id="design_id" v-model="info.design_id" disabled />
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>상품선택:</label>
                                <input class="form-control" id="prod_cd" v-model="proInfo.product_id" disabled />
                                <input class="form-control" id="prod_nm" v-model="proInfo.product_name" />
                                <button type="button" class="btn" @click="popupProd()">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>대출금액 (원):</label>
                                <input class="form-control flex-50" type="text" id="dpst_amt" v-model="info.sub_money" style="width: 700px;"/>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(10)">+10만원</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(50)">+50만원</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(100)">+100만원</button>
                                <button type="button" class="btn btn-navy flex-20" @click="setCircleAcmlAmt(0)">정정</button>
                            </div>
                                                        
                            <div class="form-group" style="justify-content: left">
                                <label>이자유형:</label>
								<select class="form-control" id="int_tax_ty_cd" v-model="info.loan_repayment_type" style="padding-top: 3px;">
									<option value="원리금 균등">원리금 균등 상환방식</option>
									<option value="원금 균등">원금 균등 상환방식</option>
									<option value="만기 일시">만기일시상환방식</option>
								</select>
                            </div>
                            

                            <div class="form-group" style="justify-content: left">
                                <label>고정금리 (%):</label>
                                <input class="form-control" type="text" id="aply_rate" v-model="info.f_interest_rate" />
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label> 고정금리 예치기간 (개월):</label>
                                <input class="form-control flex-50" type="text" id="dpst_prd" v-model="info.f_select_month" style="width: 700px;"/>
                                <button type="button" class="btn btn-transparent flex-20" @click="fSetGoalPrd(3)">+3개월</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="fSetGoalPrd(6)">+6개월</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="fSetGoalPrd(12)">+12개월</button>
                                <button type="button" class="btn btn-navy flex-20" @click="fSetGoalPrd(0)">정정</button>
                            </div>
                            
                            <div class="form-group" style="justify-content: left">
                                <label>변동금리 (%):</label>
                                <input class="form-control" type="text" id="aply_rate" v-model="info.v_interest_rate" />
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label> 변동금리 예치기간 (개월):</label>
                                <input class="form-control flex-50" type="text" id="dpst_prd" v-model="info.v_select_month" style="width: 700px;"/>
                                <button type="button" class="btn btn-transparent flex-20" @click="vSetGoalPrd(3)">+3개월</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="vSetGoalPrd(6)">+6개월</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="vSetGoalPrd(12)">+12개월</button>
                                <button type="button" class="btn btn-navy flex-20" @click="vSetGoalPrd(0)">정정</button>
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>중도상환 수수료 (%):</label>
                                <input class="form-control" type="text" id="aply_rate" v-model="info.rate" />
                            </div>
                        </div>
                    </div>
                    
					<div class="dt-buttons" style="padding-top: 15px;">
						<input id="external" type="radio" v-model="info.simpl_ty_cd" value="1">
						<label class="tab_item" for="external">정상설계</label>
						<input id="internal" type="radio" v-model="info.simpl_ty_cd"  value="0">
						<label class="tab_item" for="internal">간편설계</label>
					</div>
					<div class="dataTables_filter">
						<button type="button" class="btn btn-red btn-small" @click="prcCalc()">
							이자계산
						</button>
					    <button type="button" class="btn btn-orange btn-small" v-if="!info.design_id" @click="save()">
					        설계저장
					    </button>
					    <button type="button" class="btn btn-orange btn-small" v-else @click="update()">
					        변경
					    </button>
						<button type="button" class="btn btn-blue btn-icon btn-small" @click="gotoList()">
							목록 <i class="entypo-list"></i>
						</button>
					</div>
					
                    <ul class="nav">
                        <li class="nav-tab active">계산결과</li>
                    </ul>
                    
                    <div class="right-bottom flex-100">
	                       <table>
	                        <tr>
	                        	<td class="center" style="width: 40%; vertical-align: top;">
	                        		<div class="form-wrapper flex flex-wrap flex-gap-10">

			                               <div class="form-group" v-if="info.loan_repayment_type ==='원리금 균등'">
			                                   <label>매 회차 납입 금액:</label>
			                                   <input class="form-control" id="int_tax_amt" v-model="info.cycle_money" disabled />
			                               </div>

			                               <div class="form-group">
			                                   <label>총 납입 이자:</label>
			                                   <input class="form-control" id="int_tax_amt" v-model="info.final_interest" disabled />
			                               </div>
			                               <div class="form-group">
			                                   <label>총 상환 금액:</label>
			                                   <input class="form-control" id="atx_rcve_amt" v-model="info.final_money" disabled />
			                               </div>
			                               
			                           </div>	
			                           
		                            <div class="panel-heading">
										<div class="panel-title">계산결과 CHART</div>
									</div>										
									<div id="chart" class="bottom-right-bottom flex-100"></div>
	                        		</td>
	                        		<td class="center" style="width: 3%;">
	                        		</td>
	                        		<td class="center" style="width: 57%; vertical-align: top;">
			                            <table class="table table-bordered datatable dataTable" id="grid_app">
											<thead>
												<tr class="replace-inputs">
													<th style="width: 8%;" class="center">회차</th>
													<th style="width: 10%;" class="center">납입금액</th>
													<th style="width: 10%;" class="center">원리금액</th>
													<th style="width: 7%;" class="center">이자</th>
													<th style="width: 10%;" class="center">누적 이자</th>
													<th style="width: 7%;" class="center">잔금</th>
													<th style="width: 15%;" class="center">중도상환 수수료</th>
													
												</tr>
											</thead>
											<tbody id="grid_tbody">
												<tr v-for="item in calculate_arr" style="cursor: pointer;">
													<td class="right" style="text-align: right;">{{item.round_num}}</td>
													<td class="right" style="text-align: right;">{{item.round_cycle_money}}</td>
													<td class="right" style="text-align: right;">{{item.round_pri_cycle_money}}</td>
													<td class="right" style="text-align: right;">{{item.round_interest}}</td>
													<td class="right" style="text-align: right;">{{item.acc_interest}}</td>
													<td class="right" style="text-align: right;">{{item.round_total}}</td>
													<td class="right" style="text-align: right;">{{item.early_repayment_fee}}</td>
												</tr>
											
											</tbody>
										</table>
	                        		</td>
	                        	</tr>
	                        </table>
                    </div>
                </div>
				
			</template>
			</div>
		</div>
		
		<br />
		
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp" flush="false"/>
		
	</div>
</div>

			<!-- 상품팝업 -->
			<div class="modal fade" id="pop_prod">
				<template>
					<div class="modal-dialog" style="width: 500px;">
						<div class="modal-content">
							<div class="modal-body">
								<div class="dataTables_wrapper">
									<div class="dt-buttons">
											<label>상품명:</label>
											<input type="search" id="pop_product_name" style="width: 200px;"
												v-model="pop_product_name">
											<button type="button" class="btn btn-red"
												style="margin-left: 5px;" @click="getList">검색</button>
									</div>
								</div>
								<div style="height: 400px; overflow: auto;"
									class="dataTables_wrapper">
									<table class="table table-bordered datatable dataTable">
										<thead style="position: sticky; top: 0px;">
											<tr>
												<th class="center" style="width: 25%;">상품ID</th>
												<th class="center" style="width: 50%;">상품명</th>
												<th class="center" style="width: 25%;">상품 유형</th>
											</tr>
										</thead>
										<tbody>
											<tr v-for="item in dataList" @click="selProd(item.product_id)"
												style="cursor: pointer;">
												<td class="center">{{item.product_id}}</td>
												<td class="left">{{item.product_name}}</td>
												<td class="left">{{item.product_type}}</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</template>
			</div>

			<!-- 고객팝업 -->
			<div class="modal fade" id="pop_cust">
				<template>
					<div class="modal-dialog" style="width: 500px;">
						<div class="modal-content">
							<div class="modal-body">
								<div class="dataTables_wrapper">
									<div class="dt-buttons">
										<div>
											<label>고객명:</label> <input type="search" id="pop_customer_name"
												style="width: 250px;" v-model="pop_customer_name">
											<button type="button" class="btn btn-red"
												style="margin-left: 5px;" @click="getList">검색</button>
										</div>
									</div>
								</div>
								<div style="height: 400px; overflow: auto;"
									class="dataTables_wrapper">
									<table class="table table-bordered datatable dataTable">
										<thead style="position: sticky; top: 0px;">
											<tr>
												<th class="center" style="width: 25%;">고객ID</th>											
												<th class="center" style="width: 25%;">고객명</th>
												<th class="center" style="width: 20%;">생년월일</th>
											</tr>
										</thead>
										<tbody>
											<tr v-for="item in dataList" @click="selCust(item.customer_id)"
												style="cursor: pointer;">
												<td class="center">{{item.customer_id}}</td>
												<td class="center">{{item.customer_name}}</td>
												<td class="center">{{item.customer_brdt}}</td>
											</tr>
										</tbody>
									</table>
									<div class="dataTables_paginate paging_simple_numbers"
										id="div_paginate"></div>
								</div>
							</div>
						</div>
					</div>
				</template>
			</div>

</body>
<script>
var vueapp = new Vue({
	el : "#vueapp",
	data : {
		calculate_arr: [],

		info : {
			prod_ds_sn : "${prod_ds_sn}",
			cust_mbl_telno : "${cust_mbl_telno}",
			prod_ty_cd : "${prod_ty_cd}",
			simpl_ty_cd : "0",
			design_id: "${design_id}",
			sub_money : "", //대출 금액
			loan_repayment_type: "",//상환 방식
			f_interest_rate : "", //고정 금리
			f_select_month : "", //고정 금리 예치 기간
			v_interest_rate : "", //변동 금리
			v_select_month : "", //변동 금리 예치 기간
			rate : "", //중도상환 수수료
			cycle_money: "", //매 회차 납입 금액			
			final_money : "", //총 상환금액
			final_interest : "", //총 납입 이자
			flag: "N"
		},
		proInfo : {
			product_id : "${product_id}",
			product_name : "",
		},

		custInfo : {
			customer_phone : "",
			customer_name : "",
			customer_id_number : "",
			customer_id :"${customer_id}",
			customer_email : "",
			customer_sub_tel : "",
			customer_job : "",
			customer_addr : "",
			user_id : "",
			name : "",
			dept : "",
			jikgub_nm : ""
		},
	},
	mounted : function(){
		
		if(!cf_isEmpty(this.custInfo.customer_id)){
			this.getCustInfo();
		}
		if(!cf_isEmpty(this.info.design_id)){
			this.getDsgInfo();
		}
		if(!cf_isEmpty(this.proInfo.proInfo)){
			this.getProdInfo();
		}

	},
	methods : {
		tabChange : function(index) {
			
			if(this.info.prod_ds_sn != "" && this.info.prod_ds_sn != undefined) {
				alert("신규일 경우만 TAB 이동이 가능합니다.");
				return;
			}
			
			var params = {
				cust_mbl_telno : cf_defaultIfEmpty(this.info.cust_mbl_telno, ""),
				prod_ty_cd : index,
			}
			cf_movePage("/team4/calculate", params);
			
		},
		getDsgInfo : function(){
			cf_ajax("/promion_mng/getDsgInfo", this.info, this.getDsgInfoCB);
		},
		getDsgInfoCB : function(data){
			this.info = data;
			this.info.simpl_ty_cd = "1";
			
			this.prcCalc();
		},
		
		update : function(){
			
	        if (this.info.flag != "Y"){
	              alert("이자 계산을 먼저 수행하세요.");
	              return;
	            }
	        
	        if(this.info.v_select_month == ""){
	        	this.info.v_select_month = 0;
	        }
	        if(this.info.v_interest_rate == ""){
	        	this.info.v_interest_rate = 0;
	        }
	        if(this.info.f_select_month == ""){
	        	this.info.f_select_month = 0;
	        }
	        if(this.info.f_interest_rate == ""){
	        	this.info.f_interest_rate = 0;
	        }
			var params = {
		            v_select_month: this.info.v_select_month,
		            v_interest_rate: this.info.v_interest_rate,
		            rate: this.info.rate,
		            sub_money: this.info.sub_money,
		            cycle_money: this.info.cycle_money,
		            rec_before_tax: this.info.rec_before_tax,
		            final_money: this.info.final_money,
		            profit_rate: this.info.profit_rate,
		            net_profit_rate: this.info.net_profit_rate,
		            interest_type: this.info.interest_type,
		            interest_tax: this.info.interest_tax,
		            f_select_month: this.info.f_select_month,
		            f_interest_rate: this.info.f_interest_rate,
		            before_interest: this.info.before_interest,
		            final_interest: this.info.final_interest,
		            product_id: this.proInfo.product_id,
		            customer_id: this.custInfo.customer_id,
		            design_id: this.info.design_id
			}
			console.log("=================================")
			console.log(JSON.stringify(params))
				console.log("=================================")
				console.log("실행됨 이제 axios로 넘어가야함")
	            axios.post('/team4/updateDes', {params : params})
	        	.then(response => {
					alert("정상적으로 변경되었습니다.")
                    window.location.href = "/team4/designList";
	        	})
	        	.catch(error => {
	        	    console.error("Error:", error);
	        	});				
		},

		save : function(){
			
	        if (this.info.flag != "Y"){
	                alert("이자 계산을 먼저 수행하세요.");
	                return;
	        }	    
	

			var params = {
		            v_select_month: this.info.v_select_month, //ok
		            v_interest_rate: this.info.v_interest_rate, //ok
		            rate: this.info.rate, //ok
		            sub_money:this.info.sub_money,
		            cycle_money: this.info.cycle_money, //ok
		            final_money: this.info.final_money, //ok
		            f_select_month: this.info.f_select_month, //ok
		            f_interest_rate: this.info.f_interest_rate, //ok
		            final_interest: this.info.final_interest,//ok
		            product_id: this.proInfo.product_id,//ok
		            customer_id: this.custInfo.customer_id,//ok
		            loan_repayment_type: this.info.loan_repayment_type
			}
			console.log("=================================")
			console.log(JSON.stringify(params))
				console.log("=================================")
				console.log("실행됨 이제 axios로 넘어가야함")
	            axios.post('/team4/saveCalulate', {params : params})
	        	.then(response => {
					alert("정상등록되었습니다")
                    window.location.href = "/team4/designList";
	        	})
	        	.catch(error => {
	        	    console.error("Error:", error);
	        	});				
		},
		getDsgInfo: function() {
            // 상품 정보를 가져오는 로직
            console.log("1. 정상작동 하였습니다.")

			var params = {
			design_id : this.info.design_id
			}
            
            axios.get('/team4/desSelectOne', {params : params})
             	.then(response => {
    				console.log("2. 정상작동 하였습니다.")
    				this.info = response.data				            		
            	})
            	.catch(error => {
            	    console.error("Error:", error);
            	});
        },
        getProdInfo: function() {
            // 상품 정보를 가져오는 로직
            console.log("1. 정상작동 하였습니다.")

			var params = {
			product_id : this.proInfo.product_id
			}
            
            axios.get('/team4/proSelectOne', {params : params})
             	.then(response => {
    				console.log("2. 정상작동 하였습니다.")
    				this.proInfo = response.data				            		
            	})
            	.catch(error => {
            	    console.error("Error:", error);
            	});
        },

        getCustInfo: function() {
            // 고객 정보를 가져오는 로직
            console.log("1. 정상작동 하였습니다.")
			this.info.simpl_ty_cd= "1";
			var params = {
			customer_id : this.custInfo.customer_id
			}
            
            axios.get('/team4/designCusInfo', {params : params})
            	.then(response => {
    				console.log("2. 정상작동 하였습니다.")
    				this.custInfo = response.data	
    				console.log(this.cus)

            	})
            	.catch(error => {
            	    console.error("Error:", error);
            	});

        },
		setCircleAcmlAmt : function(nAmt){
			if(nAmt == 0) {
				this.info.sub_money = 0;
			}else {
				this.info.sub_money = Number(this.info.sub_money) + nAmt*10000;
			}
		},
		fSetGoalPrd : function(nPrd){
			if(nPrd == 0) {
				this.info.f_select_month = 0;
			}else {
				this.info.f_select_month = Number(this.info.f_select_month) + nPrd;
			}
		},
		vSetGoalPrd : function(nPrd){
			if(nPrd == 0) {
				this.info.v_select_month = 0;
			}else {
				this.info.v_select_month = Number(this.info.v_select_month) + nPrd;
			}
		},

		popupProd : function(){
			pop_prod.getList();
			$("#pop_prod").modal("show");
		},
		popupCust : function(){
			pop_cust.getList();
			$("#pop_cust").modal("show");
		},
		prcCalc : function(){
			this.info.flag = "Y"
			var a = this.info.f_select_month
			var b = this.info.v_select_month
			console.log(a)
			console.log(b)

			if(cf_isEmpty(this.proInfo.product_id)){
				alert("상품을 선택하세요.");
				return;
			}
			

			if(cf_isEmpty(this.info.sub_money)){
				alert("대출금액을 입력하세요.");
				return;
			}
			if(this.info.sub_money == 0){
				alert("대출금액을 입력하세요.");
				return;
			}
			
			
		    if (this.info.loan_repayment_type === '') {
			       alert('상환방법을 선택하여주세요');
			       return false;
			}
		    
		    if(this.info.f_interest_rate === ''){
		    	alert('고정금리를 설정해주세요')
		    }
		    
		    if(this.info.f_interest_rate === ''){
		    	alert('고정금리 기간을 설정해주세요')
		    }
				  		          
		    if (this.info.rate === '') {
		       alert('중도상환 수수료를 작성하여주세요');
		       return false;
		    }

		    var f_interest_rate = (this.info.f_interest_rate /100 /12);
			var v_interest_rate = (this.info.v_interest_rate /100 /12);
			var rate =(this.info.rate /100);				
							
		       if(this.info.v_select_month == ""){
		        	this.info.v_select_month = 0;
		        }
		        if(this.info.v_interest_rate == ""){
		        	this.info.v_interest_rate = 0;
		        	v_interest_rate = 0;
		        }
		        if(this.info.f_select_month == ""){
		        	this.info.f_select_month = 0;
		        }
		        if(this.info.f_interest_rate == ""){
		        	this.info.f_interest_rate = 0;
		        	f_interest_rate = 0;
		        }
		        
	        	
				var params = {
						sub_money : this.info.sub_money,
						loan_repayment_type : this.info.loan_repayment_type,
						f_interest_rate : f_interest_rate,
						f_select_month : this.info.f_select_month,
						v_interest_rate : v_interest_rate,
						v_select_month : this.info.v_select_month,
						rate : rate,
						prod_ty_cd : "4",
				}
				
	            axios.post('/team4/calculator', { params : params })
	            .then(response => {
	            	console.log("111222정상 작동 되었습니다.")
	            	this.calculate_arr =response.data
	            	console.log("=======================")
	            	console.log(JSON.stringify(this.calculate_arr))
	            	
					var sub_money = parseInt(this.info.sub_money); // sub_money를 숫자로 변환
					
					var lastParams = this.calculate_arr[this.calculate_arr.length - 1];
					var cycle_money = lastParams.cycle_money; // 원리금 균등 상환방식의 매 회차 납입금액을 숫자로 변환
					var final_interest = parseInt(lastParams.acc_interest); // 최종 누적 이자를 숫자로 변환
					var final_money = (sub_money + final_interest); // 최종 갚아야할 금액을 계산
					
					console.log("=========숫자인가======");
					console.log("sub_money:" + sub_money);
					console.log("cycle_money:" + cycle_money);
					console.log("this.info.loan_repayment_type:" + this.info.loan_repayment_type);
					console.log("final_money:" + final_money);

					this.info.final_money = final_money; //최종 갚아야할 금액
					this.info.final_interest = final_interest; //최종 누적 이자
					this.info.cycle_money =cycle_money
	            	})
	            .catch(error => {

	                console.error('항목 삭제 중 에러 발생:', error);
	            });

	        	
	        	
// 		        if(v_n == 0 || v_r == 0){
// 		        	console.log("고정금리만 일 때 정상작동")
// 		        	console.log("loan type은? " + this.info.loan_repayment_type)

// 			        if(this.info.loan_repayment_type == "원리금 균등") {
			        	
// 			        	var x = m*f_r/(Math.pow(1+f_r, f_n)-1) + m*f_r;
			        	
// 			        	var acc_interest = 0;
// 			        	var round_interest = 0;
// 			        	var round_pri_cycle_money = 0;
// 			        	var round_total = 0;
			        	
// 			        	for(var i = 1; i <= f_n; i++){
	
// 		        			round_interest =m * f_r;
// 		        			acc_interest = acc_interest + round_interest;
// 		        			round_pri_cycle_money = x - round_interest;
// 		        			round_total = m - round_pri_cycle_money;
		        			
// 		        			if(i == f_n){
// 				        		var params = {
// 					        		round_num: i,
// 					        		round_cycle_money: (m+round_interest).toFixed(0),
// 					        		round_pri_cycle_money: m.toFixed(0),
// 					        		round_interest: round_interest.toFixed(0),
// 					        		acc_interest: acc_interest.toFixed(0),
// 					        		round_total: 0,
// 					        		early_repayment_fee: (round_total * rate * (length -i) /length).toFixed(0),
// 					        		}
// 								this.calculate_arr.push(params);
// 		        			}else{
// 				        		var params = {
// 					        		round_num: i,
// 					        		round_cycle_money: x.toFixed(0),
// 					        		round_pri_cycle_money: round_pri_cycle_money.toFixed(0),
// 					        		round_interest: round_interest.toFixed(0),
// 					        		acc_interest: acc_interest.toFixed(0),
// 					        		round_total: round_total.toFixed(0),
// 					        		early_repayment_fee: (round_total * rate * (length -i) /length).toFixed(0),
// 					        		}
// 				        		m = round_total;	
// 								this.calculate_arr.push(params);
// 		        			}
// 			        	}
			        	
// 						var lastParams = this.calculate_arr[this.calculate_arr.length - 1];
// 						console.log('acc_interest의 값:', lastParams.acc_interest);
// 						console.log('final_moeny 값:', x * (length-1) + lastParams.round_pri_cycle_money +lastParams.acc_interest);
// 						this.info.cycle_money = x.toFixed(0);
// 						this.info.final_interest = acc_interest.toFixed(0);
// 						this.info.final_money = (x*(length-1) + m + acc_interest).toFixed(0);
			        	
			        	
			        	
// 			        }
			        
// 			        if(this.info.loan_repayment_type == "원금 균등") {
	
// 			        	var a = m / length;
			        	
// 			        	var acc_interest = 0;
// 			        	var round_interest = 0;
// 			        	var round_cycle_money = 0;
// 			        	var round_total = 0;
// 			        	var acc_money = 0;
			        	
// 			        	for(var i = 1; i <= f_n; i++){
	
// 		        			round_interest =m * f_r;
// 		        			acc_interest = acc_interest + round_interest;
// 		        			round_cycle_money = a + round_interest;
// 		        			round_total = m - a;
// 		        			if(i == f_n){
// 				        		var params = {
// 					        			round_num: i,
// 					        			round_cycle_money: m.toFixed(0),
// 					        			round_pri_cycle_money: a.toFixed(0),
// 					        			round_interest: round_interest.toFixed(0),
// 					        			acc_interest: acc_interest.toFixed(0),
// 					        			round_total: 0,
// 					        			early_repayment_fee: (round_total * rate * (length -i) /length).toFixed(0),
// 					        			}
				        		
// 								this.calculate_arr.push(params);
// 		        			}else{
// 				        		var params = {
// 					        			round_num: i,
// 					        			round_cycle_money: round_cycle_money.toFixed(0),
// 					        			round_pri_cycle_money: a.toFixed(0),
// 					        			round_interest: round_interest.toFixed(0),
// 					        			acc_interest: acc_interest.toFixed(0),
// 					        			round_total: round_total.toFixed(0),
// 					        			early_repayment_fee: (round_total * rate * (length -i) /length).toFixed(0),
// 					        			}
// 				        		m = round_total;	
// 				        		acc_money = acc_money + round_cycle_money
// 								this.calculate_arr.push(params);
// 		        			}
// 			        	}

// 			        	var lastParams = this.calculate_arr[this.calculate_arr.length - 1];
// 						console.log('acc_interest의 값:', lastParams.acc_interest);
// 						this.info.final_interest = (lastParams.acc_interest);
// 						this.info.final_money = acc_money.toFixed(0);
			        	
			        	
			        	
// 			        }
			        
// 			        if(this.info.loan_repayment_type == "만기 일시") {
			        	
// 			        	var acc_interest = 0;
// 			        	var round_interest = 0;
// 			        	var round_pri_cycle_money = 0;
			        	
// 			        	for(var i = 1; i <= f_n; i++){
	
// 		        			round_interest =m * f_r;
// 		        			acc_interest = acc_interest + round_interest;
// 		        			round_pri_cycle_money = x - round_interest;
// 		        			if(i == f_n){
// 				        		var params = {
// 					        			round_num: i,
// 					        			round_cycle_money: (m+round_interest).toFixed(0),
// 					        			round_pri_cycle_money: m.toFixed(0),
// 					        			round_interest: round_interest.toFixed(0),
// 					        			acc_interest: acc_interest.toFixed(0),
// 					        			round_total: m.toFixed(0),
// 					        			early_repayment_fee: (m * rate * (length -i) /length).toFixed(0),
// 					        		}
// 								this.calculate_arr.push(params);
// 		        			} else{
// 				        		var params = {
// 					        			round_num: i,
// 					        			round_cycle_money: round_interest.toFixed(0),
// 					        			round_pri_cycle_money: 0,
// 					        			round_interest: round_interest.toFixed(0),
// 					        			acc_interest: acc_interest.toFixed(0),
// 					        			round_total: m.toFixed(0),
// 					        			early_repayment_fee: (m * rate * (length -i) /length).toFixed(0),
// 					        		}
// 								this.calculate_arr.push(params);
// 		        			}
// 		        		}
			        	
// 						this.info.final_interest = acc_interest.toFixed(0);
// 						this.info.final_money = (m + acc_interest).toFixed(0);
// 			        }
		        	
// 		        }else{
// 			        if(this.info.loan_repayment_type == "원리금 균등") {
	
// 			        	var f = (Math.pow(1+f_r , f_n) - 1)/f_r;
// 			        	var v = (Math.pow(1+v_r , v_n) - 1)/v_r;
// 			        	var a = (m + m*v_r*v -m*f_r*v)/(v + f + f*v_r*v);
// 			        	var x = (a + m*f_r);
			        	
// 			        	var acc_interest = 0;
// 			        	var round_interest = 0;
// 			        	var round_pri_cycle_money = 0;
// 			        	var round_total = 0;
			        	
// 			        	for(var i = 1; i <= f_n; i++){
	
// 		        			round_interest =m * f_r;
// 		        			acc_interest = acc_interest + round_interest;
// 		        			round_pri_cycle_money = x - round_interest;
// 		        			round_total = m - round_pri_cycle_money;
		        				
// 			        		var params = {
// 			        			round_num: i,
// 			        			round_cycle_money: x.toFixed(0),
// 			        			round_pri_cycle_money: round_pri_cycle_money.toFixed(0),
// 			        			round_interest: round_interest.toFixed(0),
// 			        			acc_interest: acc_interest.toFixed(0),
// 			        			round_total: round_total.toFixed(0),
// 			        			early_repayment_fee: (round_total * rate * (length -i) /length).toFixed(0),
// 			        			}
// 		        			m = round_total;	
// 							this.calculate_arr.push(params);
// 			        	}
		   
// 			        	for(var i = 1; i <= v_n; i++){
			        		
// 		        			round_interest =m * v_r;
// 		        			acc_interest = acc_interest + round_interest;
// 		        			round_pri_cycle_money = x - round_interest;
// 		        			round_total = m - round_pri_cycle_money;
	
// 		        			if(i == v_n) {
// 				        		var params = {
// 					        			round_num: (i + f_n).toFixed(0),
// 					        			round_cycle_money: (m + round_interest).toFixed(0),
// 					        			round_pri_cycle_money: m.toFixed(0),
// 					        			round_interest: round_interest.toFixed(0),
// 					        			acc_interest: acc_interest.toFixed(0),
// 					        			round_total: 0,
// 					        			early_repayment_fee: (round_total * rate * (length -(i + f_n)) /length).toFixed(0)
// 					        			}
// 								this.calculate_arr.push(params);
// 		        			}else{
// 				        		var params = {
// 					        			round_num: (i + f_n).toFixed(0),
// 					        			round_cycle_money: x.toFixed(0),
// 					        			round_pri_cycle_money: round_pri_cycle_money.toFixed(0),
// 					        			round_interest: round_interest.toFixed(0),
// 					        			acc_interest: acc_interest.toFixed(0),
// 					        			round_total: round_total.toFixed(0),
// 					        			early_repayment_fee: (round_total * rate * (length -(i + f_n)) /length).toFixed(0)
// 					        			}
// 				        		m = round_total;	
// 								this.calculate_arr.push(params);
// 		        			}
// 			        	}
// 						var lastParams = this.calculate_arr[this.calculate_arr.length - 1];
// 						console.log('acc_interest의 값:', lastParams.acc_interest);
// 						console.log('final_moeny 값:', x * (length-1) + lastParams.round_pri_cycle_money +lastParams.acc_interest);
// 						this.info.cycle_money = x.toFixed(0);
// 						this.info.final_interest = acc_interest.toFixed(0);
// 						this.info.final_money = (x*(length-1) + round_pri_cycle_money + acc_interest).toFixed(0);
			        	
			        	
			        	
// 			        }
			        
// 			        if(this.info.loan_repayment_type == "원금 균등") {
	
// 			        	var a = m / length;
			        	
// 			        	var acc_interest = 0;
// 			        	var round_interest = 0;
// 			        	var round_cycle_money = 0;
// 			        	var round_total = 0;
// 			        	var acc_money = 0;
			        	
// 			        	for(var i = 1; i <= f_n; i++){
	
// 		        			round_interest =m * f_r;
// 		        			acc_interest = acc_interest + round_interest;
// 		        			round_cycle_money = a + round_interest;
// 		        			round_total = m - a;
		        				
// 			        		var params = {
// 			        			round_num: i,
// 			        			round_cycle_money: round_cycle_money.toFixed(0),
// 			        			round_pri_cycle_money: a.toFixed(0),
// 			        			round_interest: round_interest.toFixed(0),
// 			        			acc_interest: acc_interest.toFixed(0),
// 			        			round_total: round_total.toFixed(0),
// 			        			early_repayment_fee: (round_total * rate * (length -i) /length).toFixed(0),
// 			        			}
// 		        			m = round_total;	
// 		        			acc_money = acc_money + round_cycle_money
	
// 							this.calculate_arr.push(params);
// 			        	}
		   
// 			        	for(var i = 1; i <= v_n; i++){
// 		        			round_interest =m * f_r;
// 		        			acc_interest = acc_interest + round_interest;
// 		        			round_cycle_money = a + round_interest;
// 		        			round_total = m - a;
		        			
// 		        			if(i == v_n) {
// 				        		var params = {
// 					        			round_num: (i + f_n).toFixed(0),
// 					        			round_cycle_money: (m+round_interest).toFixed(0),
// 					        			round_pri_cycle_money: m.toFixed(0),
// 					        			round_interest: round_interest.toFixed(0),
// 					        			acc_interest: acc_interest.toFixed(0),
// 					        			round_total: 0,
// 					        			early_repayment_fee: (round_total * rate * (length -(i + f_n)) /length).toFixed(0)
// 					        			}
// 								this.calculate_arr.push(params);
// 		        			}else{
// 				        		var params = {
// 					        			round_num: (i + f_n).toFixed(0),
// 					        			round_cycle_money: round_cycle_money.toFixed(0),
// 					        			round_pri_cycle_money: a.toFixed(0),
// 					        			round_interest: round_interest.toFixed(0),
// 					        			acc_interest: acc_interest.toFixed(0),
// 					        			round_total: round_total.toFixed(0),
// 					        			early_repayment_fee: (round_total * rate * (length -(i + f_n)) /length).toFixed(0)
// 					        			}
// 				        		m = round_total;	
// 			        			acc_money = acc_money + round_cycle_money
// 								this.calculate_arr.push(params);
// 		        			}
		        			
// 			        	}
// 						var lastParams = this.calculate_arr[this.calculate_arr.length - 1];
// 						console.log('acc_interest의 값:', lastParams.acc_interest);
// 						this.info.final_interest = (lastParams.acc_interest);
// 						this.info.final_money = acc_money.toFixed(0);
			        	
			        	
			        	
// 			        }
			        
// 			        if(this.info.loan_repayment_type == "만기 일시") {
			        	
// 			        	var acc_interest = 0;
// 			        	var round_interest = 0;
// 			        	var round_pri_cycle_money = 0;
			        	
// 			        	for(var i = 1; i <= f_n; i++){
	
// 		        			round_interest =m * f_r;
// 		        			acc_interest = acc_interest + round_interest;
// 		        			round_pri_cycle_money = x - round_interest;
		        				
// 			        		var params = {
// 			        			round_num: i,
// 			        			round_cycle_money: round_interest.toFixed(0),
// 			        			round_pri_cycle_money: 0,
// 			        			round_interest: round_interest.toFixed(0),
// 			        			acc_interest: acc_interest.toFixed(0),
// 			        			round_total: m.toFixed(0),
// 			        			early_repayment_fee: (m * rate * (length -i) /length).toFixed(0),
// 			        			}
// 							this.calculate_arr.push(params);
// 			        	}
		   
// 			        	for(var i = 1; i <= v_n; i++){
// 		        			round_interest =m * v_r;
// 		        			acc_interest = acc_interest + round_interest;
// 		        			round_pri_cycle_money = x - round_interest;
	
// 		        			if(i == v_n) {
// 				        		var params = {
// 					        			round_num: (i + f_n).toFixed(0),
// 					        			round_cycle_money: (m + round_interest).toFixed(0),
// 					        			round_pri_cycle_money: m.toFixed(0),
// 					        			round_interest: round_interest.toFixed(0),
// 					        			acc_interest: acc_interest.toFixed(0),
// 					        			round_total: 0,
// 					        			early_repayment_fee: (m * rate * (length -(i + f_n)) /length).toFixed(0)
// 					        			}
// 								this.calculate_arr.push(params);
// 		        			}else{
// 				        		var params = {
// 					        			round_num: (i + f_n).toFixed(0),
// 					        			round_cycle_money: round_interest.toFixed(0),
// 					        			round_pri_cycle_money: 0,
// 					        			round_interest: round_interest.toFixed(0),
// 					        			acc_interest: acc_interest.toFixed(0),
// 					        			round_total: m.toFixed(0),
// 					        			early_repayment_fee: (m * rate * (length -(i + f_n)) /length).toFixed(0)
// 					        			}
// 								this.calculate_arr.push(params);
// 		        			}
// 			        	}
// 						var lastParams = this.calculate_arr[this.calculate_arr.length - 1];
// 						console.log('acc_interest의 값:', lastParams.acc_interest);
// 						console.log('final_moeny 값:', x * (length-1) + lastParams.round_pri_cycle_money +lastParams.acc_interest);
// 						this.info.final_interest = lastParams.acc_interest;
// 						this.info.final_money = m + acc_interest;
// 			        }
// 		        }


		        
		},
		gotoList : function(){
			cf_movePage('/promion_mng/list');
		},
	}
});

var pop_prod = new Vue({
	el : "#pop_prod",
	data : {
		dataList : [],
		pop_product_name: "",
		pop_product_id:"",
		pop_product_type:"대출",

	},
	mounted : function(){
		this.getList();
	},

	methods : {
		getList : function(){
			this.dataList = [];
			var params = {
				product_name : this.pop_product_name,
				product_type : this.pop_product_type,
			}
			console.log("==params값");
			console.log(JSON.stringify(params));
			cf_ajax("/team4/typeProductList", params, function(proList){
				pop_prod.dataList = proList;
				console.log("==받아온 데이터 값");
				console.log(JSON.stringify(pop_prod.dataList));
			});
		},
		selProd : function(product_id){
			vueapp.proInfo.product_id = product_id;
			$("#pop_prod").modal("hide");
			vueapp.getProdInfo();	

		},
	},
});

var pop_cust = new Vue({
	el : "#pop_cust",
	data : {
		dataList : [],
		pop_customer_name  : "",
		pop_customer_id : "",
		pop_customer_brdt: "",
	},
	methods : {
		getList : function(){
			var params = {
				customer_name : this.pop_customer_name,
			}
			console.log(params);
			cf_ajax("/team4/customerList", params, function(data){
				pop_cust.dataList = data;
			});
		},
		selCust : function(customer_id){
			console.log("==============================")
			console.log(customer_id)
			vueapp.custInfo.customer_id = customer_id;			
			$("#pop_cust").modal("hide");
			vueapp.getCustInfo();

		},
	},
});

</script>

<script>
    function numberFormat(num) {
		num = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return num;
	}
    
    function getToday() {
    	const today = new Date(); 
    	const year = today.getFullYear(); 	// 년도
    	const month = (today.getMonth() + 1).toString().padStart(2, '0');  	// 월
    	const day = today.getDate().toString().padStart(2, '0'); 	// 일
    	
    	return year + "-" + month + "-" + day;
    }
    function formatNumberWithCommas(number) {
        // 소수점 이하 제거
        var wholeNumber = Math.trunc(number);
        // 숫자를 문자열로 변환한 후 콤마 추가
        return wholeNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    function removeCommas(stringWithCommas) {

        // 콤마(,)를 제거하고 숫자만 남기기
        var stringWithoutCommas = stringWithCommas.replace(/,/g, '');
        // 숫자로 변환하여 반환
        return parseFloat(stringWithoutCommas);
    }

</script>
</html>