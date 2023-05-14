<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read Page</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Read Page</div>
			<div class="panel-body">
				<div class="form-group">
					<label>b_no</label>
					<input class="form-control" name="b_no" value="<c:out value='${board.b_no}'/>" readonly="readonly" />
				</div>
				<div class="form-group">
					<label>Title</label>
					<input class="form-control" name="title" value="<c:out value='${board.title}'/>" readonly="readonly" />
				</div>
				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name="content" readonly="readonly">
<c:out value='${board.content}' />
						</textarea>
				</div>
				<div class="form-group">
					<label>emp_no</label>
					<input class="form-control" name="emp_no" value="<c:out value='${board.emp_no}'/>" readonly="readonly" />
				</div>
				<div class="form-group">
					<label>작성일</label>
					<input class="form-control" name="reg_date" value="<fmt:formatDate
            pattern="yyyy-MM-dd hh:mm:ss"
            value="${board.reg_date }"
          />" readonly="readonly">
				</div>
				<div class="form-group">
					<label>수정일</label>
					<input class="form-control" name="update_date" value="<fmt:formatDate
            pattern="yyyy-MM-dd hh:mm:ss"
            value="${board.update_date }"
          />" readonly="readonly">
				</div>
				<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.username" var="empNo"/>
					<c:if test="${empNo eq board.emp_no}">
						<button data-oper="modify" class="btn btn-default">Modify</button>
					</c:if>
				</sec:authorize>
				<button data-oper="list" class="btn btn-info">List</button>
				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" id="b_no" name="b_no" value='<c:out value="${board.b_no }"/>' />
					<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}" />' />
					<input type="hidden" name="amount" value='<c:out value="${cri.amount}" />' />
					<input type="hidden" name="type" value="<c:out value="${cri.type}" />" />
					<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>" />
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- 파일들!!!!!!!!!!!!!! -->

<!-- jQuery 1.8 or later, 33 KB -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script> -->

<!-- Fotorama from CDNJS, 19 KB -->
<!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.js"></script>
<div class="fotorama" data-auto="false"></div>
 -->

<!-- SmartPhoto plugin -->
<script src="/resources/js/jquery-smartphoto.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/smartphoto@1.1.0/css/smartphoto.min.css">


<div class="sphoto" style="overflow-x: auto;
    white-space: nowrap;">

</div>



<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
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

			<div class="panel-heading">Files</div>
			<!-- /.panel-heading -->
			<div class="panel-body">


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
<!-- /.row -->

<!-- 
<div class="row">
	<div class="col-lg-12">
		/.panel
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
			</div>

			/.panel-heading
			<div class="panel-body">
				<ul class="chat"></ul>
				./ end ul
			</div>
			<!— /.panel .chat-panel —>
			<div class="panel-footer"></div>
		</div>
	</div>
	<!— ./ end row —>
</div>
 -->







<!-- 댓글 -->
<div class="chat-panel panel panel-default" id="inputreply">
	<div class="panel-heading">
		<i class="fa fa-comments fa-fw"></i> Comments

	</div>
	<!-- /.panel-heading -->
	<div class="panel-body">
		<ul class="chat">

		</ul>
		<div id="replypage">
			<ul class="chat">

			</ul>
		</div>
	</div>

	<!-- /.panel-body -->
	<div class="panel-footer">
		<div class="input-group">
			<sec:authorize access="isAuthenticated()">
			<input id="btn-input" class="form-control input-sm" placeholder="Type your message here..." name="firstreply">
			<span class="input-group-btn">
				<button class="btn btn-warning btn-sm" id="addReplyBtn">Reply</button>
			</span>
			</sec:authorize>
		</div>
	</div>
	<!-- /.panel-footer -->
</div>






<!-- 댓글들!!!!!!!!!!!!!!!!!!!!! -->
<!-- 
<div class="row">
	<div class="col-lg-12">
		/.panel
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
			</div>

			/.panel-heading
			<div class="panel-body">
				<ul class="chat"></ul>
				./ end ul
			</div>
			<!— /.panel .chat-panel —>
			<div class="panel-footer"></div>
		</div>
	</div>
	<!— ./ end row —>
</div>
 -->
