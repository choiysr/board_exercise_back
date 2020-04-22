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
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <script type="text/javascript" src="/resources/variable.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
    <style>
        .ns {
            font-family: 'Noto Sans KR', sans-serif;
        }

        .customBtnArea {
            text-align: right;
        }

        .eachBoard, .replyModi, .replyDel {
            cursor: pointer;
        }

        .eachBoard:hover {
            color: black;
            font-weight: bold;
        }

        .readModalArea {
            width: 100%;
        }

        .left {
            width: 50%;
            float: left;
            box-sizing: border-box;
        }

        .right {
            width: 50%;
            float: right;
            box-sizing: border-box;
        }

        .custom-modal-css {
            width: 100vw;
        }

        #replyTable {
            width: 100%;
            border-spacing: 1px;
            border-collapse: separate;
            font-size: small;
        }

        #replyWriterTD, #replyDateTD {
            text-align: center;
            width: 15%
        }

        #replyContentTD {
            text-align: center;
            width: 60%
        }

        #replyButtonTD {
            text-align: center;
            width: 25%
        }

        /*#regiModal-attachedFileListDiv img {*/
        /*    width: 100px;*/
        /*    height: 100px;*/
        /*}*/

        #regiModal-attachedFileListUl, #readModal-attachedFileListUl{
            list-style: none;
            margin: 0;
            padding: 0;
        }
        #regiModal-attachedFileListUl li, #readModal-attachedFileListUl li {
            margin: 0 0 0 0;
            padding: 0 0 0 0;
            border : 0;
            float: left;
        }


    </style>
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
                                    <button class="btn btn-outline-secondary ns" id="searchCancleBtn" type="button">
                                        	검색조건해제
                                    </button>
                                </form>
                                <table id="zero_config" class="table table-striped table-bordered no-wrap ns">
                                    <thead>
                                    <tr style="text-align: center">
                                        <th>번호</th>
                                        <th>작성자</th>
                                        <th>제목</th>
                                        <th>등록일</th>
                                        <th>조회수</th>
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
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
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
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title ns" id="readModal">READ</h5>
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

                            <div class="form-group uploadDivforModi" style="display: none">
                                <p>첨부파일</p>
                                <input type="file" name="uploadFile" class="form-control" multiple>
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

                        <div id="reaplyListArea">
                            <table id="replyTable">
                            </table>
                        </div>
                    </div>
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
        <script type="text/javascript" src="/resources/assets/popper.min.js"></script>
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
            const amount = 10;
            var staticCurrPage;
            var staticCurrSearchOption;
            var staticCurrSearchKeyword;
            var staticSelectedBoard;
            var staticSelectedReply;
            var items;
            var finalFileFormData = new Array();
            var $uploadDiv = $(".uploadDiv");
            var $cloneObj =  $uploadDiv.clone();
            var $uploadDivforModi = $(".uploadDivforModi");
            var $cloneObjforModi = $uploadDivforModi.clone();


            // tag maker - 게시글 리스트를 만듦. 
            function makeBoardListTag(data) {
                let tagString = '';
                // 등록일 월도,시간 한자릿수 계산해서 0 추가해주기
                data.forEach(board => {
                    if (board.rcount == 0) {
                        tagString += '<tr class="eachBoard" onclick="read(' + board.bno + ');"><td>' + board.bno + '</td><td>' + board.writer + '</td><td>' + board.title + '</td><td>'
                            + board.updateddate.year + '.' + board.updateddate.monthValue + '.' + board.updateddate.dayOfMonth + '  ' + board.updateddate.hour + ':' + board.updateddate.minute
                            + '</td><td>' + board.views + '</td></tr>';
                    } else {
                        tagString += '<tr class="eachBoard" onclick="read(' + board.bno + ');"><td>' + board.bno + '</td><td>' + board.writer + '</td><td>' + board.title + '[' + board.rcount + ']</td><td>'
                            + board.updateddate.year + '.' + board.updateddate.monthValue + '.' + board.updateddate.dayOfMonth + '  ' + board.updateddate.hour + ':' + board.updateddate.minute
                            + '</td><td>' + board.views + '</td></tr>';
                    }
                })
                return tagString;
            }

            // tag maker - 페이지li태그를 만듦. 
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

            // tag maker - 글 조회시 댓글 tag 만듦.
            function makeReplyListTag(data) {
                let tagString = '<tr><th id="replyWriterTD">작성자</th><th id="replyContentTD">내용</th><th id="replyDateTD">날짜</th><th id="replyButtonTD">수정/삭제</th></tr>';
                data.forEach(reply => {
                    tagString += '<tr>';
                    tagString += '<td>' + reply.writer + '</td><td>' + reply.content + '</td><td>';
                    tagString += reply.updateddate.year + '.' + reply.updateddate.monthValue + '.' + reply.updateddate.dayOfMonth + '  ' + reply.updateddate.hour + ':' + reply.updateddate.minute;
                    tagString += '</td><td><a class="replyModi" onclick="modifyReply(' + reply.rno + ');" id="rmodi' + reply.rno + '">수정</a><a class="replyDel" onclick="deleteReply(' + reply.rno + ');" id="rdel' + reply.rno + '">삭제</a></td>'
                })
                return tagString;
            }

            // 파일 유효성 검사 
            function validateFile(fileName, fileSize) {
                var regex = new RegExp("(.*?)\.(exe|jsp|js|css|html)$");
                var spcCheck = /[~!@#$%^&*()+|<>?:{}]/;
                var maxSize = 20971520;
                if (fileSize > maxSize) {
                    alert("업로드 가능한 파일 크기를 초과했습니다.")
                    return false;
                };
                if (regex.test(fileName)) {
                    alert("exe,jsp,js,css,html 파일은 업로드 할 수 없습니다.")
                    return false;
                };
                if(spcCheck.test(fileName)){
                    alert("파일명에 허용되지 않는 특수문자가 있습니다.")
                    return false;
                }
                return true;
            }


            // 하단의 페이지 리스트 클릭시 해당 페이지의 글 목록을 가져오고 페이지 리스트를 재조정하는 function
            // === 수정 필요
            // 페이지가 10페이지 이상이 넘겨지지 않으면(이전과 li생김새에 변함이 없으면) 리스트 다시 만들 필요 없음.
            function movePage(pageNum, option, searchKeyword) {
                let currentPage = pageNum;
                let searchOption;
                let keyword;

                if (currentPage == 'prev') {
                    currentPage = staticCurrPage - 1
                } else if (currentPage == 'next') {
                    currentPage = staticCurrPage + 1
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

                let pageInfoObj = {
                    'pageRequest': currentPage,
                    'amount': amount,
                    'searchOption': searchOption,
                    'keyword': keyword
                }


                ajaxService.getAjax(API_Server.commonURL + "list", pageInfoObj, success)

                function success(data) {
                    staticCurrPage = currentPage;
                    staticCurrSearchOption = searchOption;
                    staticCurrSearchKeyword = keyword;
                    items.$tbody.html(makeBoardListTag(data.list));
                    items.$pageUl.html(makeBoardPageliTag(data));

                    if (document.getElementById('pageNum' + staticCurrPage) != null) {
                        document.getElementById('pageNum' + staticCurrPage).className += " " + 'active';
                    } else {
                        document.getElementById('zero_config_previous').innerHTML = ""
                        document.getElementById('zero_config_next').innerHTML = ""
                    }

                    if (data.prev == false) {
                        // 여기서 왜 jquery 객체 안써지는지..??? 나중에 수정할것
                        // items.$prevBtn.addClass('disabled')
                        $("#zero_config_previous").addClass('disabled')
                    }
                    if (data.next == false) {
                        // items.$nextBtn.addClass('disabled')
                        $("#zero_config_next").addClass('disabled')
                    }
                }
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
                    items = item();
                    staticCurrPage = 1;
                    items.$tbody.html(makeBoardListTag(data.list));
                    items.$pageUl.html(makeBoardPageliTag(data));
                    document.getElementById('pageNum' + staticCurrPage).className += " " + 'active';
                    items.$prevBtn.addClass('disabled')
                    items.$prevBtn.addClass('disabled')
                    if (data.next == false) {
                        items.$nextBtn.addClass('disabled')
                    }
                }
            }

            // read()호출시 마다 조회수 카운팅됨. service수정하던지 어쩌던지 유효한 read만 카운팅되도록 수정할것. 
            function read(bno) {
                console.log("read실행")
                console.log(bno)
                ajaxService.getAjaxExceptedtData(API_Server.commonURL + "board/" + bno, success)

                function success(data) {
                    console.log("attach가져와지는지 확인")
                    console.log(data)
                    makeAttachmentListLiTag(data.attachedList)
                    staticSelectedBoard = data.bno;
                    items.$readBoardModal.modal('show');
                    document.getElementById("readModal").innerHTML = data.bno + "번 글"
                    items.$readTitle.val(data.title).attr('disabled', true);
                    items.$readContent.val(data.content).attr('disabled', true);
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

            function makeModifyingAvailable() {
                items.$readTitle.attr('disabled', false);
                items.$readContent.attr('disabled', false);
                // items.$readWriter.attr('disabled', false);
                items.$readPassword.css('display', 'inline-block');
                items.$modiBtnInReadModal.css('display', 'none');
                items.$deleteBtnInReadModal.css('display', 'none');
                items.$finalUpdateBtnInReadModal.css('display', 'inline-block');
                let attachlist = $("#readModal-attachedFileListUl");
                if(attachlist[0].childElementCount!=0) {
                    $(".xicon").css('display','inline-block')
                }
                $(".uploadDivforModi").css('display','inline-block')
            }

            // 조회창의 첨부파일 리스트
            function makeAttachmentListLiTag(attachmentList) {
                let fileListBox = $("#readModal-attachedFileListUl");
                attachmentList.forEach(attachment => {
                    //요기
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
                        fileListBox.append('<li class= "boardAttached" id="'+(attachment.uuid+attachment.name)+'"><img src='+API_Server.commonURL+'/display?fileName='+fileFullName+
                            ' style="display: block; cursor: pointer;" onclick="showImage('+fileFullNameExceptTh+');">'+attachment.name+'<img src="/resources/assets/xicon2.png" class="xicon" style="cursor: pointer; display: none;" onclick="deleteFileTag('+target+');">'+'</li>');
                    } else {
                        fileFullName = encodeURIComponent(attachment.path+"/"+attachment.uuid+attachment.name);
                        attachmentObj.image = 0;
                        fileListBox.append('<li id="'+(attachment.uuid+attachment.name)+'"><a href='+API_Server.commonURL+'/download?wholeFileName='+fileFullName+'><img src="/resources/assets/fileicon.png" style="display: block; cursor: pointer; width: 100px; height: 100px;"></a>'+
                            attachment.name+'<img src="/resources/assets/xicon2.png" class="xicon" style="cursor: pointer; display: none;" onclick="deleteFileTag('+target+');">'+'</li>');
                    }

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
                $(".uploadDivforModi").css('display','none')
                document.getElementById("readModal-attachedFileListUl").innerHTML = "";
                document.getElementById("regiModal-attachedFileListUl").innerHTML = "";
            }

            // 댓글 삭제
            // 비밀번호 fail시 재귀. -> prompt창 password형식으로 바꾸고 버튼이벤트 캐치하는걸로 수정할것(틀릴시 prompt창 안닫히게)
            function deleteReply(rno) {
                console.log(rno)
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
                    console.log(data)
                    let deleteCheck = confirm("정말 삭제하시겠습니까?");
                    if (deleteCheck) {
                        ajaxService.deleteAjax(API_Server.commonURL + "reply/" + rno, "", success)

                        function success(data) {
                            console.log("삭제성공")
                            console.log(data)
                            read(staticSelectedBoard)
                        }
                    } else return;
                }

                function fail(data) {
                    alert(data.responseJSON.message)
                    deleteReply(rno);
                }
            }

            // 댓글 수정
            // 비밀번호 fail시 재귀. -> prompt창 password형식으로 바꾸고 버튼이벤트 캐치하는걸로 수정할것(틀릴시 prompt창 안닫히게)
            function modifyReply(rno) {
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
                    staticSelectedReply = rno;
                    console.log("===password성공")
                    ajaxService.getAjaxExceptedtData(API_Server.commonURL + "reply/forUpdate/" + rno, success)

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

                items = item();
                firstLoading();

                // [CREATE]  게시글 등록 버튼 클릭 Event
                items.$registerBoardBtn.on('click', function (e) {
                    e.preventDefault();
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
                        alert(data.responseJSON.message)
                    }
                })


                // 조회화면의 수정버튼 이벤트 > 클릭 시 비밀번호 입력 모달을 띄움
                items.$modiBtnInReadModal.on('click', () => {
                    items.$passwordInputModal.modal('show');
                    // 이거 동작하는지 확인하고, 확인 될때까지 주석 지우지 마
                    console.log("---focus확인")
                    items.$pwForAuthCheck.focus();
                    items.$passwordModalTitle.html('수정하기');
                })

                // 조회화면의 삭제버튼 이벤트 > 클릭 시 비밀번호 입력 모달을 띄움
                items.$deleteBtnInReadModal.on('click', () => {
                    items.$passwordInputModal.modal('show');
                    items.$pwForAuthCheck.focus();
                    items.$passwordModalTitle.html('삭제하기');
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

                        if (items.$passwordModalTitle.html().startsWith('수정')) {
                            makeModifyingAvailable();
                        } else {
                            let check = confirm("정말 삭제하시겠습니까?")
                            if (check) {
                                ajaxService.deleteAjax(API_Server.commonURL + "board/" + staticSelectedBoard, "", success)

                                function success() {
                                    alert("삭제가 완료되었습니다.")
                                    $(".closeModal").click();
                                    movePage(staticCurrPage, staticCurrSearchOption, staticCurrSearchKeyword);
                                }
                            }
                        }
                    }

                    function fail(data) {
                        alert(data.responseJSON.message)
                        items.$pwForAuthCheck.val("").focus();
                    }
                })

                // 게시글 조회창 닫을때
                $(".closeModal").on("click", () => {
                    allFormsReset();
                    movePage(staticCurrPage, staticCurrSearchOption, staticCurrSearchKeyword)
                })

                // (댓글) 최종 수정버튼 클릭시
                $("#replyModiBtn").on('click', () => {
                    let check = confirm("수정하시겠습니까?");
                    if (check) {
                        let replyObj = {
                            'rno': staticSelectedReply,
                            'writer': document.getElementById("readModal-reply-writer").value,
                            'password': document.getElementById("readModal-reply-password").value,
                            'content': document.getElementById("readModal-reply-content").value
                        }
                        ajaxService.putAjax(API_Server.commonURL + "reply", replyObj, success, fail)

                        function success() {
                            alert("댓글 수정이 완료되었습니다.")
                            allFormsReset();
                            read(staticSelectedBoard);
                        }

                        function fail(data) {
                            alert(data.responseJSON.message);
                        }
                    }
                })

                // 글 수정
                items.$finalUpdateBtnInReadModal.on('click', () => {
                    let check = confirm("수정하시겠습니까?");
                    if (check) {
                        let board = modalForm();
                        board.readFormObj.attachedList = finalFileFormData;
                        ajaxService.putAjax(API_Server.commonURL + "board", board.readFormObj, success, fail)

                        function success() {
                            alert("글 수정이 완료되었습니다.")
                            allFormsReset();
                            read(staticSelectedBoard);
                            $uploadDivforModi.html($cloneObjforModi.html());
                        }

                        function fail(data) {
                            alert(data.responseJSON.message);
                        }

                    }
                })


                // 검색
                $("#searchBtn").on("click", () => {
                    let searchForm = document.getElementsByName('searchForm')
                    let category = '';
                    for (let i = 0; i < searchForm.length; i++) {
                        if (searchForm[i].checked == true) {
                            category += searchForm[i].value;
                        }
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
                    for (let i = 0; i < searchForm.length; i++) {
                        if (searchForm[i].checked == true) {
                            searchForm[i].checked = false;
                        }
                    }
                    movePage(1);
                })

                // 댓글 등록 버튼 이벤트
                $("#replyRegiBtn").on("click", () => {

                    let board = modalForm();
                    ajaxService.postAjax(API_Server.commonURL + "reply", board.replyFormObj, success, fail)

                    function success(data) {
                        console.log(data)
                        alert("댓글 등록이 완료되었습니다.")
                        allFormsReset()
                        read(staticSelectedBoard);
                    }

                    function fail(data) {
                        alert(data.responseJSON.message)
                    }
                })

                $(".pwModalClose").on('click', (e) => {
                    e.preventDefault()
                    items.$passwordInputModal.modal('hide');
                })


                // 첨부파일 감지하여 썸네일 생성
                $("input[name='uploadFile']").on('change', (e) => {
                    let formData = new FormData();
                    let $inputFile = $(e.target);
                    let files = $inputFile[0].files;
                    for(let i=0;i<files.length;i++) {
                        // 기존이랑 같은파일 첨부하면 에러띄우기(==========추가할것)
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
                             // let $uploadDiv = $(".uploadDiv");
                             // let $cloneObj =  $uploadDiv.clone();
                            let attachListBox = $inputFile.parent().siblings().find('ul');

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
                                    attachListBox.append('<li id="'+(file.uuid+file.fileName)+'"><img src='+API_Server.commonURL+'/display?fileName='+fileName+
                                        ' style="display: block">'+file.fileName+'<img src="/resources/assets/xicon2.png" style="cursor: pointer" onclick="deleteFileTag('+target+');">'+'</li>');
                                } else {
                                    attachment.image = 0;
                                    attachListBox.append('<li id="'+(file.uuid+file.fileName)+'"><img src="/resources/assets/fileicon.png" style="display: block; width: 100px; height: 100px;">'+
                                        file.fileName+'<img src="/resources/assets/xicon2.png" style="cursor: pointer" onclick="deleteFileTag('+target+');">'+'</li>')
                                }
                                finalFileFormData.push(attachment);
                            })
                            // 업로드 div 초기화 > 이거하면 추가첨부가 안됨. 왜안되는지 알아보고 수정하자.
                            // $uploadDiv.html($cloneObj.html());
                        }
                    })
                })
            }) // end of onready
   </script>
</body>
