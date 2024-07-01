<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="sidebar-menu">

	<div class="sidebar-menu-inner">

		<header class="logo-env">

			<!-- logo -->
			<div class="logo">
				<a href="#gm" onclick="cf_movePage('/system/team4/main')"> <img
					src="/static_resources/system/images/gsitm.jpg" width="120" alt="" />
				</a>
			</div>

			<!-- logo collapse icon -->
			<!-- 				<div class="sidebar-collapse"> -->
			<!-- 					<a href="#" class="sidebar-collapse-icon"> -->
			<!-- 						<i class="entypo-menu"></i> -->
			<!-- 					</a> -->
			<!-- 				</div> -->


			<!-- open/close menu icon (do not remove if you want to enable menu on mobile devices) -->
			<div class="sidebar-mobile-menu visible-xs">
				<a href="#" class="with-animation"> <!-- add class "with-animation" to support animation -->
					<i class="entypo-menu"></i>
				</a>
			</div>

		</header>


		<ul id="main-menu" class="main-menu">
			<li data-lnb="1" data-snb="0"><a href="#gm"
				onclick="cf_movePage('/system/team4/main')"> <i
					class="entypo-newspaper"></i> <span class="title">대시보드
						</span>
			</a></li>
			<c:if test="${userInfoVO.jikgubCd != '1'}">
				<li data-lnb="5" data-snb="0"><a href="#gm"> <i
						class="entypo-newspaper"></i> <span class="title">team
							4_고객관리</span>
				</a>
				<c:if test="${userInfoVO.jikgubCd == '2'}">
					<ul data-lnb="5" data-snb="0">
						<li data-lnb="5" data-snb="1"><a href="#gm"
							onclick="cf_movePage('/system/team4/customerInfoPageForLeader')">
								<span class="title">고객관리</span>
						</a></li>


					</ul>
					</c:if>
					<c:if test="${userInfoVO.jikgubCd != '2'}">
					<ul data-lnb="5" data-snb="0">
						<li data-lnb="5" data-snb="1"><a href="#gm"
							onclick="cf_movePage('/system/team4/customerInfoPage')"> <span
								class="title">고객관리</span>
						</a></li>
					</ul>
					</c:if>
					<c:if test="${userInfoVO.jikgubCd != '1'}">
					<ul data-lnb="5" data-snb="0">
						<li data-lnb="5" data-snb="1"><a href="#gm"
							onclick="cf_movePage('/system/team4/consultListPage')">
								<span class="title">상담내역</span>
						</a></li>
					</ul>
					</c:if>
					<ul data-lnb="5" data-snb="0">
						<li data-lnb="5" data-snb="1"><a href="#gm"
							onclick="cf_movePage('/system/team4/event/eventCalender')"> <span
								class="title">고객 이벤트</span>
						</a></li>
					</ul>
					
					<c:if test="${userInfoVO.jikgubCd == '2'}">
					<ul data-lnb="5" data-snb="0">
						<li data-lnb="5" data-snb="1"><a href="#gm"
							onclick="cf_movePage('/system/team4/quitCustomerInfoPage')">
								<span class="title">탈퇴회원 복구</span>
						</a></li>

					</ul>
					</c:if>
					</li>
			</c:if>

			<li data-lnb="5" data-snb="0"><a href="#gm"> <i
					class="entypo-newspaper"></i> <span class="title">team
						4_상품관리</span>
			</a>
				<c:if test="${userInfoVO.jikgubCd != '1'}">
				<ul data-lnb="5" data-snb="0">
					<li data-lnb="5" data-snb="1"><a href="#gm"
						onclick="cf_movePage('/team4/subscriptionList')"> <span
							class="title">상품가입</span>
					</a></li>

				</ul>
				</c:if>
				<ul data-lnb="5" data-snb="0">
					<li data-lnb="5" data-snb="1"><a href="#gm"
						onclick="cf_movePage('/system/team4/product/list')"> <span
							class="title">상품목록</span>
					</a></li>


				</ul>
				<ul data-lnb="5" data-snb="0">
					<li data-lnb="5" data-snb="1"><a href="#gm"
						onclick="cf_movePage('/system/team4/product/endList')"> <span
							class="title">종료상품목록</span>
					</a></li>


				</ul></li>
				<c:if test="${userInfoVO.jikgubCd == '1'}">
			<li data-lnb="5" data-snb="0"><a href="#gm"> <i
					class="entypo-newspaper"></i> <span class="title">team
						4_직원관리</span>
			</a>
				<ul data-lnb="5" data-snb="0">
					<li data-lnb="5" data-snb="1"><a href="#gm"
						onclick="cf_movePage('/system/team4/employee/employeeList')">
							<span class="title">직원 목록</span>
					</a></li>


				</ul>

					<ul data-lnb="5" data-snb="0">
					<li data-lnb="5" data-snb="1"><a href="#gm"
						onclick="cf_movePage('/system/team4/employee/quitUserInfoPage')">
							<span class="title">퇴사 직원 관리</span>
					</a></li>
				</ul>
				
				</li>
				</c:if>
			<li data-lnb="5" data-snb="0"><a href="#gm"> <i
					class="entypo-newspaper"></i> <span class="title">team
						4_활동관리</span>
			</a>
				<ul data-lnb="5" data-snb="0">
					<li data-lnb="5" data-snb="1"><a href="#gm"
						onclick="cf_movePage('/system/team4/active/calender')"> <span
							class="title">캘린더</span>
					</a></li>


				</ul>
				<ul data-lnb="5" data-snb="0">
					<li data-lnb="5" data-snb="1"><a href="#gm"
						onclick="cf_movePage('/system/team4/notice/')"> <span
							class="title">공지사항</span>
					</a></li>
				</ul></li>
				<c:if test="${userInfoVO.jikgubCd != '1'}">
			<li data-lnb="5" data-snb="0"><a href="#gm"> <i
					class="entypo-newspaper"></i> <span class="title">team 4_상품
						설계</span>
			</a>
				<ul data-lnb="5" data-snb="0">
					<li data-lnb="5" data-snb="1"><a href="#gm"
						onclick="cf_movePage('/team4/designList')"> <span class="title">설계내역 목록</span>
					</a></li>
				</ul>
				
				<ul data-lnb="5" data-snb="0">
					<li data-lnb="5" data-snb="1"><a href="#gm"
						onclick="cf_movePage('/team4/calculate')"> <span class="title">금융계산기</span>
					</a></li>
				</ul></li>
				</c:if>
		</ul>
	</div>

