package com.br31.dao;

import java.util.ArrayList;
import com.br31.vo.FaqVO;

public class FaqDAO extends DBConn {
	
	public boolean ggg(FaqVO vo) {
		boolean result = false;
		
		String sql = "";
		
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return result;
	}
	
	public String getFsfile(String fid) {
		String fsfile = null;
		
		String sql = " SELECT FSFILE FROM BR31_FAQ WHERE FID = ?";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, fid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) fsfile = rs.getString(1);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return fsfile;
	}
	
	public boolean getDeleteResult(String fid) {
		boolean result = false;
		
		String sql = " DELETE FROM BR31_FAQ WHERE FID = ? ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, fid);
			
			int value = pstmt.executeUpdate();
			if(value != 0) result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return result;
	}

	public boolean getUpdateResultNoFile(FaqVO vo) {
		boolean result = false;
		
		String sql = " UPDATE BR31_FAQ SET TITLE = ?, CONTENT = ?, FTYPE = ? WHERE FID = ? ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getFtype());
			pstmt.setString(4, vo.getFid());
			
			int value = pstmt.executeUpdate();
			if(value != 0) result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return result;
	}
	
	public boolean getUpdateResult(FaqVO vo) {
		boolean result = false;
		
		String sql = " UPDATE BR31_FAQ SET TITLE = ?, CONTENT = ?, FFILE = ?, FSFILE = ?, FTYPE = ? WHERE FID = ? ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getFfile());
			pstmt.setString(4, vo.getFsfile());
			pstmt.setString(5, vo.getFtype());
			pstmt.setString(6, vo.getFid());
			
			int value = pstmt.executeUpdate();
			if(value != 0) result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return result;
	}
	
	//콘텐츠 가져오기
	public FaqVO getContent(String fid) {
		FaqVO vo = new FaqVO();
		
		String sql = " SELECT FID, TITLE, CONTENT, FFILE, FSFILE, FTYPE FROM BR31_FAQ WHERE FID = ? ";
		getPreparedStatement(sql);
     
		try {
			pstmt.setString(1, fid);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo.setFid(rs.getString(1));
				vo.setTitle(rs.getString(2));
				vo.setContent(rs.getString(3));
				vo.setFfile(rs.getString(4));
				vo.setFsfile(rs.getString(5));
				vo.setFtype(rs.getString(6));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	
	//페이징 카운트
	public int execTotalCount(String ftype) {
		int count = 0;
		
		String str = "";
		if(!ftype.equals("all")) str = " WHERE FTYPE = '" + ftype + "' ";
		
		String sql = " SELECT COUNT(*) FROM (SELECT FID, TITLE, CONTENT, FSFILE FROM BR31_FAQ " + str + " ORDER BY FDATE DESC) ";
		
		getPreparedStatement(sql);
		getStatement();
		
		try {
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}
	

	//리스트
	public ArrayList<FaqVO> getList(String ftype, int start, int end) {
		ArrayList<FaqVO> list = new ArrayList<FaqVO>();
		
		String str = "";
		if(!ftype.equals("all")) str = " WHERE FTYPE = '" + ftype + "' ";
		
		String sql = " SELECT RNO, FID, TITLE, CONTENT, FSFILE "
		+	" FROM (SELECT ROWNUM RNO, FID, TITLE, CONTENT, FSFILE " 
		+	" FROM (SELECT FID, TITLE, CONTENT, FSFILE FROM BR31_FAQ " + str + " ORDER BY FDATE DESC)) "
		+	" WHERE RNO BETWEEN " + start + " AND " + end;
		
		getStatement();
		
		try {
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				FaqVO vo = new FaqVO();
				
				vo.setFid(rs.getString(2));
				vo.setTitle(rs.getString(3));
				vo.setContent(rs.getString(4));
				vo.setFsfile(rs.getString(5));
				
				list.add(vo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return list;
	}

	
	//admin_faq_write
	public boolean getInsertResult(FaqVO vo) {
		boolean result = false;
		
		String sql = " INSERT INTO BR31_FAQ VALUES('f_'||SEQU_BR31_FAQ.NEXTVAL, ?, ?, ?, ?, ?, SYSDATE) ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getFfile());
			pstmt.setString(4, vo.getFsfile());
			pstmt.setString(5, vo.getFtype());
			
			int value = pstmt.executeUpdate();
			if(value != 0) result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		close();
		return result;
	}
	
	
}
