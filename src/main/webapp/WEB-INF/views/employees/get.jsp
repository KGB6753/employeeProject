<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>
<!--  -->

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">
			Employees
			<sec:authorize access="hasRole('ROLE_MEMBER')">
				<sec:authentication property="principal.username" var="empNo"/>
				<c:if test="${employee.emp_no eq empNo}">
  					<button type="submit" data-oper="pwchange" class="btn btn-warning pull-right">비밀번호 변경</button>
  				</c:if>
  				
				<sec:authorize access="hasRole('ROLE_ADMIN')">
  					<button type="submit" data-oper="modify" class="btn btn-success pull-right">수정</button>
				</sec:authorize>
			</sec:authorize>
			<button class="btn btn-info pull-right" data-oper="list" type="submit">목록</button>
		</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-primary">
			<div class="panel-heading">
				employee
				<!-- <button id="regBtn" type="button" class="btn btn-xs pull-right">Register
               New Board</button> -->
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<!-- <form id="regForm" method="post" action="/employees/register"> -->
				<div class="panel-body">

					<div class="form-group">
						<label>Employee NO.</label>
						<input class="form-control" name="emp_no" value="<c:out value='${employee.emp_no}'/>" readonly="readonly">
					</div>

					<div class="row">
						<div class="col-xs-4">
							<div class="form-group">
								<label>First Name</label>
								<input class="form-control" name="first_name" value="<c:out value='${employee.first_name}'/>" readonly="readonly">
							</div>
						</div>
						<div class="col-xs-3">
							<div class="form-group">
								<label>Last Name</label>
								<input class="form-control" name="last_name" value="<c:out value='${employee.last_name}'/>" readonly="readonly">
							</div>
						</div>
					</div>

					<div class="form-group">
						<label>Birth Date</label>
						<input class="form-control" type="date" name="birth_date" placeholder="yyyy-MM-dd" value='<fmt:formatDate value="${employee.birth_date}" pattern="yyyy-MM-dd" />' readonly="readonly">
					</div>

					<div class="form-group">
						<label>Gender</label>
						<div class="radio-inline">
							<label> <input type="radio" name="gender" id="optionsRadios1" value="M" ${(employee.gender eq 'M' )? "checked" : ""} disabled>Male
							</label>
						</div>
						<div class="radio-inline">
							<label> <input type="radio" name="gender" id="optionsRadios2" value="F" ${(employee.gender eq 'F') ? "checked" : ""} disabled>Female
							</label>
						</div>

					</div>

					<div class="form-group">
						<label>Hire Date</label>
						<input class="form-control" type="date" name="hire_date" placeholder="yyyy-MM-dd" value='<fmt:formatDate value="${employee.hire_date}" pattern="yyyy-MM-dd" />' readonly="readonly">
					</div>

					<div class="form-group">
						<div class="row">
							<div class="col-xs-5">
								<label>Department</label> <select class="form-control" name="dept_no" id="sel_department" disabled>
									<option value=""><c:out value='${employee.dept_name}' /></option>
								</select>
							</div>
							<div class="col-xs-5">
								<label>Title</label> <select class="form-control" name="title" id="sel_title" disabled>
									<option value=""><c:out value='${employee.title}' /></option>
								</select>
							</div>
						</div>
					</div>
					<!-- 
                  <button type="submit" class="btn btn-primary">Register</button>
                  <button type="reset" class="btn btn-danger">Reset</button> 
-->
				</div>

				<!-- </form> -->

			</div>
			<!-- /.panel-body -->
		</div>


		<div class="panel panel-primary">
			<div class="panel-heading">
				Departments
				<!-- <button id="regBtn" type="button" class="btn btn-xs pull-right">Register
               New Board</button> -->
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover" id="departmentsTable">
						<thead>
							<tr>
								<th>#</th>
								<th>Department</th>
								<th>From_date</th>
								<th>To_date</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>

			</div>
		</div>

		



		<div class="panel panel-primary">
			<div class="panel-heading">
				Titles
				<!-- <button id="regBtn" type="button" class="btn btn-xs pull-right">Register
               New Board</button> -->
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover" id="titlesTable">
						<thead>
							<tr>
								<th>#</th>
								<th>Title</th>
								<th>From_date</th>
								<th>To_date</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- /.panel -->
	</div>

	<!-- /.col-lg-12 -->
	<form id="operForm" action="/employees/modify" method="get">
		<input type="hidden" id="emp_no" name="emp_no" value='<c:out value="${employee.emp_no}" />' />
		<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}" />" />
		<input type="hidden" name="amount" value="<c:out value="${cri.amount}" />" />
		<input type="hidden" name="type" value="<c:out value="${cri.type}" />" />
		<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}" />" />
	</form>
