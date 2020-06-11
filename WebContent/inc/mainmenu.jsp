<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>meinMenu</title>
		<style>
		.dropdownColor{
		}
		</style>
	</head>
	<body>
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark justify-content-center">
			<ul class="navbar-nav">
				<div class="dropdown">
					<button type="button" class="btn btn-dark dropdown-toggle" data-toggle="dropdown" style="color:#949D9A !important;">
						<i class='far fa-building'>사원조회</i>
					</button>
					<div class="dropdown-menu" style="color:#6c757d !important; background-color: #343a40 !important;">
						<a class="nav-link" href="<%=request.getContextPath()%>/emp_datails/currentEmployeesList.jsp"><i class="far fa-address-card">현재사원 조회</i></a>
						<a class="nav-link" href="<%=request.getContextPath()%>/emp_datails/retiredEmployeesList.jsp"><i class="far fa-address-card">퇴사사원 조회</i></a>
					</div>
				</div>
				<div class="dropdown">
					<button type="button" class="btn btn-dark dropdown-toggle" data-toggle="dropdown" style="color:#949D9A !important;">
						<i class='far fa-building'>부서 조회</i>
					</button>
					<div class="dropdown-menu" style="color:#6c757d !important; background-color: #343a40 !important;">
						<a class="nav-link dropdownColor" href="<%=request.getContextPath()%>/dept_details/departmentsList.jsp"><i class="far fa-address-card">부서 조회</i></a>
						<a class="nav-link dropdownColor" href="<%=request.getContextPath()%>/dept_details/departmentsCountByDeptEmp.jsp"><i class="far fa-address-card">부서별 사원수</i></a>
						<a class="nav-link dropdownColor" href="<%=request.getContextPath()%>/dept_details/deptAverageSalary.jsp"><i class="far fa-address-card">부서별 평균연봉</i></a>
					</div>
				</div>
				<li class="nav-item">
					<a class="nav-link dropdownColor" href="<%=request.getContextPath()%>/deptManager/departmentManagerList.jsp"><i class="far fa-address-card">부장 조회</i></a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp"><i class='far fa-comments'>질문게시판</i></a>
				</li>
				<div class="dropdown">
					<button type="button" class="btn btn-dark dropdown-toggle" data-toggle="dropdown" style="color:#949D9A !important;">
						<i class='far fa-building'>원본 데이터</i>
					</button>
					<div class="dropdown-menu" style="color:#6c757d !important; background-color: #343a40 !important;">
						<a class="nav-link dropdownColor" href="<%=request.getContextPath()%>/original_data/departmentsList.jsp"><i class="far fa-address-card">부서 목록</i></a>
						<a class="nav-link dropdownColor" href="<%=request.getContextPath()%>/original_data/employeesList.jsp"><i class="far fa-address-card">직원 목록</i></a>
						<a class="nav-link dropdownColor" href="<%=request.getContextPath()%>/original_data/deptEmpList.jsp"><i class="far fa-address-card">부서별 직원 목록</i></a>
						<a class="nav-link dropdownColor" href="<%=request.getContextPath()%>/original_data/deptManagerList.jsp"><i class="far fa-address-card">매니저 목록</i></a>
						<a class="nav-link dropdownColor" href="<%=request.getContextPath()%>/original_data/titlesList.jsp"><i class="far fa-address-card">직책 목록</i></a>
						<a class="nav-link dropdownColor" href="<%=request.getContextPath()%>/original_data/salariesList.jsp"><i class="far fa-address-card">월급 목록</i></a>
					</div>
				</div>
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/about.jsp"><i class="fas fa-address-book"></i>만든이 소개</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/index.jsp"><i class="fas fa-home"></i>소개</a>
				</li>
			</ul>
		</nav>
	</body>
</html>