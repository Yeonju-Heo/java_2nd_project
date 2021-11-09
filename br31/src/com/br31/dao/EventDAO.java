package com.br31.dao;

import java.util.ArrayList;

import com.br31.vo.EventVO;

public class EventDAO extends DBConn {

	// ?Ç≠?†ú?ï† Í≤åÏãúÍ∏??ùò ?åå?ùºÎ™? Í∞??†∏?ò§Í∏?
	// execTotalCount()
	public int execTotalCount() {
		int count = 0;
		String sql = " select count(*) from br31_event";
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
			String sql = "SELECT NSFILE FROM BR31_event WHERE ARTICLENO = ?";
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

	public String getNsfile2(int articleno) {
		String result = "";
		try {
			String sql = "SELECT NSFILE2 FROM BR31_event WHERE ARTICLENO = ?";
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
	public boolean getUpdateResultNofile(EventVO vo) {
		boolean result = false;
		try {
			String sql = "UPDATE BR31_event SET TITLE = ?, NCONTENT = ? WHERE ARTICLENO = ?";
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
	public boolean getUpdateResult(EventVO vo) {
		boolean result = false;
		try {
			String sql = "UPDATE BR31_event SET TITLE = ?, NCONTENT = ?, NFILE = ?, NSFILE = ?, NFILE2 = ?, NSFILE2 = ? WHERE ARTICLENO = ?";
			getPreparedStatement(sql);

			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getNcontent());
			pstmt.setString(3, vo.getNfile());
			pstmt.setString(4, vo.getNsfile());
			pstmt.setString(5, vo.getNfile2());
			pstmt.setString(6, vo.getNsfile2());
			pstmt.setInt(7, vo.getArticleno());

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
			String sql = "DELETE FROM BR31_event WHERE ARTICLENO = ?";
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

	public EventVO getContent(int articleno) {
		EventVO vo = null;
		try {
			String sql = "SELECT ARTICLENO, TITLE, NCONTENT, nfile, nsfile, NFILE2, NSFILE2, TO_CHAR(MDATE, 'YYYY-MM-DD') MDATE FROM BR31_event WHERE articleno = ?";
			getPreparedStatement(sql);

			pstmt.setInt(1, articleno);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new EventVO();
				vo.setArticleno(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setNcontent(rs.getString(3));
				vo.setNfile(rs.getString(4));
				vo.setNsfile(rs.getString(5));
				vo.setNfile2(rs.getString(6));
				vo.setNsfile2(rs.getString(7));
				vo.setMdate(rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

	public ArrayList<EventVO> getList() {
		ArrayList<EventVO> list = new ArrayList<EventVO>();
		try {
			String sql = "SELECT ROWNUM AS RNO, ARTICLENO, TITLE, TO_CHAR(MDATE, 'YYYY-MM-DD') AS MDATE, nfile ";
			sql += "	  FROM (SELECT ARTICLENO, TITLE, MDATE FROM BR31_event ORDER BY MDATE DESC, nfile)";
			getPreparedStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				EventVO vo = new EventVO();
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
	public ArrayList<EventVO> getList(int start, int end) {
		ArrayList<EventVO> list = new ArrayList<EventVO>();
		String sql = "select rno, articleno, title, mdate, nsfile, nsfile2 ";
		sql += "from (select rownum rno, articleno, title, to_char(mdate, 'yyyy-mm-dd') mdate, nsfile, nsfile2 ";
		sql += "        from (select articleno, title, mdate, nsfile, nsfile2 ";
		sql += "                from br31_event ";
		sql += "                order by mdate desc)) ";
		sql += "where rno between ? and ?";

		getPreparedStatement(sql);

		try {
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				EventVO vo = new EventVO();
				vo.setRno(rs.getInt(1));
				vo.setArticleno(rs.getInt(2));
				vo.setTitle(rs.getString(3));
				vo.setMdate(rs.getString(4));
				vo.setNfile(rs.getString(5));
				vo.setNfile2(rs.getString(6));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		close();

		return list;
	}

	public boolean getInsertResult(EventVO vo) {
		boolean result = false;
		try {
			String sql = "INSERT INTO BR31_event VALUES(SEQ_BR31_event.NEXTVAL, ?, ?, ?, ?, ?, ?, SYSDATE)";
			getPreparedStatement(sql);

			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getNcontent());
			pstmt.setString(3, vo.getNfile());
			pstmt.setString(4, vo.getNsfile());
			pstmt.setString(5, vo.getNfile2());
			pstmt.setString(6, vo.getNsfile2());

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
