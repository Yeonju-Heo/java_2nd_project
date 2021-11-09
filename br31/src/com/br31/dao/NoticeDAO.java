package com.br31.dao;

import java.util.ArrayList;

import com.br31.vo.NoticeVO;

public class NoticeDAO extends DBConn {

	// ?Ç≠?†ú?ï† Í≤åÏãúÍ∏??ùò ?åå?ùºÎ™? Í∞??†∏?ò§Í∏?
	// execTotalCount()
	public int execTotalCount() {
		int count = 0;
		String sql = " select count(*) from br31_notice";
		getPreparedStatement(sql);

		try {
			rs = pstmt.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	public String getNsfile(int articleno) {
		String result = "";
		try {
			String sql = "SELECT NSFILE FROM BR31_NOTICE WHERE ARTICLENO = ?";
			getPreparedStatement(sql);

			pstmt.setInt(1, articleno);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// ?åå?ùº?ù¥ Î≥?Í≤ΩÎêòÏß? ?ïä?äî Í≤ΩÏö∞
	public boolean getUpdateResultNofile(NoticeVO vo) {
		boolean result = false;
		try {
			String sql = "UPDATE BR31_NOTICE SET TITLE = ?, NCONTENT = ? WHERE ARTICLENO = ?";
			getPreparedStatement(sql);

			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getNcontent());
			pstmt.setInt(3, vo.getArticleno());

			int val = pstmt.executeUpdate();
			if (val == 1) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// ?ÉàÎ°úÏö¥ ?åå?ùº?ùÑ ?Ñ†?Éù?ïú Í≤ΩÏö∞
	public boolean getUpdateResult(NoticeVO vo) {
		boolean result = false;
		try {
			String sql = "UPDATE BR31_NOTICE SET TITLE = ?, NCONTENT = ?, NFILE = ?, NSFILE = ? WHERE ARTICLENO = ?";
			getPreparedStatement(sql);

			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getNcontent());
			pstmt.setString(3, vo.getNfile());
			pstmt.setString(4, vo.getNsfile());
			pstmt.setInt(5, vo.getArticleno());

			int val = pstmt.executeUpdate();
			if (val == 1) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean getDeleteResult(int articleno) {
		boolean result = false;
		try {
			String sql = "DELETE FROM BR31_NOTICE WHERE ARTICLENO = ?";
			getPreparedStatement(sql);

			pstmt.setInt(1, articleno);

			int val = pstmt.executeUpdate();
			if (val == 1) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public NoticeVO getContent(int articleno) {
		NoticeVO vo = null;
		try {
			String sql = "SELECT ARTICLENO, TITLE, NCONTENT, NFILE, NSFILE, TO_CHAR(MDATE, 'YYYY-MM-DD') MDATE FROM BR31_NOTICE WHERE articleno = ?";
			getPreparedStatement(sql);

			pstmt.setInt(1, articleno);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new NoticeVO();
				vo.setArticleno(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setNcontent(rs.getString(3));
				vo.setNfile(rs.getString(4));
				vo.setNsfile(rs.getString(5));
				vo.setMdate(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

	public ArrayList<NoticeVO> getList() {
		ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();
		try {
			String sql = "SELECT ROWNUM AS RNO, ARTICLENO, TITLE, TO_CHAR(MDATE, 'YYYY-MM-DD') AS MDATE ";
			sql += "	  FROM (SELECT ARTICLENO, TITLE, MDATE FROM BR31_NOTICE ORDER BY MDATE DESC)";
			getPreparedStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				NoticeVO vo = new NoticeVO();
				vo.setRno(rs.getInt(1));
				vo.setArticleno(rs.getInt(2));
				vo.setTitle(rs.getString(3));
				vo.setMdate(rs.getString(4));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		close();
		return list;
	}
	public ArrayList<NoticeVO> getList(int start, int end) {
		ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();
		String sql = "select rno, articleno, title, mdate ";
		sql += "from (select rownum rno, articleno, title, to_char(mdate, 'yyyy-mm-dd') mdate ";
		sql += "        from (select articleno, title, mdate ";
		sql += "                from br31_notice ";
		sql += "                order by mdate desc)) ";
		sql += "where rno between ? and ?";

		getPreparedStatement(sql);

		try {
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				NoticeVO vo = new NoticeVO();
				vo.setRno(rs.getInt(1));
				vo.setArticleno(rs.getInt(2));
				vo.setTitle(rs.getString(3));
				vo.setMdate(rs.getString(4));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean getInsertResult(NoticeVO vo) {
		boolean result = false;
		try {
			String sql = "INSERT INTO BR31_NOTICE VALUES(SEQ_BR31_NOTICE.NEXTVAL, ?, ?, ?, ?, SYSDATE)";
			getPreparedStatement(sql);

			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getNcontent());
			pstmt.setString(3, vo.getNfile());
			pstmt.setString(4, vo.getNsfile());

			int val = pstmt.executeUpdate();
			if (val == 1) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		close();
		return result;
	}
}
