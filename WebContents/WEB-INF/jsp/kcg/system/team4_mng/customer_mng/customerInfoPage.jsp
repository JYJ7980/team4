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
.input-form {
	margin-bottom: 10px;
}

.input-form label {
	display: block;
	font-weight: bold;
}

/* Flexbox 레이아웃 스타일 */
.customer-container {
	display: flex;
	justify-content: space-between;
}

.customer-details {
	flex: 1;
	padding: 10px;
	border: 1px solid #ccc;
}

.customer-table {
	flex: 1;
}
</style>
</head>
<body class="page-body">

	<div class="page-container">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />

		<div id="app" style="margin-left: 70px;">
			<span style="font-size: 18px; font-weight: bold; color: black;">${userInfoVO.userId}</span>&nbsp;님
			화면 <br> <a href="/system/team4/main">메인으로 돌아가기</a><br>
			<div id="customerTable" class="customer-container">
				<div class="customer-table">
					<h4>고객 정보 관리</h4>
					<div>
						<br> <input id="keywordInput" type="text" name="keyword"
							v-model="searchKeyword" class="inputtext" placeholder="이름을 입력하세요">
						<button @click="searchCustomers">조건 검색</button>
					</div>
					<br>
					<div>
						<!-- 전체 조회 버튼 -->
						<br>
						<button @click="getAllCustomers">전체 조회</button>
						<br>
					</div>
					<!--       <div id="customerTable" class="customer-container"> -->
					<!--          <div class="customer-table"> -->
					<!-- 고객 정보 테이블 -->
					<h2 v-show="filteredCustomers.length > 0">전체 고객 정보</h2>
					<table border='1' v-show="filteredCustomers.length > 0">
						<tr>
							<th>Select</th>
							<th>이름</th>
							<th>생년월일</th>
						</tr>
						<tr v-for="customer in filteredCustomers"
							:key="customer.customer_id">
							<td><input type="radio" name="selectedCustomer"
								v-model="selectedCustomer" :value="customer"></td>
							<td>{{ customer.customer_name }}</td>
							<td>{{ customer.customer_brdt }}</td>
						</tr>
					</table>
				</div>
				<!-- 선택된 고객의 상세 정보 입력 폼 -->
				<div class="customer-details" v-if="selectedCustomer !== null">
					<h2>고객 정보</h2>
					<div class="input-form">
						<label for="customerSubDate">등록일</label> <input type="text"
							id="customerSubDate" v-model="selectedCustomer.customer_sub_date"
							readonly>
					</div>
					<div class="input-form">
						<label for="customerName">고객 이름</label> <input type="text"
							id="customerName" v-model="selectedCustomer.customer_name">
					</div>
					<div class="input-form">
						<label for="customerIdNumber">고객 주민번호</label> <input type="text"
							id="customerIdNumber"
							:value="maskIdNumber(selectedCustomer.customer_id_number)"
							readonly>
						<button @click="toggleMasking">확인</button>
					</div>
					<div class="input-form">
						<label for="customerLevel">고객 등급</label> <select
							id="customerLevel" v-model="selectedCustomer.customer_level">
							<option value="1">일반</option>
							<option value="2">우수</option>
							<option value="3">VIP</option>
							<option value="4">VVIP</option>
							<option value="5">플래티넘</option>
						</select>

					</div>
					<div class="input-form">
						<label for="customerPhone">고객 전화번호</label> <input type="text"
							id="customerPhone" v-model="selectedCustomer.customer_phone">
					</div>
					<div class="input-form">
						<label for="customerSubTel">고객 비상연락망</label> <input type="text"
							id="customerSubTel" v-model="selectedCustomer.customer_sub_tel">
					</div>
					<div class="input-form">
						<label for="customerEmail">고객 이메일</label> <input type="text"
							id="customerEmail" v-model="selectedCustomer.customer_email">
					</div>
					<div class="input-form">
						<label for="customerJob">고객 직업</label> <input type="text"
							id="customerJob" v-model="selectedCustomer.customer_job">
					</div>
					<div class="input-form">
						<label for="customerAddr">고객 주소</label> <input type="text"
							id="customerAddr" v-model="selectedCustomer.customer_addr">
					</div>
					<br>
					<button @click="deleteCustomer">삭제</button>
					<button @click="updateCustomer">수정</button>
					<button @click="resetForm">신규</button>

					<br> <br>
					<h2>관리자 정보</h2>
					<div class="input-form">
						<label for="userName">관리자 이름</label> <input type="text"
							id="userName" value="${userInfoVO.name}" disabled>
					</div>
					<div class="input-form">
						<label for="userDept">관리자 부서</label> <input type="text"
							id="userDept" value="${userInfoVO.dept}" disabled>
					</div>
					<div class="input-form">
						<label for="userjikgub">관리자 직급</label> <input type="text"
							id="userjikgub" value="${userInfoVO.jikgubNm}" disabled>
					</div>
					<!-- 필요한 입력 폼 추가 -->
				</div>
				<div class="customer-details" v-else>
					<!-- 선택된 고객이 없는 경우의 메시지 -->
					<p>고객을 신규 등록해 주세요.</p>
					<p>**표시는 필수 입력값 입니다. [최조 등록 시 고객 등급은 일반 등급으로 등록]</p>
					<h2>고객 정보</h2>
					<div class="input-form">
						<label for="customerName">**고객 이름</label> <input type="text"
							id="customerName" v-model="customerName" required>
					</div>
					<div class="input-form">
						<label for="customerIdNumber">**고객 주민번호</label> <input type="text"
							id="customerIdNumber" v-model="customerIdNumber" required
							maxlength="14"> <small>예시: YYMMDD-1234567</small>
					</div>
					<div class="input-form">
						<label for="customerPhone">**고객 전화번호</label> <input type="text"
							id="customerPhone" v-model="customerPhone" required>
					</div>
					<div class="input-form">
						<label for="customerSubTel">**고객 비상연락망</label> <input type="text"
							id="customerSubTel" v-model="customerSubTel">
					</div>
					<div class="input-form">
						<label for="customerEmail">**고객 이메일</label> <input type="email"
							id="customerEmail" v-model="customerEmail" required>
					</div>
					<div class="input-form">
						<label for="customerJob">고객 직업</label> <input type="text"
							id="customerJob" v-model="customerJob">
					</div>
					<div class="input-form">
						<label for="customerAddr">고객 주소</label> <input type="text"
							id="customerAddr" v-model="customerAddr">
					</div>
					<br>


					<button @click="addCustomer">등록</button>
					<button @click="resetForm">초기화</button>
					<h2>관리자 정보</h2>
					<div class="input-form">
						<label for="userName">관리자 이름</label> <input type="text"
							id="userName" value="${userInfoVO.name}" disabled>
					</div>
					<div class="input-form">
						<label for="userDept">관리자 부서</label> <input type="text"
							id="userDept" value="${userInfoVO.dept}" disabled>
					</div>
					<div class="input-form">
						<label for="userjikgub">관리자 직급</label> <input type="text"
							id="userjikgub" value="${userInfoVO.jikgubNm}" disabled>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
