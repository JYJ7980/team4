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
<meta charset="UTF-8">

<title>대시보드</title>
<!-- Vue.js CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
<!-- axios CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style type="text/css">
.person_icon {
	margin-left: 20px;
	width: 70px;
	height: 70px;
}

.event {
	color: white;
	display: flex;
	align-items: center;
	margin-left: 50px;
	width: 300px;
	height: 100px;
	background-color: rgba(0, 0, 0, 0.7);
	border-radius: 50px;
	display: flex;
}

.notice_icon {
	margin-left: 30px;
	width: 80px;
	height: 50px;
}

.noticediv {
	position: absolute;
	right: 40px;
	bottom: 20px;
	display: flex;
	align-items: center;
	margin-left: 50px;
	height: 80px;
	background-color: rgba(0, 0, 0, 0.7);
	border-radius: 50px;
	width: 700px;
}

.product {
	position: fixed;
	width: 1300px;
	height: 220px;
	margin-left: 200px;
	margin-right: 100px;
	margin-top: 20%;
	display: flex;
	justify-content: center;
	align-items: center;
}

.productdiv {
	display: flex;
	justify-content: center;
	width: 200px;
	height: 200px;
	margin: 10px;
	background-color: white;
	flex-direction: column;
	align-items: center;
	background-color: #8ABCFF;
	border-radius: 20px;
}

.productType {
	width: 60px;
	height: 25px;
	border: 2px solid;
	justify-content: center;
	display: flex;
	border-color: #0075B5;
	border-radius: 50px;
	text-align: center;
	align-items: center;
	margin-top: 10px;
	color: #0075B5;
}

.pig_icon {
	margin-top: 10px;
	margin-left: -10px;
	width: 100px;
	height: 100px;
}

.home_icon {
	margin-top: 20px;
	width: 140px;
	height: 90px;
}

.loan_icon {
	margin-top: 24px;
	margin-bottom: 13px; width : 100px;
	height: 70px;
	width: 100px;
}

.pri_icon {
	margin-top: 15px;
	width: 120px;
	height: 100px;
	margin-bottom: -5px;
}

.event_icon {
	margin-top: 15px;
	width: 110px;
	height: 100px;
	margin-bottom: -5px;
}

.icons {
	position: fixed;
	margin-top: 15%;
	margin-left: 15%;
}

