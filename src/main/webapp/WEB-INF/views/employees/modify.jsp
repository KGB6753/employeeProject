<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>
<!--  -->

<div class="row">
   <div class="col-lg-12">
      <h1 class="page-header">Employees</h1>
   </div>
   <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
   <div class="col-lg-12">
      <div class="panel panel-primary">
         <div class="panel-heading">
            employees Register Page
            <!-- <button id="regBtn" type="button" class="btn btn-xs pull-right">Register
               New Board</button> -->
         </div>
         <!-- /.panel-heading -->
         <div class="panel-body">
            <form id="modForm" method="post" action="/employees/modify">
            
               <input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}" />" />
                <input type="hidden" name="amount" value="<c:out value="${cri.amount}" />" />
                <input type="hidden" name="type" value="<c:out value="${cri.type}" />" />
               <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}" />" />
               <div class="panel-body">
                  <div class="form-group">
                     <label>Employee NO.</label> 
                     <input class="form-control" 
                        name="emp_no" value="<c:out value='${employee.emp_no}'/>" readonly="readonly">
                  </div>
                  <div class="row">
                     <div class="col-xs-4">
                        <div class="form-group">
                           <label>First Name</label> <input class="form-control"
                              name="first_name" value="<c:out value='${employee.first_name}'/>" placeholder="First Name">
                        </div>
                     </div>
                     <div class="col-xs-3">
                        <div class="form-group">
                           <label>Last Name</label> <input class="form-control"
                              name="last_name" value="<c:out value='${employee.last_name}'/>" placeholder="Last Name">
                        </div>
                     </div>
                  </div>

                  <div class="form-group">
                     <label>Birth Date</label> 
                     <input class="form-control" type="date"
                        name="birth_date" placeholder="yyyy-MM-dd" value='<fmt:formatDate value="${employee.birth_date}" pattern="yyyy-MM-dd" />'>
                  </div>

                  <div class="form-group">
                     <label>Gender</label>
                     <div class="radio-inline">
                        <label> <input type="radio" name="gender"
                           id="optionsRadios1" value="M" ${(employee.gender eq 'M' )? "checked" : ""} >Male
                        </label>
                     </div>
                     <div class="radio-inline">
                        <label> <input type="radio" name="gender"
                           id="optionsRadios2" value="F" ${(employee.gender eq 'F') ? "checked" : ""} >Female
                        </label>
                     </div>

                  </div>
                  <div class="form-group">
                     <label>Hire Date</label> <input class="form-control" type="date"
                        name="hire_date" placeholder="yyyy-MM-dd" value='<fmt:formatDate value="${employee.hire_date}" pattern="yyyy-MM-dd" />' readonly="readonly">
                  </div>
                  
                  <div class="form-group">
                     <div class="row">
                        <div class="col-xs-3">
                           <label>Department</label> 
                           <select class="form-control" name="dept_no" id="sel_department">
                              <option value="">--</option>
                           </select>
                        </div>
                        <div class="col-xs-3">
                           <label>Title</label> 
                           <select class="form-control" name="title" id="sel_title">
                              <option value="">--</option>
                           </select>
                        </div>
                     </div>
                  </div>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
  				<button data-oper="modify" type="submit" class="btn btn-primary">수정</button>
                  <button data-oper="remove" type="submit" class="btn btn-danger">퇴사</button>
			</sec:authorize>
                  <button class="btn btn-info" data-oper="list" type="submit">목록</button>
                  
               </div>
               <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>

         </div>
         <!-- /.panel-body -->
      </div>
      <!-- /.panel -->
   </div>
   <!-- /.col-lg-12 -->
</div>

<script type="text/javascript" src="/resources/js/dept.js?v=111112"></script>

