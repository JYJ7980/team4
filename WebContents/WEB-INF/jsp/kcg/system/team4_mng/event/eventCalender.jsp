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
   	<link rel="stylesheet"
	href="/static_resources/team4/css/Calender.css">

<title>관리자시스템</title>
</head>
<body class="page-body">

   <div class="page-container">
		<jsp:include page="/WEB-INF/jsp/kcg/_include/team4/sidebar-menu.jsp"
			flush="false" />

      <div class="main-content" style="background-image: url('/static_resources/team4/images/background-test.png'); background-size: cover; background-position: center; repeat: no-repeat">
			<jsp:include page="/WEB-INF/jsp/kcg/_include/team4/header.jsp"
				flush="false" />


         <ol class="breadcrumb bc-3">
            <li><a href="#none" onclick="cf_movePage('/system')"><i
                  class="fa fa-home"></i>Home</a></li>
            <li class="active"><strong>스케쥴 관리</strong></li>
         </ol>

         <h2>${userInfoVO.name}님의 고객 캘린더</h2>
         <br />
         <div class="dataTables_wrapper" id="vueapp">

            <div align="center" style="font-size: 25px; color: black;">
					<button @click="calendarData(-1)" class="btn-pink"><</button>
					{{ year }}년 {{ month }}월
					<button @click="calendarData(1)" class="btn-pink">></button>

				</div>
            <table border="1" style=" width: 80%; background-color: white; border-color: #80D9E1; border-top-left-radius: 50px; border-top-right-radius: 50px;" align="center">
				   <thead>
                  <!-- 요일 -->
                  <tr>
                     <tr>
							<th v-for="days in weeks" :key="days" style="text-align: center; height: 25px; font-size: 18px; color: white; background-color:#80D9E1; font-weight: 700; ">{{
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
                                 v-if="parseInt(toDo.customer_brdt.substring(4, 6))==day"
                                 class="ptag">{{toDo.customer_name}}님의 생일</li>
                              <li v-for="end in endList"
                                 v-if="parseInt(end.sub_end_date.substring(8, 10))==day"
                                 class="ptag">{{end.customer_name}}님의 상품만기</li>
                           </ul>
                           <div v-else></div>
                     </td>
                  </tr>
                  <tr>
                  </tr>
               </tbody>
            </table>
         </div>
      </div>
   </div>



   </div>



   <script>
var vueapp = new Vue({
   el: "#vueapp",
   data: {
      weeks: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
      currentYear: 0,
      currentMonth: 0,
      year: 0,
      month: 0,
      dates: [],
      toDoList: [],
      endList:[],
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
         
         axios.post('/system/team4/event/eventFind', {params:params})
            .then(response => {
               this.getDataListCB(response.data);
            })
            .catch(error => {
               console.error("이벤트 호출 에러", error);
            });
         
         
         axios.post('/system/team4/event/eventFindPlus', {params:params})
         .then(response => {
            this.getDataListPlusCB(response.data);
         })
         .catch(error => {
            console.error("이벤트 호출 에러", error);
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
          getDataListPlusCB : function(data){
             this.endList = data;
          },

   }
});
</script>
</body>
</html>