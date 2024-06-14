<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="vueapp">
	<table>
		<thead>
			<tr>
				<th>상품명</th>
				<th>상품유형</th>
				<th>가입대상</th>
				<th>최소가입금액</th>
				<th>최대가입금액</th>
				<th>최소적용이율</th>
				<th>최대적용이율</th>
				<th>이자과세</th>
			</tr>
		</thead>
		<tbody>
			<tr v-for="item in datalist">
				<tb>{{message}}</tb>
				<tb>{{item.product_type}}</tb>
				<tb>{{item.possible_member}}</tb>
				<tb>{{item.lowest_money}}</tb>
				<tb>{{item.highest_money}}</tb>
				<tb>{{item.lowest_rate}}</tb>
				<tb>{{item.highest_rate}}</tb>
				<tb>{{item.texation}}</tb>
			</tr>
		</tbody>
	</table>
	{{message}}
	</div>

</body>
<script>
var vueapp = new Vue({
			el : '#vueapp',
			data : {
				datalist : [],
				message : 'hi!'
			}
		})
</script>
</html>