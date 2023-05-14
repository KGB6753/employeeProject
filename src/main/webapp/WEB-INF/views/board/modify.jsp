<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Modify Page</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Modify Page</div>
			<div class="panel-body">
				<form role="form" action="/board/modify" method="post">
					<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}" />' />
					<input type="hidden" name="amount" value='<c:out value="${cri.amount}" />' />
					<input type="hidden" name="type" value="<c:out value="${cri.type}" />" />
					<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>" />
					<div class="form-group">
						<label>b_no</label>
						<input class="form-control" name="b_no" value="<c:out value='${board.b_no}'/>" readonly="readonly">
					</div>
					<div class="form-group">
						<label>Title</label>
						<input class="form-control" name="title" value="<c:out value='${board.title}'/>">
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="content"><c:out value='${board.content}' />
						</textarea>
					</div>
					<div class="form-group">
						<label>emp_no</label>
						<input class="form-control" name="emp_no" value="<c:out value='${board.emp_no}'/>" readonly="readonly">
					</div>
					<div class="form-group" hidden>
						<label>작성일</label>
						<input class="form-control" name="reg_date" value="<fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${board.reg_date }" />" readonly="readonly">
					</div>
					<div class="form-group" hidden>
						<label>수정일</label>
						<input class="form-control" name="update_date" value="<fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${board.update_date }" />" readonly="readonly">
					</div>
					<!-- 버튼에 값을 지정 data-oper 라는 이름으로 값을 뺄 수 있음 -->
					<button class="btn btn-default" data-oper="modify" type="submit">Modify</button>
					<button class="btn btn-danger" data-oper="remove" type="submit">Remove</button>
					<button class="btn btn-info" data-oper="list" type="submit">List</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>


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
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

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
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>



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




<script type="text/javascript">
	$(document).ready(function() {

		var formObj = $("form");

		$('button').on("click", function(e) {
			e.preventDefault();
			//버튼 이벤트 막음.. submit을 막음
			var operation = $(this).data("oper");

			console.log(operation);

			if (operation === 'remove') {
				formObj.attr("action", "/board/remove");
			} else if (operation === 'list') {
				formObj.attr("action", "/board/list").attr("method", "get");
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
				
			}else if(operation ==='modify'){
				var str = "";
				$(".uploadResult ul li").each(function(i,obj){
					var jobj = $(obj);
					str += "<input type='hidden' name='attachList[" + i + "].file_Name' value='" + jobj.data("filename") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].upload_Path' value='" + jobj.data("path") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].file_Type' value='" + jobj.data("type") + "'>";
				});
				formObj.append(str);
			}
			formObj.submit();
		});

	});
</script>


<script>
	$(document).ready(function(e) {
		(function() {
			var b_no = '<c:out value="${board.b_no}" />';
			console.log(b_no);
			$.getJSON("/board/getAttachList", {
				b_no : b_no
			}, function(arr) {

				var str = "";

				$(arr).each(function(i, attach) {
					//image type
					if (attach.file_Type) {
						var fileCallPath = encodeURIComponent(attach.upload_Path + "/s_" + attach.uuid + "_" + attach.file_Name);
						str += "<li data-path='"+attach.upload_Path+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.file_Name+"' data-type='"+attach.file_Type+"' ><div>";
						str += "<span> " + attach.file_Name + "</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?file_Name=" + fileCallPath + "'>";
						str += "</div>";
						str += "</li>";
					} else {
						var fileCallPath = encodeURIComponent(attach.upload_Path + "/" + attach.uuid + "_" + attach.file_Name);
						var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
						str += "<li data-path='"+attach.upload_Path+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.file_Name+"' data-type='"+attach.file_Type+"' ><div>";
						str += "<span> " + attach.file_Name + "</span><br/>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.png'></a>";
						str += "</div>";
						str += "</li>";
					}
					

				});
				$(".uploadResult ul").html(str);

			});
		})();

		var cloneObj = $(".uploadDiv").clone();
		var formObj = $('form[role="form"]');

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
				data : formData,
				type : 'POST',
				/* 이미지 첨부 보안 관련 ajax 설정 */
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				dataType : 'json',
				success : function(result) {
					console.log(result);
				
					showUploadResult(result);
					
		//			$(".uploadDiv").html(cloneObj.html());

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
		            str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.file_Name+"' data-type='"+obj.image+"'"
		            str +=" ><div>";
					str += "<span> " + obj.file_Name + "</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?file_Name=" + fileCallPath + "'>";
					str += "</div>";
					str += "</li>";
				} else {
					var fileCallPath = encodeURIComponent(obj.upload_Path + "/" + obj.uuid + "_" + obj.file_Name);
					
					//정규 표현식... /  \\   /  g   =>  \를 g(모두 찾음, i는 처음 하나만...) 해서 replace /로 대체함.. 경로를
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
			//알림창 yes면 if     no면 else
			 if(confirm("Remove this file?")){
		         console.log("OK!");
		         
		            var targetFile = $(this).data("file");
					var type = $(this).data("type");
					var targetLi = $(this).closest("li");//this 기준 가장 가까운 부모 li
					targetLi.remove(); //리스트에서 없애줌...
					/* modify 시에 실행되게 뺄거임
					$.ajax({
						url : "/deleteFile",
						data : {
							file_Name : targetFile,
							type : type
						},
						dataType : 'text',
						type : 'POST',
						success : function(result) {
							alert(result);
							targetLi.remove();
						}
					}); // ajax end
					*/
		         
		      }

			
		});

	});
</script>

<%@include file="../includes/footer.jsp"%>