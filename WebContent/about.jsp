<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<!-- jQuery library -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- Popper JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<!-- Latest compiled JavaScript -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<!-- icon -->
	<link rel="stylesheet"
		href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
		integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
		crossorigin="anonymous">
	<title>관리자 소개</title>
	<style>
		tbody {
			text-align: center;
		}
		
		.title {
			width: 90px;
			vertical-align: middle;
			line-height: 125px;
		}
		
		.lineHeight {
			line-height: 80px;
		}
		.fixed{
			table-layout: fixed;
		}
	</style>
	</head>
	<body>
		<!-- 베너 -->
		<div>
			<jsp:include page="/inc/banner.jsp" ></jsp:include> <!-- jsc:include = 모듈을 가져온다 -->
		</div>
		<!-- 메인 메뉴 -->
		<div>
			<jsp:include page="/inc/mainmenu.jsp" ></jsp:include><!-- jsc:include = 모듈을 가져온다 -->
		</div>
		<!-- 내용 -->
		<div style="margin: 20px auto; width: 1522px;">
			<div class="container">
				<!-- 기본정보 사진 -->
				<table class="table">
					<tbody>
						<tr class="lineHeight">
							<td rowspan="3"><img
								src="<%=request.getContextPath()%>/imgs/img1.jpg" width="220"
								height="280"></td>
							<th style="vertical-align: middle;"rowspan="2" class="bg-light text-dark">성명</th>
							<td>(한글) 이윤선</td>
							<th class="bg-light text-dark">생년월일</th>
							<td>19961127</td>
						</tr>
						<tr class="lineHeight">
							<!-- <td>사진</td> -->
							<!-- <td>성명</td> -->
							<td>(영문) Lee yoonseon</td>
							<th class="bg-light text-dark">휴대폰</th>
							<td>010-5457-3381</td>
						</tr>
						<tr class="lineHeight">
							<!-- <td>사진</td> -->
							<th class="bg-light text-dark">현주소</th>
							<td>경기도 안양시 만안구 안양로 324번길 22</td>
							<th class="bg-light text-dark">이메일</th>
							<td>yoonseon12@naver.com</td>
						</tr>
					</tbody>
				</table>
				<!-- 학력사항 -->
				<table class="table">
					<tbody>
						<tr>
							<th rowspan="3" class="title bg-light text-dark">학력사항</th>
							<th class="bg-light text-dark">졸업일</th>
							<th class="bg-light text-dark">학교명</th>
							<th class="bg-light text-dark">전 공</th>
							<th class="bg-light text-dark">졸업여부</th>
							<th class="bg-light text-dark">소재지</th>
						</tr>
						<tr>
							<!--<td>학력사항</td>-->
							<td>2020년 02월</td>
							<td>연성대학교</td>
							<td>정보통신</td>
							<td>졸업</td>
							<td>안양</td>
						</tr>
						<tr>
							<!--<td>학력사항</td>-->
							<td>2015년 2월</td>
							<td>풍동고등학교</td>
							<td>인문계열</td>
							<td>졸업</td>
							<td>고양</td>
						</tr>
					</tbody>
				</table>
				<!-- 경력사항 -->
				<table class="table">
					<tbody>
						<tr>
							<th rowspan="3" class="title bg-light text-dark">대외활동</th>
							<th class="bg-light text-dark">기간</th>
							<th class="bg-light text-dark">구분</th>
							<th class="bg-light text-dark">기관/장소</th>
							<th class="bg-light text-dark">내용</th>
						</tr>
						<tr>
							<!--<td>경력사항</td>-->
							<td>2020.02 - 2020.08</td>
							<td>교육이수내역</td>
							<td>구디아카데미</td>
							<td>디지털 융합 SW 전문가 양성 과정</td>
						</tr>
						<tr>
							<!--<td>경력사항</td>-->
							<td>-</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
				</table>
				<!-- 자격증 -->
				<table class="table fixed">
					<tbody>
						<tr>
							<th rowspan="4" class="title bg-light text-dark">자격증</th>
							<th class="bg-light text-dark">취득일</th>
							<th class="bg-light text-dark">자격명</th>
							<th class="bg-light text-dark">발행처/기관</th>
						</tr>
						<tr>
							<!--<td>경력사항</td>-->
							<td>2020.06</td>
							<td>정보처리산업기사</td>
							<td>한국산업인력공단</td>
						</tr>
						<tr>
							<!--<td>경력사항</td>-->
							<td>2019.07</td>
							<td>네트워크관리사2급</td>
							<td>한국정보통신자격협회</td>
						</tr>
						<tr>
							<!--<td>경력사항</td>-->
							<td>2016.03</td>
							<td>1종보통운전면허</td>
							<td>경찰청(운전면허시험관리단)</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</body>
</html>