</style>
</head>
<body class="page-body" data-url="http://neon.dev">

	<div class="page-container" class="main-content"
		style="background-image: url('/static_resources/system/images/money-background.png'); background-size: cover; background-position: center; repeat: no-repeat">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/team4/sidebar-menu.jsp"
			flush="false" />

		<div style="opacity: 0.9">

			<!-- 헤더 -->
			<jsp:include page="/WEB-INF/jsp/kcg/_include/team4/header.jsp"
				flush="false" />

			<ol class="breadcrumb bc-3">
				<li><a href="#none" onclick="cf_movePage('/system/team4/main')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>대시보드</strong></li>
			</ol>
			<div id="vue">
				<div class="event">
					<img src="/static_resources/system/images/person.png"
						class="person_icon">
					<div style="margin-left: 20px; font-size: 18px;">
						<div style="font-weight: 700;">TODAY</div>
						<div>
							<a href="/system/team4/event/eventCalender"
								style="text-decoration: none; color: white;">고객 생일 :
								{{birthDay}}</a>
						</div>
						<div>
							<a href="/system/team4/event/eventCalender"
								style="text-decoration: none; color: white;">상품 만료 고객 :
								{{end}}</a>
						</div>
					</div>
				</div>

				<div class="product" style="display: flex;">
					<div class="productdiv">
						<div class="productType">예금</div>
						<div class="">
							<img src="/static_resources/system/images/pig.png"
								class="pig_icon"  @click="gotoDtl(deposit.product_id)">
						</div>
						<br>
						<div
							style="align-items: center; justify-content: center; color: white;">
							<div align="center">
								{{deposit.product_name}}<br> 대상 :
								{{deposit.possible_member}}
							</div>
						</div>
					</div>
					<div class="productdiv">
						<div class="productType">적금</div>
						<img src="/static_resources/system/images/home.png"
							class="home_icon" @click="gotoDtl(savings.product_id)"><br>
						<div
							style="align-items: center; justify-content: center; color: white;">
							<div align="center">
								{{savings.product_name}}<br> 대상 :
								{{savings.possible_member}}
							</div>
						</div>
					</div>
					<div class="productdiv">
						<div class="productType">대출</div>
						<img src="/static_resources/system/images/loan.png"
							class="loan_icon" @click="gotoDtl(loan.product_id)"><br>
						<div
							style="align-items: center; justify-content: center; color: white;">
							<div align="center">
								{{loan.product_name}}<br> 대상 : {{loan.possible_member}}
							</div>
						</div>
					</div>
					<div class="productdiv">
						<div class="productType">특별</div>
						<img src="/static_resources/system/images/프리미엄.png"
							class="pri_icon" @click="gotoDtl(event.product_id)"><br>
						<div
							style="align-items: center; justify-content: center; color: white;">
							<div align="center">
								{{event.product_name}}<br> 대상 : {{event.possible_member}}
							</div>
						</div>
					</div>
					<div class="productdiv">
						<div class="productType">인기</div>
						<img src="/static_resources/system/images/event.png"
							class="event_icon"  @click="gotoDtl(popular.product_id)"><br>
						<div
							style="align-items: center; justify-content: center; color: white;">
							<div align="center">
								{{popular.product_name}}<br> 대상 : {{popular.possible_member}}
							</div>
						</div>
					</div>
					<div class="productdiv">
						
						<img src="/static_resources/system/images/바로가기.png"
							class="pri_icon" @click="gotoList"><br>
						<div
							style="align-items: center; justify-content: center; color: white;">
							<div align="center" style="font-size: 18px;">
								상품목록보기
							</div>
						</div>
					</div>
				</div>
				<!-- 				공지사항 -->
				<div class="noticediv">
					<img src="/static_resources/system/images/megaphone.png"
						class="notice_icon">
					<div style="margin-left: 30px; font-size: 15px;">
						<div v-for="notice in notices">
							<a href="/system/team4/notice/"
								style="text-decoration: none; color: white;">ㆍ
								{{notice.notice_title}} ( {{notice.cor_date}} )</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
	var vueapp = new Vue({
		el: "#vue",
		data: {
			birthDay: '',
			end:'',
			notices : [],
			deposit : [],
			savings : [],
			loan : [],
			event : [],
			popular : [],
		},
		 mounted() {
            this.getAll();
        },
        methods: {
        	getAll() {
        		//오늘 생일 고객
                axios.get('/system/team4/birthDay')
                    .then(response => {
                    	this.getBirthDayCB(response.data);
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
                //오늘 상품 만기인 고객 수
                axios.get('/system/team4/end')
                .then(response => {
                	this.getEndCB(response.data);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
                // 최근 공지사항 2개
                axios.get('/system/team4/noticeTop2')
                .then(response => {
                	this.notices = response.data;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
               //최신 예금 상품
                axios.get('/system/team4/deposit')
                .then(response => {
                	this.deposit = response.data;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
                //최신 적금 상품
                axios.get('/system/team4/savings')
                .then(response => {
                	this.savings = response.data;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
                //최신 대출 상품
                axios.get('/system/team4/loan')
                .then(response => {
                	this.loan = response.data;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
                //최신 이벤트 상품
                axios.get('/system/team4/event')
                .then(response => {
                	this.event = response.data;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
                //인기 상품
                axios.get('/system/team4/popular')
                .then(response => {
                	this.popular = response.data;
                })
                .catch(error => {
                    console.error('Error:', error);
                });

                
        	},
        	 getBirthDayCB(data) {
                // 'data'는 JSON 형식의 객체일 것으로 가정
                if (data && data.count !== undefined) {
                    this.birthDay = data.count.toString(); // count 값을 문자열로 변환하여 할당
                } else {
                    console.error('올바르지 않은 데이터 형식입니다:', data);
                }
            },
            getEndCB(data) {
                // 'data'는 JSON 형식의 객체일 것으로 가정
                if (data && data.count !== undefined) {
                    this.end = data.count.toString(); // count 값을 문자열로 변환하여 할당
                } else {
                    console.error('올바르지 않은 데이터 형식입니다:', data);
                }
            },
            gotoDtl : function(product_id) {
				var params = {
					product_id : cf_defaultIfEmpty(product_id, ""),
				}
				cf_movePage("/system/team4/product/dtl", params);
			},
			gotoList : function() {
				cf_movePage('/system/team4/product/list');
			},
       
	}
	
	});

	</script>

</body>
</html>