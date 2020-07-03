<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Adminmart Template - The Ultimate Multipurpose admin template</title>
    <link href="/resources/assets/dataTables.bootstrap4.css" rel="stylesheet">
    <link href="/resources/assets/style.min.css" rel="stylesheet">
    <link href="/resources/assets/customstyle.css" rel="stylesheet">
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <script type="text/javascript" src="/resources/assets/variable.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

</head>

<body>
<div class="preloader">
    <div class="lds-ripple">
        <div class="lds-pos"></div>
        <div class="lds-pos"></div>
    </div>
</div>
<div id="main-wrapper" data-theme="light" data-navbarbg="skin6" data-header-position="fixed" data-boxed-layout="full">
    <header class="topbar" data-navbarbg="skin6">
    </header>
    <div class="page-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive">
                                <form>
                                    <input name="searchForm" type="checkbox" value="T">제목
                                    <input name="searchForm" type="checkbox" value="C">내용
                                    <input name="searchForm" type="checkbox" value="W">작성자
                                    <input id="searchKeyword" type="text">
                                    <button class="btn btn-outline-primary ns" id="searchBtn" type="button">검색
                                    </button>
                                    <button class="btn btn-outline-secondary ns" id="searchCancleBtn" type="button">검색/정렬해제 </button>
                                    <b>게시글</b>
                                    <select id="selectedAmount">
                                        <option value="10">10개</option>
                                        <option value="20">20개</option>
                                        <option value="30">30개</option>
                                    </select>
                                    <b>씩 보기</b>
                                </form>
                                <table id="zero_config" class="table table-striped table-bordered no-wrap ns">
                                    <thead>
                                    <tr style="text-align: center">
                                        <th>번호</th>
                                        <th>작성자</th>
                                        <th onclick="sortBy('title')" style="cursor: pointer">제목 <img src="/resources/assets/sortbyicon2.jpg"></th>
                                        <th onclick="sortBy('regdate')" style="cursor: pointer">등록일<img src="/resources/assets/sortbyicon2.jpg"></th>
                                        <th onclick="sortBy('views')" style="cursor: pointer">조회수<img src="/resources/assets/sortbyicon2.jpg"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="boardListBody">
                                    </tbody>
                                </table>
                            </div>
                            <div class="customBtnArea">
                                <button class="btn btn-outline-secondary ns" data-toggle="modal"
                                        data-target="#writeBoardModal" type="button">글쓰기
                                </button>
                            </div>
                            <ul class="pagination">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


    <!-- start of 글쓰기 modal -->
    <div class="modal fade custom-modal-css" id="writeBoardModal" tabindex="-1" role="dialog"
         aria-labelledby="regiModal"
         aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title ns" id="regiModal">글쓰기</h5>
                    <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body register-board-body">
                    <form>
                        <div class="form-group">
                            <label for="regiModal-title" class="col-form-label">제목</label>
                            <input type="text" class="form-control" id="regiModal-title">
                        </div>
                        <div class="row">
                            <div class="col-8 col-sm-6 form-group">
                                <label for="regiModal-writer" class="col-form-label">작성자</label>
                                <input type="text" class="form-control" id="regiModal-writer">
                            </div>
                            <div class="col-4 col-sm-6 form-group">
                                <label for="regiModal-password" class="col-form-label">비밀번호</label>
                                <input type="password" class="form-control" id="regiModal-password">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="regiModal-content" class="col-form-label">내용</label>
                            <textarea class="form-control" id="regiModal-content" style="height: 200px"></textarea>
                        </div>
                        <hr>
                        <div class="form-group uploadDiv">
                            <p>첨부파일</p>
                            <input type="file" name="uploadFile" class="form-control" multiple>
                        </div>
                        <div id="regiModal-attachedFileListDiv">
                            <ul class="regiAndReadModiFileUl" id="regiModal-attachedFileListUl"></ul>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary closeModal" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="regiModal-registerBtn">등록</button>
                </div>
            </div>
        </div>
    </div>
    <!-- end of 글쓰기 modal-->

    <!-- start of 조회/수정/삭제 modal -->
    <div class="modal fade readModalArea custom-modal-css" id="ReadBoardModal" tabindex="-1" role="dialog"
         aria-labelledby="readModal"
         aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="width: 1000px">
                <div class="modal-header">
                    <h5 class="modal-title ns" id="readModal">현재글</h5>
                    <button type="button" class="btn-rounded" id="moveToPrevBoardBtn" onclick="moveTo('prev');">이전글</button>
                    <button type="button" class="btn-rounded" id="moveToNextBoardBtn" onclick="moveTo('next');">다음글</button>
                    <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body register-board-body">
                    <div class="left">
                        <form>
                            <div class="form-group">
                                <label for="readModal-title" class="col-form-label">제목</label>
                                <input type="text" class="form-control" id="readModal-title">
                            </div>
                            <div class="row">
                                <div class="col-8 col-sm-6 form-group">
                                    <label for="readModal-writer" class="col-form-label">작성자</label>
                                    <input type="text" class="form-control" id="readModal-writer">
                                </div>
                                <div class="col-4 col-sm-6 form-group" id="passwordArea">
                                    <label for="readModal-password" class="col-form-label">비밀번호</label>
                                    <input type="password" class="form-control" id="readModal-password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="readModal-content" class="col-form-label">내용</label>
                                <textarea class="form-control" id="readModal-content" style="height: 200px"></textarea>
                            </div>
                            <hr>

                            <div class="form-group" id="uploadDivforModi" style="display: none">
                                <p>첨부파일</p>
                                <input type="file" name="uploadFile" class="form-control"  multiple>
                            </div>
                            <div id="form-group readModal-attachedFileListDiv">
                                <ul id="readModal-attachedFileListUl"></ul>
                            </div>

                        </form>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="readModal-updateBtn"
                                    style="display: none">
                                수정완료
                            </button>
                            <button type="button" class="btn btn-primary" id="readModal-modiBtn">수정</button>
                            <button type="button" class="btn btn-danger" id="readModal-deleteBtn">삭제</button>
                            <button type="button" class="btn btn-secondary closeModal" data-dismiss="modal">닫기</button>
                        </div>
                    </div>
                    <!--  end of left-->
                    <div class="right" id="replyArea">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-8 col-sm-6 form-group">
                                    <input type="text" class="form-control" id="readModal-reply-writer"
                                           placeholder="작성자">
                                </div>
                                <div class="col-4 col-sm-6 form-group">
                                    <input type="password" class="form-control" id="readModal-reply-password"
                                           placeholder="비밀번호">
                                </div>
                            </div>
                            <input type="text" class="form-control" id="readModal-reply-content"
                                   placeholder="내용을 입력하세요">
                            <input type="button" class="form-control btn-primary" id="replyRegiBtn" value="댓글등록">
                            <input type="button" class="form-control btn-secondary" id="replyModiBtn" value="수정완료"
                                   style="display: none">
                        </div>
                        <div id="reaplyListArea" style="width:500px !important">
                            <table id="replyTable">
                            </table>
                        </div>
                    </div>
                    <!-- end of right (replyarea) -->
                </div>
            </div>
        </div>
    </div>
        <!-- end of 조회/수정/삭제 modal-->

       <!-- start of 비밀번호 입력 Modal -->
        <div class="modal fade" id="passwordInputModal" tabindex="-1" role="dialog"
             aria-labelledby="passwordInputModalTitle" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 id="password-modal-title"></h5>
                        <button type="button" class="close pwModalClose">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>비밀번호를 입력하세요</p>
                        <input type="password" id="pwForAuthCheck">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary pwModalClose">닫기</button>
                        <button type="button" class="btn btn-primary" id="passwordCheck">확인</button>
                    </div>
                </div>
            </div>
            <!-- end of 비밀번호 입력 Modal -->

        </div>

        <script src="https://code.jquery.com/jquery-3.4.1.min.js"
                integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
                crossorigin="anonymous"></script>
        <script src="/resources/assets/popper.min.js"></script>
        <script src="/resources/assets/bootstrap.min.js"></script>
        <script src="/resources/assets/app-style-switcher.js"></script>
        <script src="/resources/assets/feather.min.js"></script>
        <script src="/resources/assets/perfect-scrollbar.jquery.min.js"></script>
        <script src="/resources/assets/sparkline.js"></script>
        <!--<script src="variable.js"></script>-->
        <script src="/resources/assets/custom.min.js"></script>
        <script src="/resources/utils/ajaxUtil.js"></script>

        <script>

            const API_Server = new URL("http://localhost:8080/");
            var amount = 10;
            var staticCurrPage;
            var staticCurrSearchOption;
            var staticCurrSearchKeyword;
            var staticSelectedBoard;
            var staticSelectedReply;
            var items;
            var finalFileFormData = new Array();
            var $uploadDiv = $(".uploadDiv");
            var $cloneObj =  $uploadDiv.clone();
            var $uploadDivforModi = $("#uploadDivforModi");
            var $cloneObjforModi = $uploadDivforModi.clone();
            var tof = true;
            var staticCurrSortStatus = '';


            // tag maker - 게시글들
            function makeBoardListTag(data) {
                let tagString = '';
                let count = data.total - ((staticCurrPage-1)*amount);
                // 등록일 월도,시간 한자릿수 계산해서 0 추가해주기
                data.list.forEach(board => {
                    let titleString = board.title;
                    if(board.atcount!=0){
                        titleString += '<img src="/resources/assets/existfileicon.png">';
                    }
                    if (board.rcount == 0) {
                        tagString += '<tr class="eachBoard" onclick="read(' + board.bno +','+count+');"><td>' + count + '</td><td>' + board.writer + '</td><td>' + titleString + '</td><td>'
                            + board.regdate.year + '.' + board.regdate.monthValue + '.' + board.regdate.dayOfMonth + '  ' + board.regdate.hour + ':' + board.regdate.minute
                            + '</td><td>' + board.views + '</td></tr>';
                    } else {
                        tagString += '<tr class="eachBoard" onclick="read(' + board.bno +','+count+');"><td>' + count + '</td><td>' + board.writer + '</td><td>' + titleString + '[' + board.rcount + ']</td><td>'
                            + board.regdate.year + '.' + board.regdate.monthValue + '.' + board.regdate.dayOfMonth + '  ' + board.regdate.hour + ':' + board.regdate.minute
                            + '</td><td>' + board.views + '</td></tr>';
                    }
                    count = count-1;
                })
                return tagString;
            }

            // tag maker - 페이지 li태그
            function makeBoardPageliTag(data) {
                let tagString = '<li class="page-item" id="zero_config_previous">';
                tagString += '<a href="#" aria-controls="zero_config" class="page-link" onclick="movePage(\'prev\')"><</a></li>';
                let tmpString = '';
                for (let i = data.startPage; i <= data.endPage; i++) {
                    tmpString += '<li class="page-item each-number" id="pageNum' + i + '"><a href="#" onclick="movePage(' + i + ');" aria-controls="zero_config" data-dt-idx="' + i + '" tabindex="0" class="page-link each_page">' + i + '</a></li>';
                }
                tagString += tmpString;
                tagString += '<li class="page-item" id="zero_config_next">';
                tagString += '<a href="#" aria-controls="zero_config" class="page-link" onclick="movePage(\'next\')">></a></li>';
                return tagString;
            }

            // tag maker - 댓글리스트
            function makeReplyListTag(data) {
                let tagString = '';
                data.forEach(reply => {
                    tagString += '<tr>';
                    tagString += '<td class="replyWriterTD">' + reply.writer + '</td><td class="replyContentTD" style="word-break:break-all"><div class="replyContentDIV" style="overflow-y:scroll; width:260px;  height:48px;">' + reply.content + '</div></td><td class="replyDateTD">';
                    tagString += reply.regdate.year + '.' + reply.regdate.monthValue + '.' + reply.regdate.dayOfMonth + ' ' + reply.regdate.hour + ':' + reply.regdate.minute;
                    tagString += '</td><td class="replyButtonTD" style="width : 50px;"><a class="replyModi" onclick="modifyReply(' + reply.rno + ');" id="rmodi' + reply.rno + '">수정</a><br><a class="replyDel" onclick="deleteReply(' + reply.rno + ');" id="rdel' + reply.rno + '">삭제</a></td><td class="replyReplyTD" style="width:40px">댓글</td></tr>'
                })
                return tagString;
            }

            // 하단의 페이지 리스트 클릭시 해당 페이지의 글 목록을 가져오고 페이지 리스트를 재조정하는 function
            function movePage(pageNum, option, searchKeyword, sortBy, order) {
                let currentPage = pageNum;
                let searchOption;
                let keyword;
                console.log("WELCOME")

                if (currentPage == 'prev') {
                    currentPage = (parseInt($(".each-number").first().text())) - 1
                } else if (currentPage == 'next') {
                    currentPage = (parseInt($(".each-number").last().text())) + 1
                }

                if (option == null || searchKeyword == null) {
                    //파라미터로 두개의 값이 안들어온경우 (ul에서 누른경우)
                    //static에 저장되어있으면 그 값을 넣어줌
                    searchOption = staticCurrSearchOption;
                    keyword = staticCurrSearchKeyword;
                } else {
                    //파라미터로 두개의 값이 들어온경우(첫검색) 검색옵션과 키워드를 obj에 넣어 같이 보냄.
                    searchOption = option;
                    keyword = searchKeyword;
                }


                // 정렬클릭시
                if (sortBy != null && order != null) {
                    var pageInfoObj = {
                        'pageRequest': currentPage,
                        'amount': amount,
                        'searchOption': searchOption,
                        'keyword': keyword,
                        'sort.sortBy' : sortBy,
                        'sort.order' : order
                    }
                } else {
                    var pageInfoObj = {
                        'pageRequest': currentPage,
                        'amount': amount,
                        'searchOption': searchOption,
                        'keyword': keyword
                    }
                }

                console.log("----before ajax")

                ajaxService.getAjax(API_Server.commonURL + "list", pageInfoObj, success)

                console.log("----after ajax")

                function success(data) {
                    console.log("-----왜!!!!!!!")
                    console.log(data)
                    if (data.total == 0) {
                        alert("검색 결과가 없습니다.")
                        return;
                    }
                    staticCurrSortStatus = sortBy;
                    staticCurrPage = currentPage;
                    staticCurrSearchOption = searchOption;
                    staticCurrSearchKeyword = keyword;
                    items.$tbody.html(makeBoardListTag(data));
                    items.$pageUl.html(makeBoardPageliTag(data));

                    if (document.getElementById('pageNum' + staticCurrPage) != null) {
                        document.getElementById('pageNum' + staticCurrPage).className += " " + 'active';
                    } else {
                        document.getElementById('zero_config_previous').innerHTML = ""
                        document.getElementById('zero_config_next').innerHTML = ""
                    }

                    if (data.prev == false) {
                        // items.$prevBtn.addClass('disabled')
                        $("#zero_config_previous").addClass('disabled')
                    }
                    if (data.next == false) {
                        // items.$nextBtn.addClass('disabled')
                        $("#zero_config_next").addClass('disabled')
                    }
                }
            }


            // 전, 후 게시글 번호
            function moveTo(target) {
                let moving = {
                    'bno' : staticSelectedBoard,
                    'direction' : target == 'prev' ? 'prev' : 'next'
                }
                console.log(moving)
                ajaxService.getAjax(API_Server.commonURL + "board/moveto",moving,success);

                function success(data) {
                    console.log(data);
                    if(data==0) {
                        if(target=='prev'){
                            alert("첫 번째 게시글 입니다.")
                        } else {
                            alert("마지막 게시글 입니다.")
                        }
                    } else {
                        read(data);
                    }
                }
            }

            // 정렬
            function sortBy(target) {
                console.log(target)
                console.log(tof)
                tof = !tof;
                movePage(1, staticCurrSearchOption, staticCurrSearchKeyword, target, tof)
            }

            // 첫 로딩시 실행되는 함수. 페이지를 로드 & 하단 페이징
            function firstLoading() {
                staticCurrSearchOption = '';
                staticCurrSearchKeyword = '';

                let pageInfoObj = {
                    'pageRequest': 1,
                    'amount': amount,
                    'searchOption': staticCurrSearchOption,
                    'keyword': staticCurrSearchKeyword
                }

                ajaxService.getAjax(API_Server.commonURL + "list", pageInfoObj, success)

                function success(data) {
                    console.log("--after firstloading")
                    console.log(data)
                    items = item();
                    staticCurrPage = 1;
                    items.$tbody.html(makeBoardListTag(data));
                    items.$pageUl.html(makeBoardPageliTag(data));
                    document.getElementById('pageNum' + staticCurrPage).className += " " + 'active';
                    items.$prevBtn.addClass('disabled')
                    items.$prevBtn.addClass('disabled')

                    $("#zero_config_previous").addClass('disabled')

                    if (data.next == false) {
                        $("#zero_config_next").addClass('disabled')
                    }
                }
            }

            // 파일 유효성 검사
            function validateFile(fileName, fileSize) {
                console.log("파일유효성")
                var regex = new RegExp("(.*?)\.(exe|jsp|js|css|html)$");
                var spcCheck = /[~!@#$%^&*()+|<>?:{}]/;
                var maxSize = 20971520;
                if (fileSize > maxSize) {
                    alert("업로드 가능한 파일 크기를 초과했습니다.")
                    return false;
                };
                if (regex.test(fileName)) {
                    alert("해당 형식의 파일은 업로드 할 수 없습니다.")
                    return false;
                };
                if(spcCheck.test(fileName)){
                    alert("파일명에 허용되지 않는 특수문자가 있습니다.")
                    return false;
                }
                return true;
            }

            // 치환되지 않는 script 태그 역치환해주는 function
            String.prototype.unescapeHtml = function(){
                return this.replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, "\"");
            };

            // 게시글 조회
            function read(bno) {
                ajaxService.getAjaxExceptedtData(API_Server.commonURL + "board/" + bno, success)

                function success(data) {
                    console.log("-----------가져온 데이터확인")
                    console.log(data)
                    document.getElementById("readModal-attachedFileListUl").innerHTML = "";
                    makeAttachmentListLiTag(data.attachedList)
                    staticSelectedBoard = data.bno;
                    items.$readBoardModal.modal('show');
                    items.$readTitle.val(data.title.unescapeHtml()).attr('disabled', true);
                    items.$readContent.html(data.content).attr('disabled', true);
                    items.$readWriter.val(data.writer).attr('disabled', true);
                    items.$readPassword.css('display', 'none')
                    items.$readPasswordInput.attr('disabled', true).val(data.password)

                    if (data.rcount != 0) {
                        ajaxService.getAjaxExceptedtData(API_Server.commonURL + "reply/" + bno, success)
                        function success(data) {
                            items.$replyTable.html(makeReplyListTag(data))
                        }
                    } else {
                        items.$replyTable.html("")
                    }
                }
            }

            // 새탭에서 이미지 열기
            function showImage(fileName) {
                window.open(API_Server.commonURL+"/display?fileName="+fileName);
            }

            // 비밀번호 성공시 조회창을 수정가능하게 만드는 function
            function makeModifyingAvailable() {
                items.$readTitle.attr('disabled', false);
                items.$readContent.attr('disabled', false);
                items.$readPassword.css('display', 'inline-block');
                items.$modiBtnInReadModal.css('display', 'none');
                items.$deleteBtnInReadModal.css('display', 'none');
                items.$finalUpdateBtnInReadModal.css('display', 'inline-block');
                let attachlist = $("#readModal-attachedFileListUl");
                if(attachlist[0].childElementCount!=0) {
                    $(".xicon").css('display','inline-block')
                }
                console.log("-----")
                $("#replyArea").css('display','none');
                $("#uploadDivforModi").css('display','inline-block')
            }

            // 조회창의 첨부파일 리스트 maker
            function makeAttachmentListLiTag(attachmentList) {
                let $fileListBox = $("#readModal-attachedFileListUl");
                let $frag = $(document.createDocumentFragment());
                attachmentList.forEach(attachment => {
                    let attachmentObj = {
                        'path' : attachment.path,
                        'uuid' : attachment.uuid,
                        'name' : attachment.name,
                        'image' : ''
                    }
                    finalFileFormData.push(attachmentObj)
                    let target = "'"+attachment.uuid+attachment.name+"'";
                    let fileFullName = "";
                    let fileFullNameExceptTh =""
                    if(attachment.image=='1') {
                        attachmentObj.image = 1;
                        fileFullName = encodeURIComponent(attachment.path+"/th_"+attachment.uuid+attachment.name);
                        fileFullNameExceptTh = "'"+encodeURIComponent(attachment.path+"/"+attachment.uuid+attachment.name)+"'";
                        $frag.append('<li class= "boardAttached" id="'+(attachment.uuid+attachment.name)+'"><img src='+API_Server.commonURL+'/display?fileName='+fileFullName+
                            ' style="display: block; cursor: pointer;" onclick="showImage('+fileFullNameExceptTh+');">'+attachment.name+'<img src="/resources/assets/xicon2.png" class="xicon" style="cursor: pointer; display: none;" onclick="deleteFileTag('+target+');">'+'</li>');
                    } else {
                        fileFullName = encodeURIComponent(attachment.path+"/"+attachment.uuid+attachment.name);
                        attachmentObj.image = 0;
                        $frag.append('<li id="'+(attachment.uuid+attachment.name)+'"><a href='+API_Server.commonURL+'/download?wholeFileName='+fileFullName+'><img src="/resources/assets/fileicon.png" style="display: block; cursor: pointer; width: 100px; height: 100px;"></a>'+
                            attachment.name+'<img src="/resources/assets/xicon2.png" class="xicon" style="cursor: pointer; display: none;" onclick="deleteFileTag('+target+');">'+'</li>');
                    }
                    $fileListBox.append($frag);
                })
            }

            // modal창 내용을 전체 reset 해주는 function
            function allFormsReset() {
                items.$modiBtnInReadModal.css('display', 'inline-block');
                items.$deleteBtnInReadModal.css('display', 'inline-block');
                items.$finalUpdateBtnInReadModal.css('display', 'none');
                document.getElementById("regiModal-title").value = "";
                document.getElementById("regiModal-writer").value = "";
                document.getElementById("regiModal-password").value = "";
                document.getElementById("regiModal-content").value = "";
                document.getElementById("pwForAuthCheck").value = "";
                document.getElementById("readModal-reply-writer").value = "";
                document.getElementById("readModal-reply-password").value = "";
                document.getElementById("readModal-reply-content").value = "";
                items.$replyWriter.attr('disabled', false);
                items.$replyPassword.attr('disabled', false);
                items.$replyModiBtn.css('display','none');
                items.$replyRegiBtn.css('display','inline-block');
                finalFileFormData = new Array();
                $("#uploadDivforModi").css('display','none')
                $("#replyArea").css('display','inline-block')
                document.getElementById("readModal-attachedFileListUl").innerHTML = "";
                document.getElementById("regiModal-attachedFileListUl").innerHTML = "";
            }

            // 댓글 삭제
            function deleteReply(rno) {
                let replyPasswordInput = prompt('비밀번호를 입력하세요.')

                // 비밀번호 입력창 취소 누른 경우
                if (replyPasswordInput == null) {
                    return
                }
                let rnoAndPassword = {
                    'bno': rno,
                    'password': replyPasswordInput,
                    'type': 'reply'
                }

                ajaxService.postAjax(API_Server.commonURL + "authcheck", rnoAndPassword, success, fail)

                function success(data) {
                    let deleteCheck = confirm("정말 삭제하시겠습니까?");
                    if (deleteCheck) {
                        ajaxService.deleteAjax(API_Server.commonURL + "reply/" + rno, "", success)
                        function success(data) {
                            alert("삭제가 완료되었습니다.")
                            read(staticSelectedBoard)
                        }
                    } else return;
                }
                // 비밀번호 실패시 입력창 다시 띄움
                function fail(data) {
                    alert(data.responseJSON.message)
                    deleteReply(rno);
                }
            }

            // 댓글 수정
            function modifyReply(rno) {
                let replyPasswordInput = prompt('비밀번호를 입력하세요.')

                // 비밀번호 입력창 취소 누른 경우
                if (replyPasswordInput == null) {
                    return;
                }
                let rnoAndPassword = {
                    'bno': rno,
                    'password': replyPasswordInput,
                    'type': 'reply'
                }

                ajaxService.postAjax(API_Server.commonURL + "authcheck", rnoAndPassword, success, fail)

                function success(data) {
                    staticSelectedReply = rno;
                    ajaxService.getAjaxExceptedtData(API_Server.commonURL + "reply/forUpdate/" + rno, success)

                    // 댓글 입력창에 해당 댓글 내용을 불러오고 수정가능한 상태로 만듦.
                    function success(data) {
                        items.$replyWriter.val(data.writer).attr('disabled', true);
                        items.$replyPassword.val(data.password).attr('disabled', true);
                        items.$replyContent.val(data.content);
                        items.$replyRegiBtn.css('display', 'none');
                        items.$replyModiBtn.css('display', 'inline-block')
                        items.$replyContent.focus();
                    }
                }

                function fail(data) {
                    alert(data.responseJSON.message)
                    modifyReply(rno)
                }
            }


            // 게시글 등록창에서 파일을 삭제한경우
            function deleteFileTag(targetFile) {
                finalFileFormData.forEach(function(item, index) {
                    console.log(targetFile)
                    console.log(item.uuid+item.name)
                  if(item.uuid+item.name == targetFile) {
                      finalFileFormData.splice(index,1);
                      var deleteTarget = document.getElementById(targetFile);
                      deleteTarget.parentNode.removeChild(deleteTarget);
                  }
                })
            }



            $(document).ready(() => {

                console.log("dom loading is done")
                // 처음 page 로딩시 1페이지를 보여줌.
                items = item();
                firstLoading();

                // [CREATE]  게시글 등록 버튼 클릭 Event
                items.$registerBoardBtn.on('click', function (e) {
                    e.preventDefault();
                    let resultObj =  checkValid('board','regi');
                    if(!resultObj.status) {
                        // 유효성검사 통과 못한 경우
                        alert(resultObj.faliMsg);
                        document.getElementById(resultObj.focusTarget).focus();
                    }
                    else {
                        console.log("valid pass")
                        let board = modalForm();
                        board.regiFormObj.attachedList = finalFileFormData;
                        ajaxService.postAjax(API_Server.commonURL + "board", board.regiFormObj, success, fail)

                        function success(data) {
                            $(".closeModal").click();
                            alert("글 등록이 완료되었습니다.")
                            finalFileFormData = new Array();
                            movePage(1);
                            $uploadDiv.html($cloneObj.html());
                        }

                        function fail(data) {
                            console.log(data)
                           // let failMSG = data.responseJSON.message;
                            // alert(failMSG)
                            // onfocus(failMSG, 'regi')
                        }
                    }

                })

                $("#selectedAmount").on('change',()=>{
                    amount = $("#selectedAmount").val();
                    movePage(1, staticCurrSearchOption, staticCurrSearchKeyword);

                })


                // [READ] 글 목록의 게시글 클릭시 Event > 왜 jQuery 동작 안하냐...  > onclick()으로 갈음. 수정할것
                // $('.eachBoard').on('click',function(e) {
                //     e.preventDefault();
                //     console.log("꺄아~~!")
                //     console.log(this)
                // });

                // 조회화면의 수정버튼 이벤트 > 클릭 시 비밀번호 입력 모달을 띄움
                items.$modiBtnInReadModal.on('click', (e) => {
                    e.preventDefault()
                    items.$passwordInputModal.modal('show');
                    items.$passwordModalTitle.html('수정하기');
                    items.$pwForAuthCheck.focus();
                })

                // 조회화면의 삭제버튼 이벤트 > 클릭 시 비밀번호 입력 모달을 띄움
                items.$deleteBtnInReadModal.on('click', () => {
                    items.$passwordInputModal.modal('show');
                    items.$passwordModalTitle.html('삭제하기');
                    items.$pwForAuthCheck.focus();
                })

                // 수정/삭제시 비밀번호 모달창에 입력한 비밀번호를 체크하는 function
                $("#passwordCheck").on('click', () => {
                    if (items.$pwForAuthCheck.val() == "") {
                        alert("비밀번호를 입력해주세요.")
                        items.$pwForAuthCheck.focus();
                        return
                    }

                    let bnoAndPassword = {
                        'bno': staticSelectedBoard,
                        'password': items.$pwForAuthCheck.val(),
                        'type': 'board'
                    }

                    ajaxService.postAjax(API_Server.commonURL + "authcheck", bnoAndPassword, success, fail)

                    function success() {
                        items.$pwForAuthCheck.val("")
                        items.$passwordInputModal.modal('hide');

                        // 수정버튼 > 비번체크 success > 조회창의 게시글을 수정가능한 상태로 만듦
                        if (items.$passwordModalTitle.html().startsWith('수정')) {
                            makeModifyingAvailable();
                        } else {
                            let check = confirm("정말 삭제하시겠습니까?")
                            if (check) {
                                ajaxService.deleteAjax(API_Server.commonURL + "board/" + staticSelectedBoard, "", success)

                                function success() {
                                    alert("삭제가 완료되었습니다.")
                                    $(".closeModal").click();
                                    movePage(1);
                                }
                            }
                        }
                    }

                    // 비밀번호 틀렸을때 입력창 focus
                    function fail(data) {
                        alert(data.responseJSON.message)
                        items.$pwForAuthCheck.val("").focus();
                    }
                })

                // 게시글 조회창 닫을때
                $(".closeModal").on("click", () => {
                    allFormsReset();
                    console.log("닫기")
                    movePage(staticCurrPage, staticCurrSearchOption, staticCurrSearchKeyword, staticCurrSortStatus, tof)
                })

                // (댓글) 최종 수정버튼 클릭시
                items.$replyModiBtn.on('click', () => {
                    console.log("수정-=----")
                    let resultObj = checkValid('reply','modi')
                    if(!resultObj.status) {
                        //유효성 통과 x
                        alert(resultObj.faliMsg)
                        document.getElementById(resultObj.focusTarget).focus();
                    } else {
                        let check = confirm("수정하시겠습니까?");
                        if (check) {
                            let replyObj = {
                                'rno': staticSelectedReply,
                                'writer': document.getElementById("readModal-reply-writer").value,
                                'password': 'ENCODE',
                                'content': document.getElementById("readModal-reply-content").value
                            }
                            ajaxService.putAjax(API_Server.commonURL + "reply", replyObj, success, fail)

                            function success() {
                                alert("댓글 수정이 완료되었습니다.")
                                allFormsReset();
                                read(staticSelectedBoard);
                            }

                            function fail(data) {
                                console.log(data.responseJSON.message);
                            }
                        }
                    }
                })

                // 글 수정
                items.$finalUpdateBtnInReadModal.on('click', () => {
                   let check = confirm("수정하시겠습니까?");
                    if (check) {
                        let board = modalForm();
                        board.readFormObj.password = 'ENCODE'
                        board.readFormObj.attachedList = finalFileFormData;
                        ajaxService.putAjax(API_Server.commonURL + "board", board.readFormObj, success, fail)

                        function success() {
                            alert("글 수정이 완료되었습니다.")
                            allFormsReset();
                            read(staticSelectedBoard);
                            // or replacewith
                            $uploadDivforModi.html($cloneObjforModi.html());
                            // $uploadDivforModi.html($cloneObjforModi.html());
                        }

                        function fail(data) {
                            console.log(data.responseJSON.message);
                        }
                    }
                })


                // 검색
                $("#searchBtn").on("click", () => {
                    let searchForm = document.getElementsByName('searchForm')
                    let category = '';
                    let nothing = true;
                    let keywordInput = document.getElementById('searchKeyword')

                    if(keywordInput.value == "" || keywordInput.value == null ) {
                        alert("검색 키워드를 입력하세요.")
                        keywordInput.focus();
                        return;
                    }

                    let formLength = searchForm.length;
                    for (let i = 0; i < formLength; i++) {
                        if (searchForm[i].checked == true) {
                            category += searchForm[i].value;
                            nothing = false;
                        }
                    }

                    if(nothing) {
                        alert("검색 유형을 선택해주세요.")
                        $("#searchKeyword").focus();
                        return;
                    }
                    movePage(1, category, document.getElementById('searchKeyword').value);
                })

                //검색조건해제
                $("#searchCancleBtn").on("click", () => {
                    staticCurrPage = 1;
                    staticCurrSearchOption = "";
                    staticCurrSearchKeyword = "";

                    document.getElementById("searchKeyword").value = "";
                    let searchForm = document.getElementsByName('searchForm')
                    let formLength = searchForm.length;
                    for (let i = 0; i < formLength; i++) {
                        if (searchForm[i].checked == true) {
                            searchForm[i].checked = false;
                        }
                    }
                    movePage(1);
                })

                // 댓글 등록 버튼 이벤트
                $("#replyRegiBtn").on("click", () => {
                    let resultObj = checkValid('reply','regi')
                    if(!resultObj.status) {
                        // 유효성 통과 못한경우
                        alert(resultObj.faliMsg);
                        document.getElementById(resultObj.focusTarget).focus();
                    } else {
                        let board = modalForm();
                        ajaxService.postAjax(API_Server.commonURL + "reply", board.replyFormObj, success, fail)

                        function success(data) {
                            console.log(data)
                            alert("댓글 등록이 완료되었습니다.")
                            allFormsReset()
                            read(staticSelectedBoard);
                        }

                        function fail(data) {
                            console.log(data.responseJSON.message)
                        }
                    }
                })

                $(".pwModalClose").on('click', (e) => {
                    e.preventDefault()
                    items.$passwordInputModal.modal('hide');
                })

                // 게시글 등록,수정시 파일 업로드창 chagne 감지
                $(".uploadDiv, #uploadDivforModi").on('change', function(e) {
                    let formData = new FormData();
                    let $inputFile = $(e.target);
                    let files = $inputFile[0].files;
                    let filesLength = files.length;
                    for(let i=0;i<filesLength;i++) {
                        if(validateFile(files[i].name,files[i].size)){
                            formData.append("uploadFile",files[i]);
                        }
                    }

                    $.ajax({
                        url:API_Server.commonURL+"saveFile",
                        processData : false,
                        contentType : false,
                        data : formData,
                        type:'POST',
                        success: function(data) {
                            console.log($inputFile.parent().siblings().find('ul'))
                            let $attachListBox = $inputFile.parent().siblings().find('ul');
                            let $frag = $(document.createDocumentFragment());
                            data.forEach(file => {
                                let attachment = {
                                    'path' : file.path,
                                    'uuid' : file.uuid,
                                    'name' : file.fileName,
                                    'image' : ''
                                }
                                let target = "'"+file.uuid+file.fileName+"'";
                                if(file.image=='y') {
                                    attachment.image = 1;
                                    let fileName = encodeURIComponent(file.path+"/th_"+file.uuid+file.fileName);
                                    $frag.append('<li id="'+(file.uuid+file.fileName)+'"><img src='+API_Server.commonURL+'/display?fileName='+fileName+
                                        ' style="display: block">'+file.fileName+'<img src="/resources/assets/xicon2.png" style="cursor: pointer" onclick="deleteFileTag('+target+');">'+'</li>');
                                } else {
                                    attachment.image = 0;
                                    $frag.append('<li id="'+(file.uuid+file.fileName)+'"><img src="/resources/assets/fileicon.png" style="display: block; width: 100px; height: 100px;">'+
                                        file.fileName+'<img src="/resources/assets/xicon2.png" style="cursor: pointer" onclick="deleteFileTag('+target+');">'+'</li>')
                                }
                                finalFileFormData.push(attachment);
                            })
                            $attachListBox.append($frag)
                        }
                    })
                });

                function checkValid(targetObj, regiOrModi){

                    let titleMsg = "제목은 1자 이상 30자 이하로 입력하세요."+"\n";
                    let writerMsg = "작성자명은 1자 이상 10자 이하로 입력하세요."+"\n";
                    let passwordMsg = "비밀번호는 4자 이상 12자 미만으로 설정하세요."+"\n";
                    let contentMsg = "내용은 1자 이상 2000자 이하로 입력하세요."+"\n";
                    let contentMsgForReply = "내용은 1자 이상 500자 이하로 입력하세요.";
                    let focusTarget = new Array();
                    let failMsg = "";
                    let resultObj = {
                        'status' : true,
                        'faliMsg' : "",
                        'focusTarget' : ""
                    }

                    if(targetObj == 'board') {
                        if(regiOrModi == 'regi') {
                            // 등록
                            if (items.$regiTitle.val() == "" || items.$regiTitle.val().length > 30) {
                                failMsg += titleMsg;
                                focusTarget.push('regiModal-title')
                            } if (items.$regiWriter.val() == "" || items.$regiWriter.val().length > 10) {
                                failMsg += writerMsg;
                                focusTarget.push('regiModal-writer')
                            } if (items.$regiPassword.val() == "" || items.$regiPassword.val().length > 12 || items.$regiPassword.val().length < 4) {
                                failMsg += passwordMsg;
                                focusTarget.push('regiModal-password')
                            } if (items.$regiContent.val() == "" || items.$regiContent.val().length > 2000) {
                                failMsg += contentMsg;
                                focusTarget.push('regiModal-content')
                            }
                        } else {
                            // 수정
                            if(items.$regiTitle.val() == "" || items.$regiTitle.val().length >30) {
                                failMsg += titleMsg;
                                focusTarget.push('regiModal-title')
                            } if(items.$regiContent.val() == "" || items.$regiContent.val().length > 2000 ){
                                failMsg += contentMsg;
                                focusTarget.push('regiModal-content')
                            }
                        }
                    } else { // 댓글
                        if(regiOrModi == 'regi') {
                            // 등록
                            if(items.$replyWriter.val() == "" || items.$replyWriter.val().length >10 ) {
                                failMsg += writerMsg;
                                focusTarget.push('readModal-reply-writer')
                            } if(items.$replyPassword.val() == "" || items.$replyPassword.val().length > 12 || items.$replyPassword.val().length < 4) {
                                failMsg += passwordMsg;
                                focusTarget.push('readModal-reply-password')
                            } if(items.$replyContent.val() == "" ||items.$replyContent.val().length > 500) {
                                failMsg += contentMsgForReply;
                                focusTarget.push('readModal-reply-content')
                            }
                        } else {
                            // 수정
                            if(items.$replyContent.val() == "" ||items.$replyContent.val().length > 500) {
                                failMsg += contentMsgForReply;
                                focusTarget.push('readModal-reply-content')
                            }
                        }
                    }
                    if(focusTarget.length == 0) {
                        return resultObj;
                    } else {
                        resultObj.faliMsg = failMsg;
                        resultObj.status = false;
                        focusTarget.some(target=> {
                            resultObj.focusTarget = target;
                            return true;
                        })
                    }
                    return resultObj;
                }

            }) // end of onready
        </script>
</body>

</html>