</div>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Change Password</h4>
			</div>
			<div class="modal-body">
			<form role="change" method="post" action="/employees/changePwd">
		<!--		<div class="form-group">
					<label>현재 비밀번호</label>
					<input type="password" class="form-control" name="oldpw"  />
				</div>   -->
				<div class="form-group">
					<label>새 비밀번호</label>
					<input type="password" class="form-control" name="newpw" />
				</div>
				<div class="form-group">
					<label>새 비밀번호 검사</label>
					<input type="password" class="form-control" name="chkpw"/>
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="emp_no" value="<sec:authentication property="principal.employee.emp_no"/>" />
				</form>
			</div>
			<div class="modal-footer">
				<button id="modalChangeBtn" type="button" class="btn btn-primary">Change</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!— /.modal-content —>
	</div>
	<!— /.modal-dialog —>
</div>
<!— /.modal —>

<script type="text/javascript" src="/resources/js/dept.js?v=112"></script>

<script type="text/javascript">
	$(document).ready(function() {
		var emp_no = "<c:out value='${employee.emp_no}'/>";
		console.log(emp_no);
		
		
		var titleListUL = $("#titlesTable tbody")

		deptService.getDeptEmpList(emp_no, function(list) {
			var str = "";
			$(list).each(function(i,obj){
				str += "<tr>";
				str += "<td>"+(i+1)+"</td>";
				str += "<td>"+obj.dept_name+"</td>";
				str += "<td>"+deptService.displayTime(obj.from_date)+"</td>";
				str += "<td>"+deptService.displayTime(obj.to_date)+"</td>";
				str += "</tr>";
			});
			/*
			list.forEach((d,index)=>{
				str += "<tr>";
				str += "<td>"+(index+1)+"</td>";
				str += "<td>"+d.dept_name+"</td>";
				str += "<td>"+deptService.displayTime(d.from_date)+"</td>";
				str += "<td>"+deptService.displayTime(d.to_date)+"</td>";
				str += "</tr>";
				});
			*/
			
			//:last 하고 append 하면 기존 내용을 마지막으로 두고 추가 가능함
			$("#departmentsTable tbody:last").html(str);
			
		});

		deptService.getTitleList(emp_no, function(list) {
			var str = "";
			list.forEach((d,index)=>{
				str += "<tr>";
				str += "<td>"+(index+1)+"</td>";
				str += "<td>"+d.title+"</td>";
				str += "<td>"+deptService.displayTime(d.from_date)+"</td>";
				str += "<td>"+deptService.displayTime(d.to_date)+"</td>";
				str += "</tr>";
				});
			titleListUL.html(str);
		});
		
		
		
		var operForm = $('#operForm');
		
        $("button[data-oper='modify']").on("click", function(e){
           operForm.attr("action", "/employees/modify").submit();
        });
        
        $("button[data-oper='pwchange']").on("click", function(e){
        	$('.modal').modal("show");
         });
        
        
        
        $("button[data-oper='list']").on("click", function(e){
        	//operForm.attr("action", "/employees/modify").submit();
            
            operForm.attr("action", "/employees/list").attr("method", "get");
			//formObj.empty();
			//get방식으로 갈때 url에 안 남도록 데이터를 지우려면

			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();

			operForm.empty();
			operForm.append(pageNumTag);
			operForm.append(amountTag);
			operForm.append(typeTag);
			operForm.append(keywordTag);
			
			operForm.submit();
         });
        
        
        var modal = $(".modal");

		//<input class="form-control" name='reply' value='New Reply!!!!'> 네임 reply인 input 속성 자체를 가져와서 집어넣음

	//	var modalInputOldpw = modal.find("input[name='oldpw']");
		//var oldPw = modalInputOldpw.val();
		var modalInputNewpw = modal.find("input[name='newpw']");
		//var newPw = madalInputNewpw.val();
		var modalInputChkpw = modal.find("input[name='chkpw']");
		//var chkPw = modalInputChkpw.val();
		
		var modalChangeBtn = $('#modalChangeBtn');

		var employee = null;
		
		<sec:authorize access="isAuthenticated()">
			employee = '<sec:authentication property="principal.username"/>';
		</sec:authorize>
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		var change = $('form[role="change"]');
		
		//ajax 댓글 보안 관련 추가!!
		 $(document).ajaxSend(function(e, xhr, options){
			 xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		 });
		
		$("#modalCloseBtn").on("click", function(e) {
			modal.find("input").val("");
			modal.modal("hide");
		});
		
		modalChangeBtn.on("click", function(e) {
			//console.log(modalInputOldpw.val());
			console.log(modalInputNewpw.val());
			console.log(modalInputChkpw.val());
			
			//const oldPw = modalInputOldpw.val();
			const newPw = modalInputNewpw.val();
			const chkPw = modalInputChkpw.val();
			
			 if(!newPw || newPw.trim() === ""){
				 alert("새 비밀번호를 입력하세요."); 
			 }
			 else if(!chkPw || chkPw.trim() === ""){
				 alert("새 비밀번호 검사를 입력하세요."); 
			 }else if(newPw != chkPw){
				 alert("비밀번호가 불일치 합니다"); 
			 }else if(newPw === chkPw){
				 change.submit();
				 alert("비밀번호가 변경되었습니다.");
			 }
		});

	});
</script>
<!--  -->
<%@include file="../includes/footer.jsp"%>