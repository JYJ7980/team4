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
<style type="text/css">
.has-text-centered {
	text-align: center
}

.has-text-prev {
	background-color: #ECEFF1
}

.has-text-next {
	background-color: #ECEFF1
}

.has-text-primary {
	background-color: #598987
}

.fixed-text {
	width: 100px;
	height: 150px;
	position: relative; /* 부모 요소 기준으로 위치를 설정하기 위해 relative 설정 */
}

.fixed-text .inner-text {
	position: absolute;
	top: 0;
	left: 0;
	width: 20px;
	height: 20px;
	background-color: lightgray; /* 배경색 설정 (선택사항) */
	text-align: center;
}

.fixed-text .ptag {
	margin-left: 0;
}

.has-text-centered {
	text-align: center
}

.has-text-prev {
	background-color: #ECEFF1
}

.has-text-next {
	background-color: #ECEFF1
}

.has-text-primary {
	background-color: #598987
}

.modal {
	display: block;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	margin-left: 100px;
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
	height: 400px;
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

.form-group {
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 17px;
}

.contentArea {
	width: 300px;
	height: 200px;
	resize: none;
}
</style>
<title>관리자시스템</title>
</head>
<body class="page-body">

	<div class="page-container">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />

		<div class="main-content">

			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
				flush="false" />

			<ol class="breadcrumb bc-3">
				<li><a href="#none" onclick="cf_movePage('/system')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>스케쥴 관리</strong></li>
			</ol>

			<h2>${userInfoVO.userId}님의캘린더</h2>
			<br />
			<div class="dataTables_wrapper" id="vueapp">

				<div align="center" style="font-size: 20px;">
					<button @click="calendarData(-1)"><</button>
					{{ year }}년 {{ month }}월
					<button @click="calendarData(1)">></button>
					
				</div>
				<div style="display: flex; justify-content: flex-end; margin-right: 200px;">
						<button type="button" @click="openInsertForm">등록</button>
					</div>
				<table border="1" style="width: 80%;" align="center">
					<thead>
						<!-- 요일 -->
						<tr>
							<th v-for="days in weeks" :key="days" style="text-align: center;">{{
								days }}</th>
						</tr>
					</thead>
					<!-- 날짜 -->
					<tbody>
						<tr v-for="(week, index) in dates" :key="index">
							<td v-for="day in week" :key="day" class="fixed-text">
								<div v-if="day !== 0" style="text-align: left;">
									<div class="inner-text">{{ day }}</div>
									<ul>
										<li v-for="toDo in toDoList"
											v-if="parseInt(toDo.cal_date.substring(8, 10))==day"
											@click="openEditModal(toDo)" class="ptag">
											{{toDo.cal_title}}</li>
									</ul>
									<div v-else></div>
							</td>
						</tr>
						<tr>
						</tr>
					</tbody>
				</table>

				<div v-if="showModal" class="modal">
					<div class="modal-content">
						<span class="close" @click="closeEditModal">&times;</span>

						<div class="form-group">

							<div>
								<div>
									<label for="date">날짜</label> <input type="date" id="date"
										v-model="selected.cal_date">
								</div>
								<br>
								<div>
									<label for="title">제목</label> <input type="text" id="title"
										v-model="selected.cal_title">
								</div>
								<div>
									<div>
										<label for="content">내용 : </label>
									</div>
									<div>
										<textarea rows="5" id="content" v-model="selected.cal_content"
											placeholder="내용을 입력하세요." class="contentArea"></textarea>
									</div>

								</div>
								<div style="display: flex; justify-content: flex-end;">
									<button type="button" @click="updateCal">
										수정<i class="entypo-check"></i>
									</button>
									<button type="button" @click="deleteCal(selected.bn_cal_id)"
										style="margin-left: 20px;">
										삭제 <i class="entypo-check"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div v-if="insertForm" class="modal">
					<div class="modal-content">
						<span class="close" @click="closeInsertForm">&times;</span>
						<div class="form-group">

							<div>
								<div>
									<label for="insert.date">날짜</label> : <input type="date"
										id="insert.date" v-model="insert.date">
								</div>
								<br>
								<div>
									<label for="insert.title">제목</label> : <input type="text"
										id="insert.title" v-model="insert.title">
								</div>
								<div>
									<div>
										<label for="insert.content">내용 : </label>
									</div>
									<div>
										<textarea rows="5" id="insert.content"
											v-model="insert.content" placeholder="내용을 입력하세요."
											class="contentArea"></textarea>
									</div>

								</div>
								<div style="display: flex; justify-content: flex-end;">
									<button type="button" @click="save">
										등록<i class="entypo-check"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>
		</div>
	</div>



	</div>



	<script>
var vueapp = new Vue({
	el: "#vueapp",
	data: {
		weeks: ["일", "월", "화", "수", "목", "금", "토"],
		currentYear: 0,
		currentMonth: 0,
		year: 0,
		month: 0,
		dates: [],
		toDoList: [],
		selected: null,
		showModal: false,
		insertForm: false,
		insert: {
			date:"",
			title:"",
			content:"",
		}
	},
	created() {
		const date = new Date();
		this.year = date.getFullYear();
		this.month = date.getMonth(); // JavaScript의 월은 0부터 시작하므로 +1 해줍니다.
		this.calendarData(0);
	},
	methods: {
		getCalendar(isInit) {
			var params = {
				year: this.year,
				month: this.month,
			}
			


			axios.post('/system/team4/active/calenderDateCal', {params:params})
				.then(response => {
					this.getDataListCB(response.data);
				})
				.catch(error => {
					console.error("Error fetching calendar data:", error);
				});

		},
		calendarData(move) {
			if (move < 0) {
				this.month -= 1;
			} else {
				this.month += 1;
			}
			if (this.month === 0) { // 작년 12월로 넘어가기
				this.year -= 1;
				this.month = 12;
			} else if (this.month > 12) { // 내년 1월로 넘어가기
				this.year += 1;
				this.month = 1;
			}
			  const [
			        monthFirstDay,
			        monthLastDate,
			        lastMonthLastDate,
			      ] = this.getFirstDayLastDate(this.year, this.month);
			      this.dates = this.getMonthOfDays(
			        monthFirstDay,
			        monthLastDate,
			        lastMonthLastDate,
			      ); 
			      
			this.getCalendar(true);
		},
		getListCB(data) {
			this.days = data.days;
			console.log(data);
		},
		 getFirstDayLastDate(year, month) {
		      const firstDay = new Date(year, month - 1, 1).getDay(); // 이번 달 시작 요일
		      const lastDate = new Date(year, month, 0).getDate(); // 이번 달 마지막 날짜
		      let lastYear = year;
		      let lastMonth = month - 1;
		      if (month === 1) {
		        lastMonth = 12;
		        lastYear -= 1;
		      }
		      const prevLastDate = new Date(lastYear, lastMonth, 0).getDate(); // 지난 달 마지막 날짜
		      return [firstDay, lastDate, prevLastDate];
		},
		getMonthOfDays(
		      monthFirstDay,
		      monthLastDate,
		      prevMonthLastDate,
		    ) {
		      let day = 1;
		      let prevDay = (prevMonthLastDate - monthFirstDay) + 1;
		      const dates = [];
		      let weekOfDays = [];
		      while (day <= monthLastDate) {
		        if (day === 1) {
		          // 1일이 어느 요일인지에 따라 테이블에 그리기 위한 지난 셀의 날짜들을 구할 필요가 있다.
		          for (let i = 0; i < monthFirstDay; i += 1) {
		            if (i === 0) this.lastMonthStart = prevDay; // 지난 달에서 제일 작은 날짜
		            weekOfDays.push(0);
		            prevDay += 1;
		          }
		        }
		        weekOfDays.push(day);
		        if (weekOfDays.length === 7) {
		          // 일주일 채우면
		          dates.push(weekOfDays);
		          weekOfDays = []; // 초기화
		        }
		        day += 1;
		      }
		      const len = weekOfDays.length;
		      if (len > 0 && len < 7) {
		        for (let k = 1; k <= 7 - len; k += 1) {
		          weekOfDays.push(0);
		        }
		      }
		      if (weekOfDays.length > 0) dates.push(weekOfDays); // 남은 날짜 추가
		      
		      return dates;
		      
		},
		    getDataListCB : function(data){
		    	this.toDoList = data;
		    },
		    openEditModal(toDo) {
        		this.selected = Object.assign({}, toDo);
        		this.showModal = true;
        	},
        	openInsertForm(){
        		this.insertForm = true;
        	},
        	closeInsertForm(){
        		this.insertForm = false;
        		this.insert = [
        				cal_date="",
        				cal_title="",
        				cal_content=""
        		]
        	},
        	closeEditModal() {
        		this.showModal = false;
        		this.selected = null;
        	},
        	
			updateCal: function () {
				if (!this.selected.cal_title.trim()) {
					alert("제목을 입력하세요.");
					return;
				}

				var params = {
					update_id: this.selected.bn_cal_id,
					update_title: this.selected.cal_title,
					update_content: this.selected.cal_content,
					update_date: this.selected.cal_date
				};

				axios.post('/system/team4/active/calUpdate', { params: params })
					.then(response => {
						if (response.data.status === "OK") {
							alert("저장되었습니다.");
							this.getCalendar(true);
							this.closeEditModal();
						} else {
							alert("저장 실패: " + response.data.message);
						}
					})
					.catch(error => {
						alert("오류 발생: " + error);
					});
			},
			deleteCal(bn_cal_id) {
				if (!confirm('정말로 삭제하시겠습니까?')) return;
				var params = {
					delete_id: bn_cal_id,
				};

				console.log(params);
				axios.post('/system/team4/active/calDelete', { params: params })
					.then(response => {
						if (response.data.status === 'OK') {
							alert('삭제되었습니다.');
							this.getCalendar(true);
							this.closeEditModal();
						} else {
							alert('삭제 실패: ' + response.data.message);
						}
					})
					.catch(error => {
						alert('오류 발생: ' + error);
					});
			},
			save : function (){
				if (!this.insert.title.trim()) {
					alert("제목을 입력하세요.");
					return;
				}
				var params = {
						date : this.insert.date,
						title : this.insert.title,
						content : this.insert.content
				};
				console.log(params);
				axios.post("/system/team4/active/save", {params:params})
					.then(response => {
						if (response.data.status === "OK") {
							alert("저장되었습니다.");
							window.location.href = '/system/team4/active/calender'; // 저장 후 목록으로 이동
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