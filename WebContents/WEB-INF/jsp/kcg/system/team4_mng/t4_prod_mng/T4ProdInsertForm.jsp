<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
</head>
<body>
	<h2>상품신규등록</h2>
	<div class="flex-column flex-gap-10" id="vueapp"
		style="display: flex; justify-items: center;">
		<div class="panel-body flex-100">
			<div class="left-panel flex-66">
				<div class="form-group">
					<label for="product_name" class="fix-width-33">상품명:</label> <input
						type="text" class="form-control" id="product_name">
				</div>
				<div class="form-group">
					<label for="product_id" class="fix-width-33">상품코드:</label> <input
						type="text" class="form-control" id="product_id">
				</div>
				<div class="form-group">
					<label for="product_type" class="fix-width-33">상품유형:</label> <select
						class="form-control" id="product_type">
						<option value="예금">예금</option>
						<option value="적금">적금</option>
						<option value="대출">대출</option>
					</select>
				</div>
				<div class="form-group">
					<label for="possible_member" class="fix-width-33">가입대상:</label> <select
						class="form-control" id="possible_member">
						<option value="일반개인">일반개인</option>
						<option value="청년">청년우대</option>
						<option value="장애인">장애인우대</option>
					</select>
				</div>
				<div class="form-group">
					<label for="lowest_money" class="fix-width-33">가입금액:</label>
					<div class="form-control">
					<label>(최소)</label>
						<input type="text" class="form-control" id="lowest_money">
						<label>원 ~ (최대)</label>
						<input type="text" class="form-control" id="highest_money">
						<label>원</label>
					</div>
				</div>
			</div>
		</div>


	</div>


	<script>
		new Vue({
			el : "#vueapp",
		})
	</script>
</body>
</html>