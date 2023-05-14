<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>

<style>
.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<div class="panel-body">
				<form role="form" action="/board/register" method="post">
					<div class="form-group">
						<label>Title</label>
						<input class="form-control" name="title">
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="content"></textarea>
					</div>
					<div class="form-group">
						<label>emp_no</label>
							<input class="form-control" name="emp_no" value="<sec:authentication property="principal.employee.emp_no"/>" readonly>
					</div>
					<button type="submit" class="btn btn-default">Submit Button</button>
					<button type="reset" class="btn btn-default">Reset Button</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">File Attach</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple>
				</div>

				<div class='uploadResult'>
					<ul>

					</ul>
				</div>


			</div>
			<!--  end panel-body -->

		</div>
		<!--  end panel-body -->
	</div>
	<!-- end panel -->
</div>
<script>
	$(document).ready(function(e) {
		var cloneObj = $(".uploadDiv").clone();
		var formObj = $('form[role="form"]');

		$("button[type='submit']").on("click", function(e) {
			
			if(!formObj.find("input[name='title']").val()){
				alert("제목을 입력해주세요");
				return false;
			}
			if(!formObj.find("textarea[name='content']").val()){
				alert("내용을 입력해주세요");
				return false;
			}
			
			e.preventDefault();
			console.log("file");
			
			var str = "";
			$(".uploadResult ul li").each(function(i, obj) {
				var jobj = $(obj);
				//컨트롤러 수집을 위해서는 name을 똑같이 맞춰줘야함
				str += "<input type='hidden' name='attachList[" + i + "].file_Name' value='" + jobj.data("filename") + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].upload_Path' value='" + jobj.data("path") + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].file_Type' value='" + jobj.data("type") + "'>";
				//데이터 속성은 소문자로!!!
			});
			formObj.append(str).submit();
			
		});

		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");/* 정규 표현식 */
		var maxSize = 5242880; // 5M

		function checkExtension(file_Name, fileSize) {
			if (fileSize > maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}

			if (regex.test(file_Name)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}

			return true;
		}//checkExtendsion

		
		//이미지 첨부 보안 관련 ajax 설정 추가!!
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$("input[type='file']").change(function(e) {
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			console.log(files);

			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}

			$.ajax({
				url : '/uploadAjaxAction',
				contentType : false, /* multipart/from-data */
				processData : false,
				/* 이미지 첨부 보안 관련 ajax 설정 */
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log(result);
			
					showUploadResult(result);
					
	//				$(".uploadDiv").html(cloneObj.html());

					// alert(result);	
				}
			});
		});//파일이 등록되면 바로

		function showUploadResult(uploadResultArr) {
			if (!uploadResultArr || uploadResultArr.length == 0) {
				return;
			}

			var uploadUL = $(".uploadResult ul");
			var str = "";
			$(uploadResultArr).each(function(i, obj) {
				// p.559
				if (obj.image) {
					var fileCallPath = encodeURIComponent(obj.upload_Path + "/s_" + obj.uuid + "_" + obj.file_Name);
					str += "<li data-path='"+obj.upload_Path+"'";
		            str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.file_Name+"' data-type='"+obj.image+"'><div>";
					str += "<span> " + obj.file_Name + "</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?file_Name=" + fileCallPath + "'>";
					str += "</div>";
					str += "</li>";
				} else {
					var fileCallPath = encodeURIComponent(obj.upload_Path + "/" + obj.uuid + "_" + obj.file_Name);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					str += "<li data-path='"+obj.upload_Path+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.file_Name+"' data-type='"+obj.image+"' ><div>";
					str += "<span> " + obj.file_Name + "</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str += "</li>";
				}
			}); // each end

			uploadUL.append(str);
		}

		$(".uploadResult").on("click", "button", function(e) {
			console.log("delete file");

			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			var targetLi = $(this).closest("li");//this 기준 가장 가까운 부모 li

			$.ajax({
				url : "/deleteFile",
				data : {
					file_Name : targetFile,
					type : type
				},
				/* 이미지 첨부 보안 관련 ajax 설정 */
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				dataType : 'text',
				type : 'POST',
				success : function(result) {
					alert(result);
					targetLi.remove();
					$(".uploadDiv").html(cloneObj.html());
				}
			}); // ajax end
		});

	});
</script>
<%@include file="../includes/footer.jsp"%>