<script type="text/javascript">
/*
	$(document).ready(function() {
		
		
	 
		var emp_no = "<c:out value='${employee.emp_no}'/>";
		console.log(emp_no);
		

		var operForm = $('#operForm');
        $("button[data-oper='modify']").on("click", function(e){
           operForm.attr("action", "/employees/modify").submit();
        });
        
        
        var selDept = $('#sel_department');
		var selDeptTitle = $('#sel_title');
		
		deptService.getDeptList(function(list){
			showDeptList(list);	
		});
		
		selDept.on("change", function(e){
			var dept_no = $(this).val();
			if(dept_no == "" || dept_no == null) return;
			deptService.getDeptTitleList(dept_no, function(list){
				showDeptTitleList(list);
			});
		});
		
		function showDeptList(list){
			var str = "<option value=''>--</option>";
			list.forEach(d => {
				if("${employee.dept_name}"==d.dept_name){
					str += "<option value='"+d.dept_no+"' selected>"+d.dept_name+"</option>";
				}else{
					str += "<option value='"+d.dept_no+"'>"+d.dept_name+"</option>";	
				}
			});
			selDept.html(str);
			
			var dept_no = $("#sel_department").val();
			
			deptService.getDeptTitleList(dept_no, function(list){
				showDeptTitleListFirst(list);
			});
		}
		
		function showDeptTitleList(list){
			var str = "<option value=''>--</option>";
			list.forEach(d => {
			
					str += "<option value='"+d.title+"'>"+d.title+"</option>";	
				
				
			});
			selDeptTitle.html(str);
		}
		
		function showDeptTitleListFirst(list){
			var str = "<option value=''>--</option>";
			list.forEach(d => {
				if("${employee.title}"==d.title){
					str += "<option value='"+d.title+"' selected>"+d.title+"</option>";
				}else{
					str += "<option value='"+d.title+"'>"+d.title+"</option>";	
				}
				
			});
			selDeptTitle.html(str);
		}

	});
*/
</script>


<script type="text/javascript">
   $(document).ready(function() {
      var selDept = $('#sel_department');
      var selDeptTitle = $('#sel_title');
      var dept_no = '<c:out value="${employee.dept_no}" />';
      var title = '<c:out value="${employee.title}" />';
      
      deptService.getDeptList(function(list){
         showDeptList(list);   
      });
      
      
      selDept.on("change", function(e){
         var dept_no = $(this).val();
         if(dept_no == "" || dept_no == null) return;
         deptService.getDeptTitleList(dept_no, function(list){
            showDeptTitleList(list);
         });
      });
      
      function showDeptList(list){
         var str = "<option value=''>--</option>";
         list.forEach(d => {
       //     var selected = (dept_no === d.dept_no)?"selected":"";
         //   str += "<option value='"+d.dept_no+"' "+selected+">"+d.dept_name+"</option>";
       
            str += "<option value='"+d.dept_no+"' >"+d.dept_name+"</option>";
          });
         
         selDept.html(str);
         //selected 밸류인 것에 체인지 이벤트 발생
         $(selDept).val(dept_no).change();
      }
      
      function showDeptTitleList(list){
         
         var str = "<option value=''>--</option>";
         list.forEach(d => {
            var selected = (dept_no === $(selDept).val() && title === d.title)?"selected":"";
            str += "<option value='"+d.title+"' "+selected+">"+d.title+"</option>";
         });
         selDeptTitle.html(str);
      }

   });
</script>

<script type="text/javascript">
   $(document).ready(function() {
      var modForm = $('#modForm');
      $("#modForm .btn-primary").on("click", function(e) {
         e.preventDefault();
         if (!modForm.find("input[name='first_name']").val()) {
            alert("First Name!");
            return false;
         }
         if (!modForm.find("input[name='last_name']").val()) {
            alert("Last Name!");
            return false;
         }
         if (!modForm.find("input[name='birth_date']").val()) {
            alert("Birth Date!");
            return false;
         }
         if (!modForm.find("input[name='hire_date']").val()) {
            alert("Hire Date!");
            return false;
         }
         if(!modForm.find("select[name='dept_no']").val()){
            alert("Department!.");
            return false;
         }
         if(!modForm.find("select[name='title']").val()){
            alert("Title!.");
            return false;
         }
         modForm.submit();
      });

   });
</script>

<script type="text/javascript">
	$(document).ready(function() {

		var formObj = $("form");

		$('button').on("click", function(e) {
			e.preventDefault();
			//버튼 이벤트 막음.. submit을 막음
			var operation = $(this).data("oper");

			console.log(operation);

			if (operation === 'modify') {
				
			} else if (operation === 'list') {
				formObj.attr("action", "/employees/list").attr("method", "get");
				//formObj.empty();
				//get방식으로 갈때 url에 안 남도록 데이터를 지우려면

				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var typeTag = $("input[name='type']").clone();
				var keywordTag = $("input[name='keyword']").clone();

				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(typeTag);
				formObj.append(keywordTag);
				
			} else if(operation ==='remove'){
				formObj.attr("action", "/employees/remove");
			}
			formObj.submit();
		});

	});
</script>



<!--  -->
<%@include file="../includes/footer.jsp"%>