</div>
<script>
	var menulvlconst = [ {
		lnb : 1,
		snb : 0,
		url : "/system/user_mng/list"
	}, {
		lnb : 1,
		snb : 0,
		url : "/system/user_mng/dtl"
	},

	{
		lnb : 2,
		snb : 1,
		url : "/system/menu_mng/list"
	}, {
		lnb : 2,
		snb : 1,
		url : "/system/menu_mng/dtl"
	},

	{
		lnb : 3,
		snb : 1,
		url : "/system/req_mng/dnld/list"
	}, {
		lnb : 3,
		snb : 1,
		url : "/system/req_mng/dnld/dtl"
	}, {
		lnb : 3,
		snb : 2,
		url : "/system/req_mng/dataCollect/list"
	}, {
		lnb : 3,
		snb : 2,
		url : "/system/req_mng/dataCollect/dtl"
	},
	//    {lnb : 3, snb : 3, url : "/system/req_mng/dataAnal/list"},
	//    {lnb : 3, snb : 3, url : "/system/req_mng/dataAnal/dtl"},
	{
		lnb : 3,
		snb : 4,
		url : "/system/req_mng/analTool/list"
	}, {
		lnb : 3,
		snb : 4,
		url : "/system/req_mng/analTool/dtl"
	},

	//    {lnb : 4, snb : 1, url : "/system/share_mng/useExample/list"},
	//    {lnb : 4, snb : 1, url : "/system/share_mng/useExample/dtl"},
	{
		lnb : 4,
		snb : 1,
		url : "/system/share_mng/dataVisualization/list"
	}, {
		lnb : 4,
		snb : 1,
		url : "/system/share_mng/dataVisualization/dtl"
	}, {
		lnb : 4,
		snb : 2,
		url : "/system/share_mng/analIdea/list"
	}, {
		lnb : 4,
		snb : 2,
		url : "/system/share_mng/analIdea/dtl"
	}, {
		lnb : 4,
		snb : 3,
		url : "/system/reg_mng/shareDoc/list"
	}, {
		lnb : 4,
		snb : 3,
		url : "/system/reg_mng/shareDoc/dtl"
	},

	{
		lnb : 5,
		snb : 1,
		url : "/system/communi_mng/news/list"
	}, {
		lnb : 5,
		snb : 1,
		url : "/system/communi_mng/news/dtl"
	}, {
		lnb : 5,
		snb : 2,
		url : "/system/communi_mng/library/list"
	}, {
		lnb : 5,
		snb : 2,
		url : "/system/communi_mng/library/dtl"
	}, {
		lnb : 5,
		snb : 3,
		url : "/system/communi_mng/inquire/list"
	}, {
		lnb : 5,
		snb : 3,
		url : "/system/communi_mng/inquire/dtl"
	}, {
		lnb : 5,
		snb : 4,
		url : "/system/communi_mng/bigdataTrend/list"
	}, {
		lnb : 5,
		snb : 4,
		url : "/system/communi_mng/bigdataTrend/dtl"
	},

	{
		lnb : 6,
		snb : 1,
		url : "/system/etc_mng/popup/list"
	}, {
		lnb : 6,
		snb : 1,
		url : "/system/etc_mng/popup/dtl"
	}, {
		lnb : 6,
		snb : 2,
		url : "/system/etc_mng/help/list"
	}, {
		lnb : 6,
		snb : 2,
		url : "/system/etc_mng/help/dtl"
	}, {
		lnb : 6,
		snb : 3,
		url : "/system/etc_mng/errCd/list"
	}, {
		lnb : 6,
		snb : 3,
		url : "/system/etc_mng/errCd/dtl"
	}, {
		lnb : 6,
		snb : 4,
		url : "/system/etc_mng/externalSystemUrl/list"
	}, {
		lnb : 6,
		snb : 4,
		url : "/system/etc_mng/externalSystemUrl/dtl"
	},

	{
		lnb : 7,
		snb : 1,
		url : "/system/stat_mng/dashboard"
	}, {
		lnb : 7,
		snb : 2,
		url : "/system/stat_mng/visitReg"
	}, {
		lnb : 7,
		snb : 3,
		url : "/system/stat_mng/req"
	}, {
		lnb : 7,
		snb : 4,
		url : "/system/stat_mng/keyword"
	},

	{
		lnb : 8,
		snb : 1,
		url : "/system/portal_auth_mng/list"
	}, {
		lnb : 8,
		snb : 1,
		url : "/system/portal_auth_mng/dtl"
	}, {
		lnb : 8,
		snb : 2,
		url : "/system/admin_auth_mng/list"
	}, {
		lnb : 8,
		snb : 2,
		url : "/system/admin_auth_mng/dtl"
	},

	{
		lnb : 9,
		snb : 1,
		url : "/system/poli_person_mng/code/list"
	}, {
		lnb : 9,
		snb : 2,
		url : "/system/poli_person_mng/list"
	},

	{
		lnb : 10,
		snb : 1,
		url : "/custMng/custEventList"
	}, {
		lnb : 10,
		snb : 2,
		url : "/custMng/custInfoMng"
	}, {
		lnb : 10,
		snb : 3,
		url : "/custMng/custInfoList"
	},

	//{lnb : 10, snb : 1, url : "/scheduleMng/list"},
	//{lnb : 10, snb : 2, url : "/scheduleMng/list2"},

	//{lnb : 11, snb : 1, url : "/scheduleMng/list"},
	//{lnb : 11, snb : 2, url : "/scheduleMng/list2"},

	//{lnb : 12, snb : 1, url : "/scheduleMng/list"},
	//{lnb : 12, snb : 2, url : "/scheduleMng/list2"},

	//{lnb : 13, snb : 1, url : "/scheduleMng/list"},
	//{lnb : 13, snb : 2, url : "/scheduleMng/list2"},

	]

	$(function() {

		var mnulvlinfo = menulvlconst.getElementFirst("url", location.pathname);
		if (!cf_isEmpty(mnulvlinfo)) {
			$("li[data-lnb=" + mnulvlinfo.lnb + "][data-snb=0]").addClass(
					"active");
			$("ul[data-lnb=" + mnulvlinfo.lnb + "][data-snb=0]").addClass(
					"visible");
			$(
					"li[data-lnb=" + mnulvlinfo.lnb + "][data-snb="
							+ mnulvlinfo.snb + "]").addClass("active");
		}
	})
</script>