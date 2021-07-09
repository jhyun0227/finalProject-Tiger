<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<style type="text/css">
.err {
	color: red;
	font-weight: bold;
}
</style>
<script type="text/javascript" src="${path }/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript">
	// 이메일 유효성 검사 및 중복 체크
	function idChk() {
	/* 이메일 유효성 검사 */
	var reg_id = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if(!frm.MB_id.value) {
		alert("이메일을 입력하세요")
		frm.MB_id.focus();
		frm.MB_id.value="";
		return false;
	}else{
		if(!reg_id.test(frm.MB_id.value)){
			alert("올바른 이메일 형식이 아닙니다.");
			frm.id.focus();
			return false;
		}else{
			/* 인증메일 전송
			$.post("mailResult.na", "id="+frm.id.value, function(data){
				인증메일 전송시 인증번호 입력창 보이기
				var str = data.split(";");
				alert(str[0]);
				frm.certify.value=str[1];
				if (str[0]=="send mail success"){
					$('#chkIdDIV').css("display","block")
				}
			}); */
		
			
		// 아이디 중복 체크 로직
		$.post('idChk.do', 'MB_id='+frm.MB_id.value, function(data) {
			$('#idChk').html(data);
		});
	}
	
	
	
	function chk() {
		// 비밀번호와 비밀번호 확인 체크
		if (frm.MB_pw.value != frm.MB_pw_confirm.value) {
			alert("암호와 암호 확인이 일치하지 않습니다.");
			frm.MB_pw.focus(); // 커서
			frm.MB_pw.value=""; // password에 있는 데이터를 지우기
			return false; // action을 실행하지 않음
		}
		
		
		// 미성년자인지 체크
		var today = new Date(); // 시스템 날짜 객체 생성
		var year = parseInt(today.getFullYear()); // 생성된 객체에서 연도 데이터만 가져와 숫자로 변환
		
		var regNum = frm.MB_regNum.value; // 입력한 주민등록번호의 값을 가져와 변수에 담음
		var regNum_back = regNum.charAt(7); // 가져온 주민등록번호 뒷자리 첫번째 자리 수만 가져와서 변수에 담음
		var age = 0; // 임시 나이 변수;
		
		if (regNum_back <= 2) { // 주민등록번호 뒷자리 첫번째 값이 1과 2인 경우
			age = year - (1900 + parseInt(regNum.substring(0,2)));
		} else { // 3과 4인 경우
			age = year - (2000 + parseInt(regNum.substring(0,2)));
			if (age < 20) { // age의 값이 20 미만인 경우 회원가입을 할 수 없게 함
				alert("20세 미만은 가입할 수 없습니다.");
				frm.MB_regNum.focus(); // 커서
				frm.MB_regNum.value=""; // password에 있는 데이터를 지우기
				return false; // action을 실행하지 않음
			} 
		}
	}
</script>
</head>
<body>
<div class="container" align="center">
	<h2 class="text-primary">회원 가입</h2>
	<form action="join.do" method="post" name="frm" onsubmit="return chk()">
		<table class="table table-bordered table-hover">
			<tr>
				<td><label for="email">이메일</label></td>
				<td>
					<input type="email" name="MB_id" id="email" required="required" autofocus="autofocus">
					<input type="button" onclick="idChk()" class="btn btn-info btn-sm" value="중복체크">
					<div id="idChk" class="err"></div>
				</td>
			</tr>
			<tr>
				<td><label for="pw">비밀번호</label></td>
				<td><input type="password" name="MB_pw" id="pw" required="required"></td>
			</tr>
			<tr>
				<td><label for="pw_confirm">비밀번호 확인</label></td>
				<td><input type="password" name="MB_pw_confirm" id="pw_confirm" required="required"></td>
			</tr>
			<tr>
				<td><label for="name">이름</label></td>
				<td><input type="text" name="MB_name" id="name" required="required"></td>
			</tr>
			<tr>
				<td><label for="regNum">주민등록번호</label></td>
				<td>
					<input type="text" name="MB_regNum" id="regNum" required="required" maxlength="6" style="width:11%;">
					<span>―</span>
					<input type="text" name="MB_gender" required="required" maxlength="1" style="width:25px;">
					<span>******</span>
				</td>
			</tr>
			<tr>
				<td><label for="nickName">닉네임</label></td>
				<td><input type="text" name="MB_nickName" id="nickName" required="required"></td>
			</tr>
			<tr>
				<td><label for="tel">연락처</label></td>
				<td><input type="tel" name="MB_tel" id="tel" required="required" title="전화번호 형식 3-4-4"
							pattern="\d{3}-\d{4}-\d{4}" placeholder="000-0000-0000"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="회원가입" class="btn btn-success">
					<input type="reset" value="다시 작성" class="btn btn-danger">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>