new Vue({
    el: '#app',
    data: {
        customers: [], // 고객 정보를 저장할 배열
        filteredCustomers: [], // 필터된 고객 정보를 저장할 배열
        selectedCustomer: null, // 선택된 고객 정보
        userId: '${userInfoVO.userId}', // 현재 사용자의 userId를 저장
        customerSubDate:'',
        customerName: '', // 고객 이름을 저장할 변수
        customerIdNumber:'',
        customerLevel:'',
        customerPhone: '',
        customerSubTel: '',
        customerEmail:'', // 고객 이메일을 저장할 변수
        customerJob: '', 
        customerAddr: '',
        searchKeyword: '', // 검색 키워드 저장
        errorMessage: '', // 오류 메시지 저장
        showFullIdNumber: false, // 주민등록번호 표시 여부를 저장하는 데이터 변수
    },
    methods: {
        getAllCustomers: function() {
            // AJAX 요청을 보내고 응답 데이터를 customers에 할당
            axios.get('/system/team4/getCustInfo')
                .then(response => {
                    this.customers = response.data;
                    this.filterCustomers(); // 고객 필터링 함수 호출
                    this.selectedCustomer = null; // 선택 고객 초기화
                    
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        },
        filterCustomers: function() {
            // userInfoVO.userId와 customer.user_id가 같은 고객만 필터링
            this.filteredCustomers = this.customers.filter(customer => customer.user_id === this.userId);
        },
        toggleMasking: function() {
            // 현재 마스킹 상태를 확인하여 토글
            this.showFullIdNumber = !this.showFullIdNumber;
        },

        maskIdNumber: function(idNumber) {
            // 예시: 문자열로 변환 후 8자리까지만 표시하고 나머지는 '*'로 대체
            if (!this.showFullIdNumber) {
                if (idNumber && typeof idNumber === 'string') {
                    return idNumber.substring(0, 8) + '*'.repeat(idNumber.length - 8);
                } else {
                    return '';
                }
            } else {
                // 마스킹 해제 상태에서는 원래의 주민등록번호 표시
                return idNumber;
            }
        },

        searchCustomers: function() {
            if (this.searchKeyword.trim() === '') {
                alert('검색어를 입력하세요.');
                return;
            }
            axios.get('/system/team4/getCustInfo')
                .then(response => {
                    this.customers = response.data;
                    this.filteredCustomers = this.customers.filter(customer => 
                        customer.user_id === this.userId && 
                        customer.customer_name.includes(this.searchKeyword)
                    );
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        },
        deleteCustomer: function() {
            if (this.selectedCustomer !== null) {
                // 확인 메시지 추가
                if (confirm('정말로 고객을 삭제하시겠습니까?')) {
                    var params = {
                        customer_id: this.selectedCustomer.customer_id
                    };
                    console.log(params);
                    axios.post('/system/team4/deleteCust', { params: params })
                        .then(response => {
                            if (response.data.status === 'OK') {
                                alert('고객이 삭제되었습니다.');
                                this.getAllCustomers(); // 고객 목록을 다시 불러옵니다.
                                this.selectedCustomer = null; // 선택된 고객 초기화
                            } else {
                                alert('고객 삭제에 실패했습니다.');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
                }
            } else {
                alert('삭제할 고객을 선택해주세요.');
            }
        },
        updateCustomer: function() {
            // 선택된 고객이 존재하는지 확인
            if (this.selectedCustomer !== null) {
                // 서버에 보낼 고객 정보 준비
                var params = {
                    customer_id: this.selectedCustomer.customer_id,
                    customer_name: this.selectedCustomer.customer_name,
                    customer_id_number: this.selectedCustomer.customer_id_number,
                    customer_level: this.selectedCustomer.customer_level,
                    customer_phone: this.selectedCustomer.customer_phone,
                    customer_sub_tel: this.selectedCustomer.customer_sub_tel,
                    customer_email: this.selectedCustomer.customer_email,
                    customer_job: this.selectedCustomer.customer_job,
                    customer_addr: this.selectedCustomer.customer_addr
                };
             
 
                // 서버에 PUT 또는 POST 요청 보내기 (수정에 따라 다름)
                axios.put('/system/team4/updateCust', { params: params })
                    .then(response => {
                        if (response.data.status === 'OK') {
                            alert('고객 정보가 수정되었습니다.');
                            // 수정된 고객 정보를 다시 불러오기
                            this.getAllCustomers();
                        } else if (response.data.status === 'ERROR') {
                            alert(response.data.message); // 서버로부터 받은 에러 메시지를 표시
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('고객 정보 수정 중 오류가 발생했습니다.');
                    });
            } else {
                alert('수정할 고객을 선택해주세요.');
            }
        },
        addCustomer: function() {
        	
        	//폼에 비어있는 칸이 있나 확인하기
        	 if (
        this.customerName.trim() === '' ||
        this.customerIdNumber.trim() === '' ||
       
        this.customerPhone.trim() === '' ||
        this.customerSubTel.trim() === '' ||
        this.customerEmail.trim() === ''
    ) {
        alert('모든 필수 입력 필드를 입력해주세요.');
        return; 
    }
        	   // 주민등록 번호 자릿수 확인 (YYMMDD-1234567 형식으로 입력될 것을 가정)
             if (this.customerIdNumber.trim().length !== 14) {
                 this.errorMessage = alert('올바른 주민등록 번호 형식이 아닙니다. YYMMDD-1234567 형식으로 입력해주세요.');
                 return;
             }
        	
            // 새로운 고객 정보 생성
            var params = {
                customer_name: this.customerName,
                customer_id_number: this.customerIdNumber,
                customer_phone: this.customerPhone,
                customer_sub_tel: this.customerSubTel,
                customer_email: this.customerEmail,
                customer_job: this.customerJob,
                customer_addr: this.customerAddr,
                user_id: this.userId // 현재 사용자의 userId 추가
            };

            // 서버에 POST 요청으로 새로운 고객 등록
            axios.post('/system/team4/addCust', { params: params })
                .then(response => {
                    if (response.data.status === 'OK') {
                        alert('새로운 고객이 등록되었습니다.');
                        this.getAllCustomers(); // 고객 목록을 다시 불러옵니다.
                        this.resetForm(); // 입력 폼 초기화
                    }else if (response.data.status === 'ERROR') {
                        this.errorMessage = response.data.message; // 오류 메시지 저장
                        alert(response.data.message); // 사용자에게 오류 메시지 alert으로 표시
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('고객 등록 중 오류가 발생했습니다.');
                });
        },
        resetForm: function() {
            // 입력 폼 데이터 초기화
            this.selectedCustomer = null; // 선택된 고객 초기화
            this.customerName = ''; // 고객 이름 초기화
            this.customerIdNumber = ''; // 고객 주민번호 초기화
            this.customerLevel = ''; // 고객 등급 초기화
            this.customerPhone = ''; // 고객 전화번호 초기화
            this.customerSubTel = ''; // 고객 비상연락망 초기화
            this.customerEmail = ''; // 고객 이메일 초기화
            this.customerJob = ''; // 고객 직업 초기화
            this.customerAddr = ''; // 고객 주소 초기화
        }
    },
    


    mounted: function() {
        // 페이지 로딩 시 초기화
        this.selectedCustomer = null;
    }
});
</script>
</body>
</html>



