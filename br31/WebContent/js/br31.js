

// 이벤트 - 글쓰기 폼체크
function eventFormCheck() {
	var title = document.getElementById("title");

	if (title.value == "") {
		alert("제목을 입력해주세요");
		title.focus();
		return false;
	} else {
		event_write.submit();
	}

}

// 공지사항 - 글쓰기 폼체크
function noticeFormCheck() {
	var title = document.getElementById("title");

	if (title.value == "") {
		alert("제목을 입력해주세요");
		title.focus();
		return false;
	} else {
		notice_write.submit();
	}
}


