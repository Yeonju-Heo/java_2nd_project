package com.br31.dao;

import java.util.*;

import com.br31.vo.VocVO;

public class VocDAO extends DBConn {
	
	//삭제 파일 선택
	public String getVsfile(String vid) {
		String vsfile = null;
		String sql = " SELECT VSFILE FROM BR31_VOC WHERE VID = ?";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, vid);
			rs = pstmt.executeQuery();
			if(rs.next()) vsfile = rs.getString(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vsfile;
	}
	
	//선택된 문의수
	public int execTotalCount(String qtype, String ctype, String status){
		int count = 0;
		String str = "";
		
		if(qtype == null && ctype == null) {
			qtype = "상담유형";
			ctype = "내용유형";
		}
		
		if(!qtype.equals("상담유형") && !ctype.equals("내용유형")) {
			str = " AND QTYPE = '" + qtype + "' AND CTYPE = '" + ctype + "'";
		} else if (qtype.equals("상담유형") && !ctype.equals("내용유형")) {
			str = " AND CTYPE = '" + ctype + "'";
		} else if (!qtype.equals("상담유형") && ctype.equals("내용유형")) {
			str = " AND QTYPE = '" + qtype + "'";
		} 
		
		String sql = " SELECT COUNT(*) "
				+ " FROM (SELECT RNO, VID, QTYPE, CTYPE, TITLE, VDATE, STATUS "
				+ " FROM (SELECT ROWNUM RNO, VID, QTYPE, CTYPE, TITLE, TO_CHAR(VDATE, 'YYYY-MM-DD') VDATE, STATUS "
				+ " FROM (SELECT VID, QTYPE, CTYPE, TITLE, CONTENT, VDATE, STATUS FROM BR31_VOC " 
				+ " WHERE STATUS = '" + status + "'" + str + " ORDER BY VDATE DESC))) ";
		
		getStatement();
		
		try {
			rs = stmt.executeQuery(sql);
			if(rs.next()) count = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	public int execTotalCount(String qtype, String ctype, String status, String keyword){
		int count = 0;
		String wqtype = "";
		String wctype = "";
		String wkeyword = "";
		
		if(qtype==null) qtype = "상담유형";
		if(ctype==null) ctype = "내용유형";

		if(!qtype.equals("상담유형")) wqtype = " AND QTYPE = '" + qtype + "' ";
		if(!ctype.equals("내용유형")) wctype = " AND CTYPE = '" + ctype + "' ";
		if(keyword!=null) wkeyword = " AND TITLE LIKE '%" + keyword + "%' ";

		String sql = " SELECT COUNT(*) "
				+ " FROM (SELECT RNO, VID, QTYPE, CTYPE, TITLE, VDATE, STATUS "
				+ " FROM (SELECT ROWNUM RNO, VID, QTYPE, CTYPE, TITLE, TO_CHAR(VDATE, 'YYYY-MM-DD') VDATE, STATUS "
				+ " FROM (SELECT VID, QTYPE, CTYPE, TITLE, CONTENT, VDATE, STATUS FROM BR31_VOC " 
				+ " WHERE STATUS = '" + status + "'" + wqtype + wctype + wkeyword +" ORDER BY VDATE DESC))) ";
		
		getStatement();
		
		try {
			rs = stmt.executeQuery(sql);
			if(rs.next()) count = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	//전체 문의 수
	public int execTotalCount(String id){
		int count = 0;
		String sql = " SELECT COUNT(*) FROM BR31_VOC WHERE ID = ?";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) count = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	//관리자 ---> 문의 답변 삭제
	public boolean getDeleteAnswerResult(String vid) {
		boolean result = false;
		
		String sql = " UPDATE BR31_VOC SET ANSWER = NULL, STATUS = 'NO' WHERE VID = ? ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, vid);
		
			int value = pstmt.executeUpdate();
			if(value != 0) result = true;
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return result;
	}
	
	//관리자 ---> admin_voc_write : 문의 답변 작성
	public boolean getInsertResult(String vid, String answer) {
		boolean result = false;
		
		String sql = " UPDATE BR31_VOC SET ANSWER = ?, STATUS = 'YES' WHERE VID = ? ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, answer);
			pstmt.setString(2, vid);
		
			int value = pstmt.executeUpdate();
			if(value != 0) result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return result;
	}
	
	//고객 ---> voc_content : 문의 삭제
	public boolean getDeleteResult(String vid) {
		boolean result = false;
		
		String sql = " DELETE FROM BR31_VOC WHERE VID = ? ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, vid);
			int value = pstmt.executeUpdate();
			
			if(value != 0) result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return result; 
	}
	
	
	
	//고객 ---> voc_update : 새로운 파일 선택
	public boolean getUpdateResult(VocVO vo) {
		boolean result = false;
		
		String sql = " UPDATE BR31_VOC SET QTYPE = ?, CTYPE = ?, TITLE = ?, CONTENT = ?, VFILE = ?, VSFILE = ?, NAME = ?, EMAIL = ?, HP = ? "
					+ "WHERE VID = ? ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, vo.getQtype());
			pstmt.setString(2, vo.getCtype());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getVfile());
			pstmt.setString(6, vo.getVsfile());
			pstmt.setString(7, vo.getName());
			pstmt.setString(8, vo.getEmail());
			pstmt.setString(9, vo.getHp());
			pstmt.setString(10, vo.getVid());
			
			int value = pstmt.executeUpdate();
			if(value != 0) result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(vo.getVid());
		close();
		return result;
	}
	
	
	//고객 ---> voc_update : 기존 파일 유지
	public boolean getUpdateResultNoFile(VocVO vo) {
		boolean result = false;
		
		String sql = " UPDATE BR31_VOC SET QTYPE = ?, CTYPE = ?, TITLE = ?, CONTENT = ?, NAME = ?, EMAIL = ?, HP = ? WHERE VID = ? ";
		getPreparedStatement(sql);

		try {
			pstmt.setString(1, vo.getQtype());
			pstmt.setString(2, vo.getCtype());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getName());
			pstmt.setString(6, vo.getEmail());
			pstmt.setString(7, vo.getHp());
			pstmt.setString(8, vo.getVid());
			
			int value = pstmt.executeUpdate();
			if(value != 0) result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		close();
		return result;
	}
	
	//고객 ---> voc_content
	public VocVO getContent(String vid) {
		VocVO vo = new VocVO();
		
		String sql = " SELECT VID, QTYPE, CTYPE, TITLE, CONTENT, VFILE, VSFILE, NAME, HP, EMAIL, TO_CHAR(VDATE, 'YYYY-MM-DD'), ANSWER, ID "
					+ " FROM BR31_VOC WHERE VID = ? "; 
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, vid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setVid(rs.getString(1));
				vo.setQtype(rs.getString(2));
				vo.setCtype(rs.getString(3));
				vo.setTitle(rs.getString(4));
				vo.setContent(rs.getString(5));
				vo.setVfile(rs.getString(6));
				vo.setVsfile(rs.getString(7));
				vo.setName(rs.getString(8));
				vo.setHp(rs.getString(9));
				vo.setEmail(rs.getString(10));
				vo.setVdate(rs.getString(11));
				vo.setAnswer(rs.getString(12));
				vo.setId(rs.getString(13));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	//고객 ---> voc_list : 페이지 ***************
	public ArrayList<VocVO> getList(String id, int start, int end) {
		ArrayList<VocVO> list = new ArrayList<VocVO>();
		
		String sql = " SELECT RNO, VID, QTYPE, CTYPE, TITLE, VDATE, STATUS "
				+ " FROM (SELECT ROWNUM RNO, VID, QTYPE, CTYPE, TITLE, TO_CHAR(VDATE, 'YYYY-MM-DD') VDATE, STATUS "
				+ " FROM (SELECT VID, QTYPE, CTYPE, TITLE, CONTENT, VDATE, STATUS FROM BR31_VOC WHERE ID = ? ORDER BY VDATE)) "
				+ " WHERE RNO BETWEEN ? AND ? ORDER BY RNO DESC";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, id);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);		
			/* pstmt.setString(3, id); */ //파라미터로 고객 아이디 받아올 것. 
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				VocVO vo = new VocVO();
				
				vo.setRno(rs.getInt(1));
				vo.setVid(rs.getString(2));
				vo.setQtype(rs.getString(3));
				vo.setCtype(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setVdate(rs.getString(6));
				vo.setStatus(rs.getString(7));
				
				list.add(vo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		close();
		return list;
	}
	
	//고객 voc_list : 로그인한 고객만 리스트 확인 가능  ------------------------------------->>>> 삭제 예정
	public ArrayList<VocVO> getList() {
		ArrayList<VocVO> list = new ArrayList<VocVO>();
		
		String sql = " SELECT ROWNUM RNO, VID, QTYPE, CTYPE, TITLE, TO_CHAR(VDATE, 'YYYY-MM-DD'), STATUS "
				+ " FROM (SELECT VID, QTYPE, CTYPE, TITLE, CONTENT, VDATE, STATUS FROM BR31_VOC ORDER BY VDATE DESC) ";
			/*	+ " WHERE ID = ? "; */
		getPreparedStatement(sql);
		
		try {
			/* pstmt.setString(1, id); */ //파라미터로 고객 아이디 받아올 것. 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				VocVO vo = new VocVO();
				
				vo.setRno(rs.getInt(1));
				vo.setVid(rs.getString(2));
				vo.setQtype(rs.getString(3));
				vo.setCtype(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setVdate(rs.getString(6));
				vo.setStatus(rs.getString(7));
				
				list.add(vo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return list;
	}
	
	
	public ArrayList<VocVO> getList(String qtype, String ctype, int start, int end, String status, String keyword) {
		ArrayList<VocVO> list = new ArrayList<VocVO>();
		String wqtype = "";
		String wctype = "";
		String wkeyword = "";
		
		if(qtype==null) qtype = "상담유형";
		if(ctype==null) ctype = "내용유형";

		if(!qtype.equals("상담유형")) wqtype = " AND QTYPE = '" + qtype + "' ";
		if(!ctype.equals("내용유형")) wctype = " AND CTYPE = '" + ctype + "' ";
		if(keyword!=null) wkeyword = " AND TITLE LIKE '%" + keyword + "%' ";

		String sql = " SELECT RNO, VID, QTYPE, CTYPE, TITLE, VDATE, STATUS "
				+ " FROM (SELECT ROWNUM RNO, VID, QTYPE, CTYPE, TITLE, TO_CHAR(VDATE, 'YYYY-MM-DD') VDATE, STATUS "
				+ " FROM (SELECT VID, QTYPE, CTYPE, TITLE, CONTENT, VDATE, STATUS FROM BR31_VOC " 
				+ " WHERE STATUS = '" + status + "'" + wqtype + wctype + wkeyword +" ORDER BY VDATE)) "
				+ " WHERE RNO BETWEEN " + end + " AND " + start + " ORDER BY RNO DESC ";

		getStatement();
		
		try {

			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				VocVO vo = new VocVO();
				
				vo.setRno(rs.getInt(1));
				vo.setVid(rs.getString(2));
				vo.setQtype(rs.getString(3));
				vo.setCtype(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setVdate(rs.getString(6));
				vo.setStatus(rs.getString(7));
				
				list.add(vo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		close();
		return list;
	}

// 관리자 ---> 선택한 유형에 따라 가져오기 getList ajax용 **********************
// 관리자 ---> 선택한 유형에 따라 가져오기 getList ajax용 **********************
// 관리자 ---> 선택한 유형에 따라 가져오기 getList ajax용 **********************
	public ArrayList<VocVO> getList(String qtype, String ctype, int start, int end, String status) {
		ArrayList<VocVO> list = new ArrayList<VocVO>();
		String str = "";
		
		if(!qtype.equals("상담유형") && !ctype.equals("내용유형")) {
			str = " AND QTYPE = '" + qtype + "' AND CTYPE = '" + ctype + "'";
		} else if (qtype.equals("상담유형") && !ctype.equals("내용유형")) {
			str = " AND CTYPE = '" + ctype + "'";
		} else if (!qtype.equals("상담유형") && ctype.equals("내용유형")) {
			str = " AND QTYPE = '" + qtype + "'";
		} 
		
		String sql = " SELECT RNO, VID, QTYPE, CTYPE, TITLE, VDATE, STATUS "
				+ " FROM (SELECT ROWNUM RNO, VID, QTYPE, CTYPE, TITLE, TO_CHAR(VDATE, 'YYYY-MM-DD') VDATE, STATUS "
				+ " FROM (SELECT VID, QTYPE, CTYPE, TITLE, CONTENT, VDATE, STATUS FROM BR31_VOC " 
				+ " WHERE STATUS = '" + status + "'" + str + " ORDER BY VDATE DESC)) "
				+ " WHERE RNO BETWEEN " + start + " AND " + end;
		
		System.out.println(sql);  //sql 확인용 ******************
		
		getStatement();
		
		try {
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				VocVO vo = new VocVO();
				
				vo.setRno(rs.getInt(1));
				vo.setVid(rs.getString(2));
				vo.setQtype(rs.getString(3));
				vo.setCtype(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setVdate(rs.getString(6));
				vo.setStatus(rs.getString(7));
				
				list.add(vo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return list;
	}
	
	
	//고객 ---> voc_write : 문의 작성
	public boolean getInsertResult(VocVO vo) {
		boolean result = false;
		
		String sql = " INSERT INTO BR31_VOC VALUES('v_'||SEQU_BR31_VOC.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, NULL, 'NO', ?) ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, vo.getQtype());
			pstmt.setString(2, vo.getCtype());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getVfile());
			pstmt.setString(6, vo.getVsfile());
			pstmt.setString(7, vo.getName());
			pstmt.setString(8, vo.getHp());
			pstmt.setString(9, vo.getEmail());
			pstmt.setString(10, vo.getId());
		
			int value = pstmt.executeUpdate();
			if(value != 0) result = true;
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return result;
	}
	
}




/*
String sql = " SELECT RNO, VID, QTYPE, CTYPE, TITLE, VDATE, STATUS "
		+ " FROM (SELECT ROWNUM RNO, VID, QTYPE, CTYPE, TITLE, TO_CHAR(VDATE, 'YYYY-MM-DD') VDATE, STATUS "
		+ " FROM (SELECT VID, QTYPE, CTYPE, TITLE, CONTENT, VDATE, STATUS FROM BR31_VOC ORDER BY VDATE DESC)) "
		+ " WHERE RNO BETWEEN " + start + " AND " + end";

if(!qtype.equals("상담유형") && !ctype.equals("내용유형")) {
	sql += " AND QTYPE = '" + qtype + "' AND CTYPE = '" + ctype + "'";
} else if (qtype.equals("상담유형") && !ctype.equals("내용유형")) {
	sql += " AND CTYPE = '" + ctype + "'";
} else if (!qtype.equals("상담유형") && ctype.equals("내용유형")) {
	sql += " AND QTYPE = '" + qtype + "'";
}
*/