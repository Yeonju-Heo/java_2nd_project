<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.br31.vo.EventVO"%>
<%@page import="com.br31.dao.EventDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//
//파일이 저장될 서버의 경로. 되도록이면 getRealPath를 이용하자.
String savePath = request.getServletContext().getRealPath("/upload");
// System.out.println(savePath);

//파일 크기 15MB로 제한
int sizeLimit = 1024 * 1024 * 15;

//↓ request 객체,               ↓ 저장될 서버 경로,       ↓ 파일 최대 크기,    ↓ 인코딩 방식,       ↓ 같은 이름의 파일명 방지 처리
//(HttpServletRequest request, String saveDirectory, int maxPostSize, String encoding, FileRenamePolicy policy)
//아래와 같이 MultipartRequest를 생성만 해주면 파일이 업로드 된다.(파일 자체의 업로드 완료)
MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());

//파일명 확인
System.out.println("화면UI이름=" + multi.getOriginalFileName("nfile"));
System.out.println("폴더저장이름=" + multi.getFilesystemName("nfile"));

//기존 파일 그대로 유지 ---> nfile: null
//새로운 파일 선택 & 파일 수정 ---> nfile: 선택된 파일 명

EventVO vo = new EventVO();
EventDAO dao = new EventDAO();
String articleno = multi.getParameter("articleno");
System.out.println(articleno);
boolean result = false;

if (multi.getOriginalFileName("nfile") != null) {
	vo.setArticleno(Integer.parseInt(articleno));
	vo.setTitle(multi.getParameter("title"));
	vo.setNcontent(multi.getParameter("ncontent"));
	vo.setNfile(multi.getOriginalFileName("nfile"));
	vo.setNsfile(multi.getFilesystemName("nfile"));
	vo.setNfile2(multi.getOriginalFileName("nfile2"));
	vo.setNsfile2(multi.getFilesystemName("nfile2"));
	result = dao.getUpdateResult(vo);
} else {
	vo.setArticleno(Integer.parseInt(articleno));
	vo.setTitle(multi.getParameter("title"));
	vo.setNcontent(multi.getParameter("ncontent"));
	
	result = dao.getUpdateResultNofile(vo);
}


if (result) {
	response.sendRedirect("event_list.jsp");
}
%>