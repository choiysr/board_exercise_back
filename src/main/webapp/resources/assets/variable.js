var item = function () {
    let $tbody = $('#boardListBody');
    let $pageUl = $('.pagination');
    let $prevBtn = $("#zero_config_previous");
    let $nextBtn = $("#zero_config_next");
    let $pageNumbers = $(".each-number");
    let $registerBoardBtn = $("#regiModal-registerBtn");
    let $regiTitle = $("#regiModal-title");
    let $regiWriter = $("#regiModal-writer");
    let $regiPassword = $("#regiModal-password");
    let $regiContent = $("#regiModal-content")
    let $readTitle = $("#readModal-title");
    let $readContent = $("#readModal-content");
    let $readWriter = $("#readModal-writer");
    let $readPassword = $("#passwordArea");
    let $readPasswordInput = $("#readModal-password");
    let $selectedAmount = $("#selectedAmount");

    let $eachBoard = $(".eachBoard");

    let $readBoardModal = $("#ReadBoardModal");
    let $modiBtnInReadModal = $("#readModal-modiBtn");
    let $deleteBtnInReadModal = $("#readModal-deleteBtn");
    let $finalUpdateBtnInReadModal = $("#readModal-updateBtn");
    let $passwordInputModal = $("#passwordInputModal");
    let $passwordModalTitle = $("#password-modal-title");
    let $pwForAuthCheck = $("#pwForAuthCheck");

    let $replyTable = $("#replyTable");
    let $replyPasswordInputModal = $("#passwordInputModal-reply");
    let $replyRegiBtn = $("#replyRegiBtn")
    let $replyModiBtn = $("#replyModiBtn")
    let $replyWriter = $("#readModal-reply-writer");
    let $replyPassword = $("#readModal-reply-password");
    let $replyContent = $("#readModal-reply-content");
    let $fileListBoxInReadModal = $("#readModal-attachedFileListUl");
    let $fileListBoxInRegiModal = $("#regiModal-attachedFileListUl");

    return {
        $tbody,
        $pageUl,
        $pageNumbers,
        $prevBtn,
        $nextBtn,
        $registerBoardBtn,
        $regiTitle,
        $regiWriter,
        $regiPassword,
        $regiContent,
        $readTitle,
        $readContent,
        $readWriter,
        $readPassword,
        $readPasswordInput,
        $selectedAmount,
        $eachBoard,
        $readBoardModal,
        $modiBtnInReadModal,
        $deleteBtnInReadModal,
        $finalUpdateBtnInReadModal,
        $passwordInputModal,
        $passwordModalTitle,
        $pwForAuthCheck,
        $replyTable,
        $replyPasswordInputModal,
        $replyRegiBtn,
        $replyModiBtn,
        $replyWriter,
        $replyPassword,
        $replyContent,
        $fileListBoxInReadModal,
        $fileListBoxInRegiModal
    }
};

var modalForm = function () {
    let regiFormObj = {
        'title' : document.getElementById("regiModal-title").value,
        'writer' : document.getElementById("regiModal-writer").value,
        'password' : document.getElementById("regiModal-password").value,
        'content' : document.getElementById("regiModal-content").value,
        'attachedList' : ''
    }

    let readFormObj = {
        'bno': staticSelectedBoard,
        'title': document.getElementById("readModal-title").value,
        'writer': document.getElementById("readModal-writer").value,
        'password': document.getElementById("readModal-password").value,
        'content': document.getElementById("readModal-content").value,
        'attachedList' : ''
    }
    let replyFormObj = {
        'boardno' : staticSelectedBoard,
        'writer' : document.getElementById("readModal-reply-writer").value,
        'password' : document.getElementById("readModal-reply-password").value,
        'content' : document.getElementById("readModal-reply-content").value,
    }

    return {
        'regiFormObj' : regiFormObj,
        'readFormObj' : readFormObj,
        'replyFormObj' : replyFormObj
    }
};