<!-- 파일들 -->

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label>
					<input class="form-control" name="reply" value="New Reply!!!!" />
				</div>
				<div class="form-group">
					<label>emp_no</label>
					<input class="form-control" name="emp_no" value="emp_no" />
				</div>
				<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control" name="reply_date" value="2018-01-01 13:13" />
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!— /.modal-content —>
	</div>
	<!— /.modal-dialog —>
</div>
<!— /.modal —>

<script type="text/javascript">
	
</script>

<script type="text/javascript" src="/resources/js/reply.js?v=222"></script>
<script type="text/javascript">
	$(document).ready(function() {
		console.log("++++++++++++++++++++++++++++++++++++++++++++++++++++++");
		var b_noValue = '<c:out value='${board.b_no}'/>';

		//로그인 시의 emp_no 값으로 바꿔줘야 함
		var emp_noValue = '<c:out value='${board.emp_no}'/>';

		var replyUL = $(".chat");

		var pageNum = 1;

		var replyPageFooter = $("#replypage");

		showList(1);
		//		showReplyPage(1);

		function showList(page) {
			replyService.getList({
				b_no : b_noValue,
				page : page
			}, function(replyCnt, list) {

				console.log(replyCnt);
				console.log(list);

				if (page == -1) {
					pageNum = Math.ceil(replyCnt / 10.0);
					showList(pageNum);
					return;
				}

				var str = "";
				//마지막 페이지하나 삭제되면 list 가 null이기 때문에 여기 처리해줘야함
				if (list == null || list.length == 0) {
					if (pageNum == 1) {
						replyUL.html("");
						return;
					}
					if (pageNum > 1) {
						pageNum--;
						showList(pageNum);
						return;
					}
					replyUL.html("");
					return;
				}

				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='left clearfix' data-r_no='"+list[i].r_no+"'>";
					str += '<span class="chat-img pull-left"> <img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle"></span>';
					str += '<div class="chat-body clearfix">';
					str += '<div class="header">';
					str += "<strong class='primary-font'>" + list[i].emp_no + "</strong>";
					str += "    <small class='pull-right text-muted'> <i class='fa fa-clock-o fa-fw'></i>" + replyService.displayTime(list[i].reply_date) + "</small></div>";
					str += "    <p>" + list[i].reply + "</p></div></li>";

				}
				replyUL.html(str);
				showReplyPage(replyCnt);
			});

		}//func showList END

		function showReplyPage(replyCnt) {

			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;

			var prev = startNum != 1;
			var next = false;

			if (endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt / 10.0);
			}

			if (endNum * 10 < replyCnt) {
				next = true;
			}

			var str = "<ul class='pagination pull-right'>";
			if (prev) {
				str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>Previous</a></li> ";
			}

			for (var i = startNum; i <= endNum; i++) {
				var active = (pageNum == i) ? "active" : "";
				str += "<li class='page-item " + active + "'><a class='page-link' href='"+i+"'>" + i + "</a></li>";
			}

			if (next) {
				str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li> ";
			}

			str += "</ul>";

			//console.log(str);

			replyPageFooter.html(str);

		} //show reply list

		//페이지리스트 누를 때마다 pageNum 새로 업데이트 됨
		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			var targetPageNum = $(this).attr("href");
			pageNum = targetPageNum;
			showList(pageNum);
		})

		var modal = $(".modal");

		//<input class="form-control" name='reply' value='New Reply!!!!'> 네임 reply인 input 속성 자체를 가져와서 집어넣음

		var modalInputReply = modal.find("input[name='reply']");
		var madalInputemp_no = modal.find("input[name='emp_no']");
		var modalInputreply_date = modal.find("input[name='reply_date']");

		//최초 바로 입력 시의 리플값
		var inputReply = $("#inputreply");
		var firstReply = inputReply.find("input[name='firstreply']");

		var modalModBtn = $('#modalModBtn');
		var modalRemoveBtn = $('#modalRemoveBtn');
		var modalRegisterBtn = $('#modalRegisterBtn');

		var replyer = null;
		
		<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';
		</sec:authorize>
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$("#addReplyBtn").on("click", function(e) {
			//input태그들 을 찾고 value를 ''로 넣는다.
			/*
			 modal.find("input").val("");
			 madalInputemp_no.removeAttr("readonly");
			 modalInputreply_date.closest("div").hide(); //.show(); 보여주겠다   closest 가장 가까운 부모요소... 하나
			 modal.find("button[id != 'modalCloseBtn']").hide();
			 modalRegisterBtn.show();

			 $(".modal").modal("show");
			 */
			 
			console.log(b_noValue);
			console.log(firstReply.val());
			console.log(emp_noValue);
			
			if(firstReply.val() === null || firstReply.val() === ""){
				alert("내용을 입력해주세요");
				return false;
			}
			
			var reply = {
				"b_no" : b_noValue,
				"reply" : firstReply.val(),
				"emp_no" : emp_noValue
			};
			replyService.add(reply, function(result) {
				alert(result);
				//		modal.find("input").val("");
				//		modal.modal("hide");
				showList(-1);
			});
		});
		/*
		 modalRegisterBtn.on("click", function(e) {
		 var reply = {
		 "b_no" : b_noValue,
		 "reply" : modalInputReply.val(),
		 "emp_no" : madalInputemp_no.val()
		 };
		 replyService.add(reply, function(result) {
		 alert(result);
		 modal.find("input").val("");
		 modal.modal("hide");
		 showList(-1);
		 });

		 });
		 */
		 
		//ajax 댓글 보안 관련 추가!!
		 $(document).ajaxSend(function(e, xhr, options){
			 xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		 });
		 
		$("#modalCloseBtn").on("click", function(e) {
			modal.find("input").val("");
			modal.modal("hide");
		});

		$(".chat").on("click", "li", function(e) {
			var r_no = $(this).data("r_no");
			replyService.get(r_no, function(reply) {
				modalInputReply.val(reply.reply);
				madalInputemp_no.val(reply.emp_no).attr("readonly", "readonly");
				//modalInputreply_date.val(reply.reply_date);
				modalInputreply_date.val(replyService.displayTime(reply.reply_date)).attr("readonly", "readonly");

				//modal에 r_no 저장해둘 것임
				modal.data("r_no", reply.r_no);

				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				modalInputreply_date.closest("div").show();
				$('.modal').modal("show");

			});
			//console.log(r_no);
		});
		/*
		modalModBtn.on("click", function(e) {
			var reply = {
				"reply" : modalInputReply.val(),
				"r_no" : modal.data("r_no")
			}

			replyService.update(reply, function(result) {
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				showList(pageNum);
			});

		});
		*/
		
		modalModBtn.on("click", function(e) {
			var reply = {
				"reply" : modalInputReply.val(),
				"r_no" : modal.data("r_no")
			}
			if(!replyer){
				alert("로그인 후 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			var originalReplyer = madalInputemp_no.val();
			
			if(replyer != originalReplyer){
				alert("자신이 작성한 댓글만 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			replyService.update(reply, function(result) {
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				showList(pageNum);
			});

		});
		
		
		/*
		modalRemoveBtn.on("click", function(e) {
			var r_no = modal.data("r_no");
			replyService.remove(r_no, function(result) {
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				showList(pageNum);
				//마지막 페이지하나 삭제되면 list 가 null이기 때문에 여기 처리해줘야함
			});
		});
		*/
		
		modalRemoveBtn.on("click", function(e) {
			var r_no = modal.data("r_no");
			if(!replyer){
				alert("로그인 후 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			var originalReplyer = madalInputemp_no.val();
			
			if(replyer != originalReplyer){
				alert("자신이 작성한 댓글만 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			replyService.remove(r_no, function(result) {
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				showList(pageNum);
				//마지막 페이지하나 삭제되면 list 가 null이기 때문에 여기 처리해줘야함
			});
		});
		

		/* function showList(page){
		     replyService.getList(
		        {b_no:b_noValue, page:page},
		        function(list){
		           var str = "";
		           if(list == null || list.length == 0){
		              replyUL.html("");
		              return;
		           }
		           for(var i=0, len=list.length || 0; i < len; i++){
		              str +="<li class='left clearfix' data-r_no='"+list[i].r_no+"'>";
		              str +="<div><div class='header'><strong class='primary-font'>"+list[i].emp_no+"</strong>";
		              str +="<small class='pull-right text-muted'>"
		                        + list[i].reply_date+"</small></div>";
		              str +="<p>"+list[i].reply+"</p></div></li>";
		           }
		           replyUL.html(str);
		        });
		  } */

		/*
		replyService.add(
				{reply:"JS TEST",emp_no:"tester",b_no:b_noValue},
				function(result){alert("RESULT : "+result);}
				); */
		//매개변수 생략 가능 자바스크립트에서는
		//추론형이기 때문에 function에 result 매개변수만 넣어도 됨
		/* replyService.getList({
			b_no : b_noValue,
			page : 1
		},
		function(list) {
			list.forEach(e=>console.log(e));
		}); */
		/* replyService.remove(10,function(result){
			alert("RESULT : "+ result);

		}); */

		/* 		replyService.update({r_no:11,reply:"변경변경변경!!!!!"},
		 function(result){
		 alert("RESULT : " + result);
		 }); */

		/* replyService.get(11,function(result){
			alert("RESULT : " + result);
			console.log(result);
		}); */

		console.log("++++++++++++++++++++++++++++++++++++++++++++++++++++++");
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#b_no").remove();
			operForm.attr("action", "/board/list").submit();
		});
	});
