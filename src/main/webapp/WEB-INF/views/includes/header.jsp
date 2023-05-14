<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>개인 프로젝트</title>


<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    

</head>

<body>

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/board/list">직원 리스트 및 게시판</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">
				
				
				
				<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-user">
					
					<sec:authorize access="isAuthenticated()">
						<!-- 로그인 되었는지 true false 값으로.. -->
						<li><a href="/employees/get?emp_no=<sec:authentication property="principal.username"/>"><i class="fa fa-user fa-fw"></i> <sec:authentication property="principal.employee.first_name"/> <sec:authentication property="principal.employee.last_name"/> </a></li>
						<li class="divider"></li>
						<li><a href="/customLogout"><i class="fa fa-sign-out fa-fw"></i> LOG-OUT</a></li>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
   						<li><a href="/customLogin"><i class="fa fa-sign-out fa-fw"></i> LOG-IN</a></li>   
					</sec:authorize>
						
						
					</ul> <!-- /.dropdown-user --></li>
				<!-- /.dropdown -->
			</ul>
			<!-- /.navbar-top-links -->

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li class="sidebar-search">
							<div class="input-group custom-search-form">
								<input type="text" class="form-control" placeholder="Search...">
								<span class="input-group-btn">
									<button class="btn btn-default" type="button">
										<i class="fa fa-search"></i>
									</button>
								</span>
							</div> <!-- /input-group -->
						</li>
						<!-- <li><a href="index.html"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a></li> -->
						<li><a href="#"><i class="fa fa-table fa-fw"></i> Employees <span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<sec:authorize access="hasRole('ROLE_MEMBER')">
								<li><a href="/employees/list"><p class="fa fa-list"> List </p></a></li>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_ADMIN')">
  									<li><a href="/employees/register"><p class="fa fa-pencil"> Register </p></a></li>
								</sec:authorize>
								
				
							</ul> <!-- /.nav-second-level -->
						</li>
						<li><a href="#"><i class="fa fa-table fa-fw"></i> Board <span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="/board/list"><p class="fa fa-list"> List </p></a></li>
								<li><a href="/board/register"><p class="fa fa-pencil"> Register </p></a></li>
							</ul> <!-- /.nav-second-level -->
						</li>
							
						<!-- <li><a href="tables.html"><i class="fa fa-table fa-fw"></i> Tables</a></li>
						<li><a href="forms.html"><i class="fa fa-edit fa-fw"></i> Forms</a></li>
						<li><a href="#"><i class="fa fa-wrench fa-fw"></i> UI Elements<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="panels-wells.html">Panels and Wells</a></li>
								<li><a href="buttons.html">Buttons</a></li>
								<li><a href="notifications.html">Notifications</a></li>
								<li><a href="typography.html">Typography</a></li>
								<li><a href="icons.html"> Icons</a></li>
								<li><a href="grid.html">Grid</a></li>
							</ul> /.nav-second-level</li>
						<li><a href="#"><i class="fa fa-sitemap fa-fw"></i> Multi-Level Dropdown<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="#">Second Level Item</a></li>
								<li><a href="#">Second Level Item</a></li>
								<li><a href="#">Third Level <span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="#">Third Level Item</a></li>
										<li><a href="#">Third Level Item</a></li>
										<li><a href="#">Third Level Item</a></li>
										<li><a href="#">Third Level Item</a></li>
									</ul> /.nav-third-level</li>
							</ul> /.nav-second-level</li>
						<li><a href="#"><i class="fa fa-files-o fa-fw"></i> Sample Pages<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="blank.html">Blank Page</a></li>
								<li><a href="login.html">Login Page</a></li>
							</ul> /.nav-second-level</li> -->
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
			<!-- /.navbar-static-side -->
		</nav>

		<div id="page-wrapper">
		<!-- jquery 기능 추가 -->
		<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->
		<script
	src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>