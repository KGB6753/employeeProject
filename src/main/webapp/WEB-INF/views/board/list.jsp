<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Board List Page      
				<button id="regBtn" type="button" class="btn btn-primary btn-xs pull-right">Register New Board</button>
			</div>
			<form id="searchForm" action="/board/list" method="get">
				<div class="col-xs-2">
					<select class="form-control" name="type">
						<option value="" <c:out value="${pageMaker.cri.type == null
                     ?'selected':''}" 
                     />>--</option>
						<option value="T" <c:out value="${pageMaker.cri.type eq 'T'
                     ?'selected':''}" 
                     />>제목</option>
						<option value="C" <c:out value="${pageMaker.cri.type eq 'C'
                     ?'selected':''}" 
                     />>내용</option>
						<option value="E" <c:out value="${pageMaker.cri.type eq 'E'
                     ?'selected':''}" 
                     />>작성자</option>
						<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'
                     ?'selected':''}" 
                     />>제목 OR 내용</option>
						<option value="TE" <c:out value="${pageMaker.cri.type eq 'TE'
                     ?'selected':''}" 
                     />>제목 OR 작성자</option>
						<option value="TEC" <c:out value="${pageMaker.cri.type eq 'TEC'
                     ?'selected':''}" 
                     />>제목 OR 내용 OR 작성자</option>
					</select>
				</div>
				<div class="col-xs-2" style="padding: 0px;">
					<input class="form-control" type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>" />
				</div>
				<div class="col-xs-2">
					<button class="btn btn-default">Search</button>
				</div>
				<input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum}" />" />
				<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount}" />" />
			</form>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty list}">
								<tr class="odd gradeX">
									<td colspan="5">[없음]
								</tr>
							</c:when>

							<c:when test="${!empty list}">
								<!-- c:out 으로 출력하는 이유는 보안때문 -->
								<c:forEach items="${list}" var="board">
									<tr class="odd gradeX">
										<td><c:out value="${board.b_no}" /></td>                                           
										<td><a class="move" href="<c:out value="${board.b_no}" />"><c:out value="${board.title}" /> <p class="fa fa-comments-o"><b><c:out value="${board.replycnt}" /></b></p></a></td>
										<td><c:out value="${board.emp_no}" /></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${board.reg_date }" /></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${board.update_date }" /></td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
					</tbody>
				</table>
				<!-- 페이징 처리 -->
				<div class='pull-right'>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<%-- <li class="paginate_button previous"><a href="?pageNum=${pageMaker.startPage-1 }">Previous</a></li> --%>
							<li class="paginate_button previous"><a href="${pageMaker.startPage-1 }">Previous</a></li>
						</c:if>

						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button ${pageMaker.cri.pageNum==num? 'active' : ''}"><a href="${num }">${num}</a></li>

						</c:forEach>

						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a href="${pageMaker.endPage+1 }">Next</a></li>
						</c:if>
					</ul>
				</div>
				<!-- /.table-responsive -->

				<form id="actionForm" action="/board/list" method="get">
					<input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum}" />" />
					<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount}" />" />
					<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type}" />" />
					<input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword}" />" />
				</form>

				<!-- MODAL 추가!!!!!!!!!!!!!!!! -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary">Save changes</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- MODAL 끝!!!!!!!!!!!!!!!!!!!!! -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>

<script type="text/javascript">


	$(document).ready(function() {

		/* history.pushState({"key":"value"},null,"/board/get?b_no=11") */
		//다시 요청되었을 때의 페이지를 매핑 가능함
		var result = '<c:out value="${result}"/>';

		checkModal(result);

		//마킹되어 있어서 다시 돌아올 때는 값을 가지고 있지 않게 됨.
		history.replaceState({}, null, null);

		function checkModal(result) {
			//히스토리 값을 가져오는데 값이 없어서 리턴으로 빠지게 됨
			if (result === '' || history.state) {
				return;
			}

			if (parseInt(result) > 0) {
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
				/* 태그가 감싸고 있는 내용... html */
			}

			$("#myModal").modal("show");
		}

		$('#regBtn').on('click', function() {
			self.location = "/board/register";
		});
		
		var actionForm = $("#actionForm");

		$(".paginate_button a").on("click", function(e) {

			e.preventDefault();

			console.log('click');

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			//	input 태그에 name이 pageNum인 것을 찾아라 그리고 여기에 href의 값을 넣어라
			actionForm.submit();
		});

		$(".move").on("click", function(e) {
			e.preventDefault();
			$("#b_no").remove();
			actionForm.append("<input type='hidden' id='b_no' name='b_no' value='" + $(this).attr("href") + "'/>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		});

		var searchForm = $('#searchForm');
		$('#searchForm button').on("click", function(e) {
			if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요.");
				return false;
			}
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요.");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit();
		});
	});
</script>

<%@include file="../includes/footer.jsp"%>