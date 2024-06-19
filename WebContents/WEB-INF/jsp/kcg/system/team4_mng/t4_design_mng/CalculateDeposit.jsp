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
	
		<h2>프로모션 > 금융계산기 (예금 설계)</h2>
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
                            <li class="nav-tab active" @click="tabChange(3)">예금 설계</li>
                            <li class="nav-tab" @click="tabChange(4)">대출 설계</li>
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
                                <label>예치금액 (원):</label>
                                <input class="form-control flex-50" type="text" id="dpst_amt" v-model="info.sub_money" style="width: 700px;"/>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(10)">+10만원</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(50)">+50만원</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(100)">+100만원</button>
                                <button type="button" class="btn btn-navy flex-20" @click="setCircleAcmlAmt(0)">정정</button>
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>이자유형:</label>
								<select class="form-control" id="int_tax_ty_cd" v-model="info.interest_type" style="padding-top: 3px;">
									<option value="단리">단리</option>
									<option value="복리">복리</option>
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
                                <label>이자과세:</label>
								<select class="form-control" id="int_tax_ty_cd" v-model="info.tax_rate" style="padding-top: 3px;">
									<option value="1">일반과세 (15.4%)</option>
									<option value="2">세금우대 (9.5%)</option>
									<option value="3">비과세</option>
								</select>
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
						<button type="button" class="btn btn-orange btn-small" @click="save()">
							설계저장
						</button>
						<button type="button" class="btn btn-blue btn-icon btn-small" @click="gotoList()">
							목록 <i class="entypo-list"></i>
						</button>
					</div>
					
                    <ul class="nav">
                        <li class="nav-tab active">계산결과</li>
                    </ul>
                    <div class="right-bottom flex-100">
                        <form class="form flex-column" method="POST" action="#">
	                        <table>
	                        	<tr>
	                        		<td class="center" style="width: 40%; vertical-align: top;">
	                        			<div class="form-wrapper flex flex-wrap flex-gap-10">
			                                <div class="form-group">
			                                    <label>예치금액:</label>
			                                    <input class="form-control" id="tot_dpst_amt" v-model="info.sub_money" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>세전이자:</label>
			                                    <input class="form-control" id="tot_dpst_int" v-model="info.before_interest" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <span>수익률:</span>
			                                    <span id="tot_dpst_int"disabled>{{ info.profit_rate }}%</span>
			                                </div>
			                                			                                
			                                <div class="form-group">
			                                    <label>세전수령액:</label>
			                                    <input class="form-control" id="bfo_rcve_amt" v-model="info.rec_before_tax" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>이자과세금:</label>
			                                    <input class="form-control" id="int_tax_amt" v-model="info.interest_tax" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>세후수령액:</label>
			                                    <input class="form-control" id="atx_rcve_amt" v-model="info.rec_after_tax" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <span>순수익률:</span>
			                                    <span id="tot_dpst_int" disabled>{{ info.net_profit_rate }}%</span>
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
													<th style="width: 10%;" class="center">회차</th>
													<th style="width: 23%;" class="center">회차예치금액</th>
													<th style="width: 23%;" class="center">누적예치금액</th>
													<th style="width: 21%;" class="center">회차이자</th>
													<th style="width: 23%;" class="center">회차원리금</th>
												</tr>
											</thead>
											<tbody id="grid_tbody">
											</tbody>
										</table>
	                        		</td>
	                        	</tr>
	                        </table>
                        </form>
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
		info : {
			design_id : "", //설계아이디
			f_interest_rate : "", //고정 금리
			v_interest_rate : "", //변동 금리
			tax_rate : "", //세금 비율
			sub_money : "", //예치 금액
			before_interest : "", //세전 이자
			after_interest : "", //세전 이자			
			rec_before_tax : "", //세전 수령액
			interest_tax : "", //이자과세금
			interest_type: "", //단리인지 복리인지
			rec_after_tax : "", //세후 수령액
			v_select_month : "", //변동 금리 예치 기간
			f_select_month : "", //고정 금리 예치 기간
			profit_rate : "", //수익률
			net_profit_rate : "", //순수익률

		},
		proInfo : {
			product_id : "",
			product_name : "",
		},

		custInfo : {
			customer_phone : "",
			customer_name : "",
			customer_id_number : "",
			customer_id : "",
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
		
		if(!cf_isEmpty(this.info.cust_mbl_telno)){
			this.getCustInfo();
		}
		if(!cf_isEmpty(this.info.prod_ds_sn)){
			this.getDsgInfo();
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
			cf_movePage("/promion_mng/dtl", params);
			
		},
		getDsgInfo : function(){
			cf_ajax("/promion_mng/getDsgInfo", this.info, this.getDsgInfoCB);
		},
		getDsgInfoCB : function(data){
			this.info = data;
			this.info.simpl_ty_cd = "1";
			
			this.prcCalc();
		},
		save : function(){
			
			if(this.info.simpl_ty_cd != "1"){
				alert("정상설계만 저장할 수 있습니다.");
				return;
			}else if(cf_isEmpty(this.custInfo.customer_name)){
				alert("고객정보를 선택하세요.");
				return;
			}
			
	        if (cf_isEmpty(this.info.before_interest) || cf_isEmpty(this.info.rec_before_tax) || 
	                cf_isEmpty(this.info.interest_tax) || cf_isEmpty(this.info.after_interest) || 
	                cf_isEmpty(this.info.rec_after_tax) || cf_isEmpty(this.info.profit_rate) || 
	                cf_isEmpty(this.info.net_profit_rate)) {
	                alert("이자 계산을 먼저 수행하세요.");
	                return;
	            }

			var params = {
		            v_select_month: this.info.v_select_month,
		            v_interest_rate: this.info.v_interest_rate,
		            tax_rate: this.info.tax_rate,
		            sub_money: removeCommas(this.info.sub_money),
		            rec_before_tax: removeCommas(this.info.rec_before_tax),
		            rec_after_tax: removeCommas(this.info.rec_after_tax),
		            profit_rate: this.info.profit_rate,
		            net_profit_rate: this.info.net_profit_rate,
		            interest_type: this.info.interest_type,
		            interest_tax: removeCommas(this.info.interest_tax),
		            f_select_month: this.info.f_select_month,
		            f_interest_rate: this.info.f_interest_rate,
		            before_interest: removeCommas(this.info.before_interest),
		            after_interest: removeCommas(this.info.after_interest),
		            product_id: this.proInfo.product_id,
		            customer_id: this.custInfo.customer_id,
			}
			console.log("=================================")
			console.log(JSON.stringify(params))
				console.log("=================================")
				console.log("실행됨 이제 axios로 넘어가야함")
	            axios.post('/team4/saveCalulate', {params : params})
	        	.then(response => {
					alert("정상등록되었습니다")
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
			
			var a = this.info.f_select_month
			var b = this.info.v_select_month
			console.log(a)
			console.log(b)

			if(cf_isEmpty(this.proInfo.product_id)){
				alert("상품을 선택하세요.");
				return;
			}
			

			if(cf_isEmpty(this.info.sub_money)){
				alert("예치금액을 입력하세요.");
				return;
			}
			if(this.info.sub_money == 0){
				alert("예치금액을 입력하세요.");
				return;
			}
			
		    if (this.info.interest_type === '') {
			       alert('이자유형을 선택하여주세요');
			       return false;
			}
		    
		    if ((this.info.f_interest_rate === '' || this.info.f_interest_rate == 0) && 
				(this.info.v_interest_rate === '' || this.info.v_interest_rate == 0)) {
				alert('이자율을 선택하여주세요');
				return false;
			}
				          


		    if ((this.info.f_select_month === '' || this.info.f_select_month == 0) && 
		       (this.info.v_select_month === '' || this.info.v_select_month == 0)) {
		        alert('예치기간을 작성해주세요');
		        return false;
		    }
		          
		    if (this.info.tax_rate === '') {
		       alert('이자과세를 선택하여주세요');
		       return false;
		    }
		          
			
			
				var f_interest_rate = (this.info.f_interest_rate /100 /12);
				var v_interest_rate = (this.info.v_interest_rate /100 /12);
				var tax_rate ="";				
				
				if(this.info.tax_rate == "1") {
					tax_rate =(15.4/100);
				}
				if(this.info.tax_rate == "2") {
					tax_rate =(9.5/100);
				}
				if(this.info.tax_rate == "3") {
					tax_rate = 0;
				}
				
				if(this.info.interest_type == "단리"){
					
					var before_interest = (this.info.sub_money * f_interest_rate * this.info.f_select_month) + (this.info.sub_money*v_interest_rate*this.info.v_select_month); //세전이자
					var rec_before_tax = this.info.sub_money + before_interest; //세전수령액
					var interest_tax = before_interest * tax_rate; //이자에 대한 세금
					var after_interest = before_interest - interest_tax; //세후 이자
					var rec_after_tax = this.info.sub_money + after_interest //최종금액
					var profit_rate =  ((before_interest / this.info.sub_money) * 100).toFixed(2) ;//수익률
					var net_profit_rate = ((after_interest / this.info.sub_money) * 100).toFixed(2); //순수익률
					
					console.log("profit_rate: " + profit_rate)
					console.log("net_profit_rate: " + net_profit_rate)
					var formattedBeforeInterest = formatNumberWithCommas(before_interest);
					var formattedRecBeforeTax = formatNumberWithCommas(rec_before_tax);
					var formattedInterestTax = formatNumberWithCommas(interest_tax);
					var formattedAfterInterest = formatNumberWithCommas(after_interest);
					var formattedRecAfterTax = formatNumberWithCommas(rec_after_tax);
					
					this.info.sub_money = formatNumberWithCommas(this.info.sub_money);
					this.info.before_interest = formattedBeforeInterest;
					this.info.rec_before_tax = formattedRecBeforeTax;
					this.info.interest_tax = formattedInterestTax;
					this.info.after_interest = formattedAfterInterest;
					this.info.rec_after_tax = formattedRecAfterTax;
					this.info.profit_rate = profit_rate;
					this.info.net_profit_rate = net_profit_rate;

				}
				
				if(this.info.interest_type == "복리"){
					var f_rec_before_tax = this.info.sub_money * ((1 + f_interest_rate) ** this.info.f_select_month ); //고정금리 때 세전 수령액
					var rec_before_tax = (f_rec_before_tax * (Math.pow((1+v_interest_rate), this.info.v_select_month ))); //변동금리까지 적용한 최종 세전 수령액
					console.log("rec_before_tax: " + rec_before_tax)
					var before_interest = (rec_before_tax - this.info.sub_money); //세전이자
					var interest_tax = (before_interest *tax_rate) //이자에 대한 세금
					var after_interest = before_interest - interest_tax; //세후 이자
					var rec_after_tax = this.info.sub_money + after_interest; //최종금액
					var profit_rate =  ((before_interest / this.info.sub_money) * 100).toFixed(2) ;//수익률
					var net_profit_rate = ((after_interest / this.info.sub_money) * 100).toFixed(2); //순수익률
					
					var formattedBeforeInterest = formatNumberWithCommas(before_interest);
					var formattedRecBeforeTax = formatNumberWithCommas(rec_before_tax);
					var formattedInterestTax = formatNumberWithCommas(interest_tax);
					var formattedAfterInterest = formatNumberWithCommas(after_interest);
					var formattedRecAfterTax = formatNumberWithCommas(rec_after_tax);

					this.info.sub_money = formatNumberWithCommas(this.info.sub_money);
					this.info.before_interest = formattedBeforeInterest;
					this.info.rec_before_tax = formattedRecBeforeTax;
					this.info.interest_tax = formattedInterestTax;
					this.info.after_interest = formattedAfterInterest;
					this.info.rec_after_tax = formattedRecAfterTax;
					this.info.profit_rate = profit_rate;
					this.info.net_profit_rate = net_profit_rate;

				}

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
		pop_product_type:"예금",

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