</script>











<script>
	$(document).ready(function() {
		(function() {
			var b_no = '<c:out value="${board.b_no}" />';
			console.log(b_no);

			$.getJSON("/board/getAttachList", {
				b_no : b_no
			}, function(arr) {

				var str = "";
				//var foto = "";
				var photo = "";

				$(arr).each(function(i, attach) {
					console.log("attach");
					//image type
					if (attach.file_Type) {
						var fileCallPath = encodeURIComponent(attach.upload_Path + "/s_" + attach.uuid + "_" + attach.file_Name);
						str += "<li data-path='"+attach.upload_Path+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.file_Name+"' data-type='"+attach.file_Type+"' ><div>";
						str += "<img src='/display?file_Name=" + fileCallPath + "'>";
						str += "</div>";
						str += "</li>";
						
						
						photo += '<a href="/display?file_Name='+fileCallPath+'" class="js-smartPhoto" data-caption="bear" data-id="bear" data-group="animal">';
					  	photo += "<img src='/display?file_Name="+fileCallPath+"'/>";
						photo +="</a>";
			//			foto += "<img src='/display?file_Name=" + fileCallPath + "'>";
					} else {
						str += "<li data-path='"+attach.upload_Path+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.file_Name+"' data-type='"+attach.file_Type+"' ><div>";
						str += "<span> " + attach.file_Name + "</span><br/>";
						str += "<img src='/resources/img/attach.png'></a>";
						str += "</div>";
						str += "</li>";
					}
				});

				$(".uploadResult ul").html(str);
				$(".sphoto").html(photo);
				$(".js-smartPhoto").SmartPhoto();
				//$(".js-smartPhoto").SmartPhoto();
		/* 		setTimeout(function() {
					$(".js-smartPhoto").SmartPhoto();
			}, 3000); */
			//	$(".fotorama").html(foto);
			//	$(".fotorama").fotorama();
			});
		})();
		//즉시실행함수로 페이지 로딩 시에 바로 불러옴ㅇ...
		
		
		
		$(".uploadResult").on("click", "li", function(e) {
			console.log("view image");
			var liObj = $(this);

			var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
			if (liObj.data("type")) {
				showImage(path);
			} else {
				self.location = "/download?file_Name=" + path;
			}
		});// upliadResult li click end 

		function showImage(fileCallPath) {
			alert(fileCallPath);
			$(".bigPictureWrapper").css("display", "flex").show();
			$(".bigPicture").html("<img src='/display?file_Name=" + fileCallPath + "'>").animate({
				width : '100%',
				height : '100%'
			}, 1000);
		}

		$(".bigPictureWrapper").on("click", function(e) {
			$(".bigPicture").animate({
				width : '0%',
				height : '0%'
			}, 1000);
			setTimeout(function() {
				$(".bigPictureWrapper").hide();
			}, 1000);
		});

	});
</script>


<%@include file="../includes/footer.jsp"%>