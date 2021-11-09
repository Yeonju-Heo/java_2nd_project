package com.br31.dao;

import java.util.ArrayList;

import com.br31.vo.MenuVO;

public class MenuDAO extends DBConn{
	//hashtag, 추천플레이버 등 String을 배열로 합하는 메소드
		public String[] getStringList(String text) {
			if(text.contains(",")) {
				String[] list = text.split(",");
				return list;
			}else {
				String[] list = {text};
				return list;
			}
		}
		
	//배열을 String으로 분리하는 메소드
		public String getString(String[] list) {
			String text = "";
			if(list!=null) {
				for(int i=0;i<list.length;i++) {
					if(i==list.length-1) {
						text += list[i];
					}else {
						text += list[i]+",";
					}
				}
			}
			return text;
		}
		//Select---> 메뉴 default에서 프로모션 메뉴 리스트
		public ArrayList<MenuVO> getMenuPromotionList(String category){
			ArrayList<MenuVO> list = new ArrayList<MenuVO>();
			String sql= " select pname, hashtag, psfile from br31_menu where category=? and order_type='promotion' " + 
					" order by order_num desc ";
			getPreparedStatement(sql);
			
			try {
				pstmt.setString(1, category.toUpperCase());
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MenuVO vo = new MenuVO();
					vo.setPname(rs.getString(1));
					vo.setHashtag(rs.getString(2));
					vo.setPsfile(rs.getString(3));
					list.add(vo);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return list;
		}
		
		//Select --> 전체 페이지 수 구하기
		public int getDbCount(String category) {
			int result=0;
			String sql= "";
			if(category.equals("all")) {
				sql = " select count(*) from br31_menu ";
				getPreparedStatement(sql);
			}else {
				sql = " select count(*) from br31_menu where category = ? ";
				try {
					getPreparedStatement(sql);
					pstmt.setString(1, category.toUpperCase());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			try {
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return result;
		}
		
		//Select --> 아이스크림 메뉴 리스트(페이징 처리)
		public ArrayList<MenuVO> getMenuIcecreamList(String status, int start, int end) {
			ArrayList<MenuVO> list = new ArrayList<MenuVO>();
			String sql = "";
			
			if(status.equals("icecream")) {
				sql = " SELECT PNAME, HASHTAG, PSFILE, SET_CHECK FROM (SELECT ROWNUM RNO, PNAME, HASHTAG, PSFILE, SET_CHECK " + 
						" FROM (SELECT PNAME, HASHTAG, PSFILE, SET_CHECK FROM BR31_MENU WHERE CATEGORY='ICECREAM' " + 
						" ORDER BY ORDER_NUM desc)) WHERE RNO BETWEEN ? AND ? ";
			}else if(status.equals("coffee")){
				sql = " SELECT PNAME, HASHTAG, PSFILE, SET_CHECK FROM (SELECT ROWNUM RNO, PNAME, HASHTAG, PSFILE, SET_CHECK " + 
						" FROM (SELECT PNAME, HASHTAG, PSFILE, SET_CHECK FROM BR31_MENU WHERE CATEGORY='COFFEE' " + 
						" ORDER BY ORDER_NUM desc)) WHERE RNO BETWEEN ? AND ? ";
			}
			
			getPreparedStatement(sql);
			try {
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				rs= pstmt.executeQuery();
				while(rs.next()) {
					MenuVO vo = new MenuVO();
					vo.setPname(rs.getString(1));
					if(rs.getString(2)!=null) {
						if(rs.getString(2).contains(",")) {
							String[] hashlist = rs.getString(2).split(",");
							vo.setHashtag(hashlist);
						}else {
							String[] hashlist = {rs.getString(2)};
							vo.setHashtag(hashlist);
						}
					}
					vo.setPsfile(rs.getString(3));
					vo.setSet_check(rs.getInt(4));
					list.add(vo);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
		}
	//Select --> 아이스크림 메뉴 리스트
		public ArrayList<MenuVO> getMenuIcecreamList(String status) {
			ArrayList<MenuVO> list = new ArrayList<MenuVO>();
			String sql = "";
			
			if(status.equals("icecream")) {
				sql = " SELECT PNAME, HASHTAG, PSFILE FROM BR31_MENU WHERE CATEGORY='ICECREAM' ORDER BY ORDER_NUM desc ";
			}else {
				sql = " SELECT PNAME, HASHTAG, PSFILE FROM BR31_MENU WHERE CATEGORY='COFFEE' ORDER BY ORDER_NUM desc ";
			}
			
			getPreparedStatement(sql);
			try {
				rs= pstmt.executeQuery();
				while(rs.next()) {
					MenuVO vo = new MenuVO();
					vo.setPname(rs.getString(1));
					if(rs.getString(2)!=null) {
						if(rs.getString(2).contains(",")) {
							String[] hashlist = rs.getString(2).split(",");
							vo.setHashtag(hashlist);
						}else {
							String[] hashlist = {rs.getString(2)};
							vo.setHashtag(hashlist);
						}
					}
					vo.setPsfile(rs.getString(3));
					list.add(vo);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			close();
			return list;
	}
		
	//insert --> admin의 데이터 넣기
	public boolean getInsertResult(MenuVO vo) {
		boolean result = false;
		String sql = "";
		try {
			switch(vo.getOrder_type()) {
			case "common":			//시퀀스에 b로 넣는다.
				sql = " insert into br31_menu values(?, ?, 'b'||seq_menu.nextval, ?, ?, "
						+ " ?, ?, null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";
				getPreparedStatement(sql);
				pstmt.setString(1, vo.getCategory().toUpperCase());
				pstmt.setString(2, vo.getOrder_type());
				pstmt.setString(3, vo.getPname());
				pstmt.setString(4, vo.getEng_pname());
				pstmt.setString(5, vo.getIntro());
				if(vo.getRec_flavor()!=null) {
					pstmt.setString(6, getString(vo.getRec_flavor()));
				}else {
					pstmt.setString(6, null);
				}
				if(vo.getHashtag()!=null) {
					pstmt.setString(7, getString(vo.getHashtag()));
				}else {
					pstmt.setString(7, null);
				}
				pstmt.setString(8, vo.getPfile());
				pstmt.setString(9, vo.getPsfile());
				pstmt.setString(10, vo.getOne_amount());
				pstmt.setString(11, vo.getKcal());
				pstmt.setInt(12, vo.getNatrium());
				pstmt.setInt(13, vo.getSugar());
				pstmt.setInt(14, vo.getFat());
				pstmt.setInt(15, vo.getProtein());
				pstmt.setInt(16, vo.getCaffeine());
				if(vo.getAllergy()!=null) {
					pstmt.setString(17, getString(vo.getAllergy()));
				}else {
					pstmt.setString(17, null);
				}
				pstmt.setInt(18, 0);
				
				break;
			case "promotion":			//시퀀스에 c로 넣는다.
				sql = " insert into br31_menu values(?, ?, 'c'||seq_menu.nextval, ?, ?, "
						+ " ?, ?, null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";
				getPreparedStatement(sql);
				pstmt.setString(1, vo.getCategory().toUpperCase());
				pstmt.setString(2, vo.getOrder_type());
				pstmt.setString(3, vo.getPname());
				pstmt.setString(4, vo.getEng_pname());
				pstmt.setString(5, vo.getIntro());
				if(vo.getRec_flavor()!=null) {
					pstmt.setString(6, getString(vo.getRec_flavor()));
				}else {
					pstmt.setString(6, null);
				}
				if(vo.getHashtag()!=null) {
					pstmt.setString(7, getString(vo.getHashtag()));
				}else {
					pstmt.setString(7, null);
				}
				pstmt.setString(8, vo.getPfile());
				pstmt.setString(9, vo.getPsfile());
				pstmt.setString(10, vo.getOne_amount());
				pstmt.setString(11, vo.getKcal());
				pstmt.setInt(12, vo.getNatrium());
				pstmt.setInt(13, vo.getSugar());
				pstmt.setInt(14, vo.getFat());
				pstmt.setInt(15, vo.getProtein());
				pstmt.setInt(16, vo.getCaffeine());
				if(vo.getAllergy()!=null) {
					pstmt.setString(17, getString(vo.getAllergy()));
				}else {
					pstmt.setString(17, null);
				}
				pstmt.setInt(18, 0);
				break;
			case "pack":				//시퀀스에 a로 넣는다.
				sql = " insert into br31_menu values(?, ?, 'a'||seq_menu.nextval, ?, ?, "
						+ " ?, ?, null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";
				getPreparedStatement(sql);
				pstmt.setString(1, vo.getCategory().toUpperCase());
				pstmt.setString(2, vo.getOrder_type());
				pstmt.setString(3, vo.getPname());
				pstmt.setString(4, vo.getEng_pname());
				pstmt.setString(5, vo.getIntro());
				if(vo.getRec_flavor()!=null) {
					pstmt.setString(6, getString(vo.getRec_flavor()));
				}else {
					pstmt.setString(6, null);
				}
				if(vo.getHashtag()!=null) {
					pstmt.setString(7, getString(vo.getHashtag()));
				}else {
					pstmt.setString(7, null);
				}
				pstmt.setString(8, vo.getPfile());
				pstmt.setString(9, vo.getPsfile());
				pstmt.setString(10, vo.getOne_amount());
				pstmt.setString(11, vo.getKcal());
				pstmt.setInt(12, vo.getNatrium());
				pstmt.setInt(13, vo.getSugar());
				pstmt.setInt(14, vo.getFat());
				pstmt.setInt(15, vo.getProtein());
				pstmt.setInt(16, vo.getCaffeine());
				if(vo.getAllergy()!=null) {
					pstmt.setString(17, getString(vo.getAllergy()));
				}else {
					pstmt.setString(17, null);
				}
				pstmt.setInt(18, 1);
				break;
			}
			
			int r=pstmt.executeUpdate();
			if(r!=0) {
				result=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	//select --> admin의 pname 중복체크
	public boolean getPnameCheck(String pname) {
		boolean result = false;
		String sql = " select count(*) from br31_menu where pname=? ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, pname);
			rs = pstmt.executeQuery();
			int rownum = 0;
			while(rs.next()) {
				rownum = rs.getInt(1);
			}
			if(rownum<1) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	//Select --> admin의 아이스크림 메뉴 리스트
	
	public ArrayList<MenuVO> getAdminList(String category){
		ArrayList<MenuVO> list = new ArrayList<MenuVO>();
		String sql = " SELECT CATEGORY, ORDER_TYPE, ORDER_NUM, PNAME, " + 
				" NVL(ENG_PNAME,'-'), INTRO, NVL(REC_FLAVOR,'-'), " + 
				" MONTHLY_RANK, NVL(HASHTAG, '-'), PFILE, PSFILE, " + 
				" NVL(ONE_AMOUNT,'-'), NVL(KCAL,'-'), NVL(NATRIUM,0), NVL(SUGAR,0), " + 
				" NVL(FAT,0), NVL(PROTEIN,0), NVL(CAFFEINE,0), " + 
				" NVL(ALLERGY,'-'), SET_CHECK FROM BR31_MENU WHERE CATEGORY=? "
				+ " ORDER BY ORDER_NUM DESC ";
		
		getPreparedStatement(sql);
		try {
			pstmt.setString(1, category.toUpperCase());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MenuVO vo = new MenuVO();
				vo.setCategory(rs.getString(1));
				vo.setOrder_type(rs.getString(2));
				vo.setOrder_num(rs.getString(3));
				vo.setPname(rs.getString(4));
				vo.setEng_pname(rs.getString(5));
				vo.setIntro(rs.getString(6));
				if(rs.getString(7)!=null){
					vo.setRec_flavor(getStringList(rs.getString(7)));
				}
				vo.setMonthly_rank(rs.getInt(8));
				if(rs.getString(9)!=null) {
					vo.setHashtag(getStringList(rs.getString(9)));
				}
				vo.setPfile(rs.getString(10));
				vo.setPsfile(rs.getString(11));
				vo.setOne_amount(rs.getString(12));
				vo.setKcal(rs.getString(13));
				vo.setNatrium(rs.getInt(14));
				vo.setSugar(rs.getInt(15));
				vo.setFat(rs.getInt(16));
				vo.setProtein(rs.getInt(17));
				vo.setCaffeine(rs.getInt(18));
				if(rs.getString(19)!=null) {
					vo.setAllergy(getStringList(rs.getString(19)));
				}
				vo.setSet_check(rs.getInt(20));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		close();
		return list;
	}
	// admin update ---> 수정 처리(새로운 파일 선택)
	public boolean getUpdateResult(MenuVO vo) {
		boolean result = false;
		String sql = "";
		try {
			switch(vo.getOrder_type()) {
			case "common":			//시퀀스에 b로 넣는다.
				sql = " update br31_menu set order_type = ?, order_num = 'b'||seq_menu.nextval, eng_pname = ?, intro = ?, "
						+ " rec_flavor = ?, hashtag = ?, pfile = ?, psfile = ?, one_amount = ?, "
						+ " kcal = ?, natrium = ?, sugar = ?, fat = ?, protein = ?, "
						+ " caffeine = ?, allergy = ?, set_check = ? where pname = ? ";
				getPreparedStatement(sql);
				pstmt.setString(1, vo.getOrder_type());
				pstmt.setString(2, vo.getEng_pname());
				pstmt.setString(3, vo.getIntro());
				if(vo.getRec_flavor()!=null) {
					pstmt.setString(4, getString(vo.getRec_flavor()));
				}else {
					pstmt.setString(4, null);
				}
				if(vo.getHashtag()!=null) {
					pstmt.setString(5, getString(vo.getHashtag()));
				}else {
					pstmt.setString(5, null);
				}
				pstmt.setString(6, vo.getPfile());
				pstmt.setString(7, vo.getPsfile());
				pstmt.setString(8, vo.getOne_amount());
				pstmt.setString(9, vo.getKcal());
				pstmt.setInt(10, vo.getNatrium());
				pstmt.setInt(11, vo.getSugar());
				pstmt.setInt(12, vo.getFat());
				pstmt.setInt(13, vo.getProtein());
				pstmt.setInt(14, vo.getCaffeine());
				if(vo.getAllergy()!=null) {
					pstmt.setString(15, getString(vo.getAllergy()));
				}else {
					pstmt.setString(15, null);
				}
				pstmt.setInt(16, 0);
				pstmt.setString(17, vo.getPname());
				
				break;
			case "promotion":			//시퀀스에 c로 넣는다.
				sql = " update br31_menu set order_type = ?, order_num = 'c'||seq_menu.nextval, eng_pname = ?, intro = ?, "
						+ " rec_flavor = ?, hashtag = ?, pfile = ?, psfile = ?, one_amount = ?, "
						+ " kcal = ?, natrium = ?, sugar = ?, fat = ?, protein = ?, "
						+ " caffeine = ?, allergy = ?, set_check = ? where pname = ? ";
				getPreparedStatement(sql);
				pstmt.setString(1, vo.getOrder_type());
				pstmt.setString(2, vo.getEng_pname());
				pstmt.setString(3, vo.getIntro());
				if(vo.getRec_flavor()!=null) {
					pstmt.setString(4, getString(vo.getRec_flavor()));
				}else {
					pstmt.setString(4, null);
				}
				if(vo.getHashtag()!=null) {
					pstmt.setString(5, getString(vo.getHashtag()));
				}else {
					pstmt.setString(5, null);
				}
				pstmt.setString(6, vo.getPfile());
				pstmt.setString(7, vo.getPsfile());
				pstmt.setString(8, vo.getOne_amount());
				pstmt.setString(9, vo.getKcal());
				pstmt.setInt(10, vo.getNatrium());
				pstmt.setInt(11, vo.getSugar());
				pstmt.setInt(12, vo.getFat());
				pstmt.setInt(13, vo.getProtein());
				pstmt.setInt(14, vo.getCaffeine());
				if(vo.getAllergy()!=null) {
					pstmt.setString(15, getString(vo.getAllergy()));
				}else {
					pstmt.setString(15, null);
				}
				pstmt.setInt(16, 0);
				pstmt.setString(17, vo.getPname());
				break;
			case "pack":				//시퀀스에 a로 넣는다.
				sql = " update br31_menu set order_type = ?, order_num = 'a'||seq_menu.nextval, eng_pname = ?, intro = ?, "
						+ " rec_flavor = ?, hashtag = ?, pfile = ?, psfile = ?, one_amount = ?, "
						+ " kcal = ?, natrium = ?, sugar = ?, fat = ?, protein = ?, "
						+ " caffeine = ?, allergy = ?, set_check = ? where pname = ? ";
				getPreparedStatement(sql);
				pstmt.setString(1, vo.getOrder_type());
				pstmt.setString(2, vo.getEng_pname());
				pstmt.setString(3, vo.getIntro());
				if(vo.getRec_flavor()!=null) {
					pstmt.setString(4, getString(vo.getRec_flavor()));
				}else {
					pstmt.setString(4, null);
				}
				if(vo.getHashtag()!=null) {
					pstmt.setString(5, getString(vo.getHashtag()));
				}else {
					pstmt.setString(5, null);
				}
				pstmt.setString(6, vo.getPfile());
				pstmt.setString(7, vo.getPsfile());
				pstmt.setString(8, vo.getOne_amount());
				pstmt.setString(9, vo.getKcal());
				pstmt.setInt(10, vo.getNatrium());
				pstmt.setInt(11, vo.getSugar());
				pstmt.setInt(12, vo.getFat());
				pstmt.setInt(13, vo.getProtein());
				pstmt.setInt(14, vo.getCaffeine());
				if(vo.getAllergy()!=null) {
					pstmt.setString(15, getString(vo.getAllergy()));
				}else {
					pstmt.setString(15, null);
				}
				pstmt.setInt(16, 0);
				pstmt.setString(17, vo.getPname());
				break;
			}
			
			int r=pstmt.executeUpdate();
			if(r!=0) {
				result=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
			
	// admin update ---> 수정 처리(기존 파일)
	public boolean getUpdateResultNofile(MenuVO vo) {
		boolean result = false;
		String sql = "";
		try {
			switch(vo.getOrder_type()) {
			case "common":			//시퀀스에 b로 넣는다.
				sql = " update br31_menu set order_type = ?, order_num = 'b'||seq_menu.nextval, eng_pname = ?, intro = ?, "
						+ " rec_flavor = ?, hashtag = ?, one_amount = ?, "
						+ " kcal = ?, natrium = ?, sugar = ?, fat = ?, protein = ?, "
						+ " caffeine = ?, allergy = ?, set_check = ? where pname = ? ";
				getPreparedStatement(sql);
				pstmt.setString(1, vo.getOrder_type());
				pstmt.setString(2, vo.getEng_pname());
				pstmt.setString(3, vo.getIntro());
				if(vo.getRec_flavor()!=null) {
					pstmt.setString(4, getString(vo.getRec_flavor()));
				}else {
					pstmt.setString(4, null);
				}
				if(vo.getHashtag()!=null) {
					pstmt.setString(5, getString(vo.getHashtag()));
				}else {
					pstmt.setString(5, null);
				}
				pstmt.setString(6, vo.getOne_amount());
				pstmt.setString(7, vo.getKcal());
				pstmt.setInt(8, vo.getNatrium());
				pstmt.setInt(9, vo.getSugar());
				pstmt.setInt(10, vo.getFat());
				pstmt.setInt(11, vo.getProtein());
				pstmt.setInt(12, vo.getCaffeine());
				if(vo.getAllergy()!=null) {
					pstmt.setString(13, getString(vo.getAllergy()));
				}else {
					pstmt.setString(13, null);
				}
				pstmt.setInt(14, 0);
				pstmt.setString(15, vo.getPname());
				
				break;
			case "promotion":			//시퀀스에 c로 넣는다.
				sql = " update br31_menu set order_type = ?, order_num = 'c'||seq_menu.nextval, eng_pname = ?, intro = ?, "
						+ " rec_flavor = ?, hashtag = ?, one_amount = ?, "
						+ " kcal = ?, natrium = ?, sugar = ?, fat = ?, protein = ?, "
						+ " caffeine = ?, allergy = ?, set_check = ? where pname = ? ";
				getPreparedStatement(sql);
				pstmt.setString(1, vo.getOrder_type());
				pstmt.setString(2, vo.getEng_pname());
				pstmt.setString(3, vo.getIntro());
				if(vo.getRec_flavor()!=null) {
					pstmt.setString(4, getString(vo.getRec_flavor()));
				}else {
					pstmt.setString(4, null);
				}
				if(vo.getHashtag()!=null) {
					pstmt.setString(5, getString(vo.getHashtag()));
				}else {
					pstmt.setString(5, null);
				}
				pstmt.setString(6, vo.getOne_amount());
				pstmt.setString(7, vo.getKcal());
				pstmt.setInt(8, vo.getNatrium());
				pstmt.setInt(9, vo.getSugar());
				pstmt.setInt(10, vo.getFat());
				pstmt.setInt(11, vo.getProtein());
				pstmt.setInt(12, vo.getCaffeine());
				if(vo.getAllergy()!=null) {
					pstmt.setString(13, getString(vo.getAllergy()));
				}else {
					pstmt.setString(13, null);
				}
				pstmt.setInt(14, 0);
				pstmt.setString(15, vo.getPname());
				
				break;
			case "pack":				//시퀀스에 a로 넣는다.
				sql = " update br31_menu set order_type = ?, order_num = 'a'||seq_menu.nextval, eng_pname = ?, intro = ?, "
						+ " rec_flavor = ?, hashtag = ?, one_amount = ?, "
						+ " kcal = ?, natrium = ?, sugar = ?, fat = ?, protein = ?, "
						+ " caffeine = ?, allergy = ?, set_check = ? where pname = ? ";
				getPreparedStatement(sql);
				pstmt.setString(1, vo.getOrder_type());
				pstmt.setString(2, vo.getEng_pname());
				pstmt.setString(3, vo.getIntro());
				if(vo.getRec_flavor()!=null) {
					pstmt.setString(4, getString(vo.getRec_flavor()));
				}else {
					pstmt.setString(4, null);
				}
				if(vo.getHashtag()!=null) {
					pstmt.setString(5, getString(vo.getHashtag()));
				}else {
					pstmt.setString(5, null);
				}
				pstmt.setString(6, vo.getOne_amount());
				pstmt.setString(7, vo.getKcal());
				pstmt.setInt(8, vo.getNatrium());
				pstmt.setInt(9, vo.getSugar());
				pstmt.setInt(10, vo.getFat());
				pstmt.setInt(11, vo.getProtein());
				pstmt.setInt(12, vo.getCaffeine());
				if(vo.getAllergy()!=null) {
					pstmt.setString(13, getString(vo.getAllergy()));
				}else {
					pstmt.setString(13, null);
				}
				pstmt.setInt(14, 0);
				pstmt.setString(15, vo.getPname());
				break;
			}
			
			int r=pstmt.executeUpdate();
			if(r!=0) {
				result=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	//admin delete ---> admin 삭제
	public boolean getDeleteResult(String pname) {
		boolean result = false;
		String sql = " delete from br31_menu where pname = ? ";
		
		getPreparedStatement(sql);
		
		try {
		pstmt.setString(1, pname);
		int a = pstmt.executeUpdate();
		if(a!=0) {
			result = true;
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//select ---> admin에서 수정버튼을 눌렀을 시 불러오는 특정 content
	public MenuVO getAdminContent(String pname){
		MenuVO vo = new MenuVO();
		String sql = " SELECT * FROM BR31_MENU WHERE PNAME = ? ";
		
		getPreparedStatement(sql);
		try {
			pstmt.setString(1, pname);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				vo.setCategory(rs.getString(1));
				vo.setOrder_type(rs.getString(2));
				vo.setOrder_num(rs.getString(3));
				vo.setPname(rs.getString(4));
				vo.setEng_pname(rs.getString(5));
				vo.setIntro(rs.getString(6));
				if(rs.getString(7)!=null){
					vo.setRec_flavor(getStringList(rs.getString(7)));
				}
				vo.setMonthly_rank(rs.getInt(8));
				if(rs.getString(9)!=null) {
					vo.setHashtag(getStringList(rs.getString(9)));
				}
				vo.setPfile(rs.getString(10));
				vo.setPsfile(rs.getString(11));
				vo.setOne_amount(rs.getString(12));
				vo.setKcal(rs.getString(13));
				vo.setNatrium(rs.getInt(14));
				vo.setSugar(rs.getInt(15));
				vo.setFat(rs.getInt(16));
				vo.setProtein(rs.getInt(17));
				vo.setCaffeine(rs.getInt(18));
				if(rs.getString(19)!=null) {
					vo.setAllergy(getStringList(rs.getString(19)));
				}
				vo.setSet_check(rs.getInt(20));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	//Select --> admin의 특정 아이스크림 nutrient 조회
	public MenuVO getAdminNutrientContent(String pname) {
		MenuVO vo = new MenuVO();
		String sql = " select pname, one_amount, kcal, natrium, sugar, "
				+ "fat, protein, caffeine, allergy, set_check from br31_menu "
				+ " where pname = ?";
		getPreparedStatement(sql);
		try {
			pstmt.setString(1, pname);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo.setPname(rs.getString(1));
				vo.setOne_amount(rs.getString(2));
				vo.setKcal(rs.getString(3));
				vo.setNatrium(rs.getInt(4));
				vo.setSugar(rs.getInt(5));
				vo.setFat(rs.getInt(6));
				vo.setProtein(rs.getInt(7));
				vo.setCaffeine(rs.getInt(8));
				if(rs.getString(9)!=null) {
					vo.setAllergy(getStringList(rs.getString(9)));
				}
				vo.setSet_check(rs.getInt(10));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
		
	}
	
	//Select --> monthly best flavor
	public ArrayList<MenuVO> getMonthlyIcecreamList() {
		ArrayList<MenuVO> list = new ArrayList<MenuVO>();
		String sql = " SELECT PNAME, PSFILE FROM BR31_MENU WHERE CATEGORY='ICECREAM' ORDER BY MONTHLY_RANK ";
		
		getPreparedStatement(sql);
		try {
			rs= pstmt.executeQuery();
			while(rs.next()) {
				MenuVO vo = new MenuVO();
				vo.setPname(rs.getString(1));
				vo.setPsfile(rs.getString(2));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		close();
		return list;
	}
	//Select ---> menu 조회 - 아이스크림
	public MenuVO getMenuIcecreamContent(String pname) {
		MenuVO vo = new MenuVO();
		String sql = " select pname, eng_pname, intro, rec_flavor, psfile, set_check from br31_menu where pname = ? ";
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, pname);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				vo.setPname(rs.getString(1));
				if(rs.getString(2)!=null) {
					vo.setEng_pname(rs.getString(2));
				}
				vo.setIntro(rs.getString(3));
				if(rs.getString(4)!=null) {
					vo.setRec_flavor(getStringList(rs.getString(4)));
				}
				vo.setPsfile(rs.getString(5));
				vo.setSet_check(rs.getInt(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	//Select--> menu 조회 - 이전/다음 메뉴
	public String getNextMenuPname(String pname, String category, String status) {
		String result = "";
		String sql = "";
		if(status.equals("previous")) {
			sql = " select pname from (select rownum rno, pname from (select pname from br31_menu where category = ? order by order_num desc)) " + 
					" where rno = (select rno from (select rownum rno, pname from (select pname from br31_menu where category = ? order by order_num desc)) where pname=?)-1 ";
		}else if(status.equals("next")) {
			sql = " select pname from (select rownum rno, pname from (select pname from br31_menu where category = ? order by order_num desc)) " + 
					" where rno = (select rno from (select rownum rno, pname from (select pname from br31_menu where category = ? order by order_num desc)) where pname=?)+1 ";
		}
		getPreparedStatement(sql);
		
		try {
			pstmt.setString(1, category.toUpperCase());
			pstmt.setString(2, category.toUpperCase());
			pstmt.setString(3, pname);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString(1);
			}else {
				result = "null";
			}
			
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//Select ---> 영양정보 조회 - 기본화면(전체출력) - 페이징 처리
	public ArrayList<MenuVO> getAllNutrientsList(String category, int start, int end){
		ArrayList<MenuVO> list = new ArrayList<MenuVO>();
		String sql = " select rownum rno, pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, " + 
				" allergy, set_check from (select rownum rno, pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, " + 
				" allergy, set_check from (select pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, allergy, set_check " + 
				" from br31_menu order by pname)) where rno between ? and ? ";
		
		if(category.equals("icecream")) {
			sql = " select rownum rno, pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, " + 
					" allergy, set_check from (select rownum rno, pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, " + 
					" allergy, set_check from (select pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, allergy, set_check " + 
					" from br31_menu where category = 'ICECREAM' order by pname)) where rno between ? and ? ";
		}else if(category.equals("coffee")) {
			sql = " select rownum rno, pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, " + 
					" allergy, set_check from (select rownum rno, pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, " + 
					" allergy, set_check from (select pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, allergy, set_check " + 
					" from br31_menu where category = 'COFFEE' order by pname)) where rno between ? and ? ";
		}
		
		getPreparedStatement(sql);
		
		try {
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MenuVO vo = new MenuVO();
				
				vo.setPname(rs.getString(2));
				
				if(rs.getString(3)!=null) {		//1회제공량이 null이 아닐때
					vo.setOne_amount(rs.getString(3));
				}
				
				if(rs.getString(4)!=null) {		//열량이 null이 아닐 때
					vo.setKcal(rs.getString(4));
				}
				
				vo.setNatrium(rs.getInt(5));
				vo.setSugar(rs.getInt(6));
				vo.setFat(rs.getInt(7));
				vo.setProtein(rs.getInt(8));
				vo.setCaffeine(rs.getInt(9));
				
				if(rs.getString(10)!=null) {		//알러지가 null이 아닐 때
					String[] alist = getStringList(rs.getString(10));
					vo.setAllergy(alist);
				}
				
				vo.setSet_check(rs.getInt(11));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	//Select ---> 영양정보 조회 - 기본화면(전체출력)
	public ArrayList<MenuVO> getAllNutrientsList(String category){
		ArrayList<MenuVO> list = new ArrayList<MenuVO>();
		String sql = " select pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, allergy, set_check " + 
				" from br31_menu order by pname ";
		
		if(category.equals("icecream")) {
			sql = " select pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, allergy, set_check " + 
					" from br31_menu where category = 'ICECREAM' order by pname ";
		}else if(category.equals("coffee")) {
			sql = " select pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, allergy, set_check " + 
					" from br31_menu where category = 'COFFEE' order by pname ";
		}
		
		getPreparedStatement(sql);
		
		try {
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MenuVO vo = new MenuVO();
				
				vo.setPname(rs.getString(1));
				
				if(rs.getString(2)!=null) {		//1회제공량이 null이 아닐때
					vo.setOne_amount(rs.getString(2));
				}
				
				if(rs.getString(3)!=null) {		//열량이 null이 아닐 때
					vo.setKcal(rs.getString(3));
				}

				vo.setNatrium(rs.getInt(4));
				vo.setSugar(rs.getInt(5));
				vo.setFat(rs.getInt(6));
				vo.setProtein(rs.getInt(7));
				vo.setCaffeine(rs.getInt(8));
				
				if(rs.getString(9)!=null) {		//알러지가 null이 아닐 때
					String[] alist = getStringList(rs.getString(9));
					vo.setAllergy(alist);
				}
				
				vo.setSet_check(rs.getInt(10));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//select --> 영양성분 조회 - 검색결과 출력 - 페이징 처리
	public ArrayList<MenuVO> getNutrientSearchResult(String category, String pname, String nutrient, String sorting, String[] allergies, int start, int end){
		ArrayList<MenuVO> list = new ArrayList<MenuVO>();
		String sql = " select rownum rno, pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, " + 
				" allergy, set_check from (select rownum rno, pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, " + 
				" allergy, set_check from (select pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, allergy, set_check " + 
				" from br31_menu ";
		int w_check = 0;	//where절 체크 변수
		if(!category.equals("all")) {
			sql += " where category = '" + category.toUpperCase() +"'";
			w_check = 1;
		}
		if(!pname.equals("")) {
			if(w_check==0) {
				sql += " where pname like '%" +pname +"%'";
				w_check = 1;
			}else {
				sql += " and pname like '%" +pname +"%'";
			}
		}
		if(allergies!=null) {
			//String allergy = getString(allergies);
			if(w_check==0) {	//where절이 안들어갔을 때
				for(int i=0;i<allergies.length;i++) {
					if(i==0) {
						if(allergies[i].equals("없음")) {
							sql += " where allergy is null ";
						}else {
							sql += " where allergy like '%"+allergies[i]+"%'";
						}
					}else {
						if(allergies[i].equals("없음")) {
							sql += " and allergy is null ";
						}else {
							sql += " and allergy like '%"+allergies[i]+"%'";
						}
					}
				}
				w_check=1;
			}else {	//where절이 이미 있을 때
				for(int i=0;i<allergies.length;i++) {
					if(allergies[i].equals("없음")) {
						sql += " and allergy is null ";
					}else {
						sql += " and allergy like '%"+allergies[i]+"%'";
					}
				}
			}
		}
		if(!sorting.equals("전체")) {	//영양성분, 정렬순서 둘다 선택했을때
			if(w_check==0) {	//where 절이 안들어갔을 떄
				if(sorting.equals("높은순")) {
					sql += " where set_check=0 order by to_number("+nutrient+") desc";
				}else {	//낮은순
					sql += " where set_check=0 order by to_number("+nutrient+")";
				}
				w_check=1;
			}else {		//where절이 이미 있을 때
				if(sorting.equals("높은순")) {
					sql += " and set_check=0 order by to_number("+nutrient+") desc";
				}else {	//낮은순
					sql += " and set_check=0 order by to_number("+nutrient+")";
				}
			}
		}else if(sorting.equals("전체") && !nutrient.equals("전체")){	//영양성분만 선택했을때(기본정렬: 오름차순)
			if(w_check==0) {
				sql += " where set_check=0 order by to_number("+nutrient+")";
				w_check=1;
			}else {
				sql += " and set_check=0 order by to_number("+nutrient+")";
			}
		}else if(sorting.equals("전체") && nutrient.equals("전체")) {	//정렬 선택을 안했을때(이름 오름차순)
			sql += " order by pname";
		}
		sql += ")) where rno between " + start + " and " + end;
				try {
					getStatement();
					rs = stmt.executeQuery(sql);
					while(rs.next()) {
						MenuVO vo = new MenuVO();
						vo.setPname(rs.getString(2));
						
						if(rs.getString(3)!=null) {
							vo.setOne_amount(rs.getString(3));
						}
						
						if(rs.getString(4)!=null) {
							vo.setKcal(rs.getString(4));
						}
						
						vo.setNatrium(rs.getInt(5));
						vo.setSugar(rs.getInt(6));
						vo.setFat(rs.getInt(7));
						vo.setProtein(rs.getInt(8));
						vo.setCaffeine(rs.getInt(9));
						
						if(rs.getString(10)!=null) {
							String[] alist = getStringList(rs.getString(10));
							vo.setAllergy(alist);
						}
						
						vo.setSet_check(rs.getInt(11));
						
						list.add(vo);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
		return list;
	}
	
	//select --> 영양성분 조회 - 전체 개수
	public int getNutrientSearchResultCount(String category, String pname, String nutrient, String sorting, String[] allergies){
		int result = 0;
		String sql = "select count(*) from br31_menu ";
		int w_check = 0;	//where절 체크 변수
		if(!category.equals("all")) {
			sql += " where category = '" + category.toUpperCase()+"' ";
			w_check = 1;
		}
		if(!pname.equals("")) {
			if(w_check==0) {
				sql += " where pname like '%" +pname +"%'";
				w_check = 1;
			}else {
				sql += " and pname like '%" +pname +"%'";
			}
		}
		if(allergies!=null) {
			//String allergy = getString(allergies);
			if(w_check==0) {	//where절이 안들어갔을 때
				for(int i=0;i<allergies.length;i++) {
					if(i==0) {
						sql += " where allergy like '%"+allergies[i]+"%'";
					}else {
						sql += " and allergy like '%"+allergies[i]+"%'";
					}
				}
				w_check=1;
			}else {	//where절이 이미 있을 때
				for(int i=0;i<allergies.length;i++) {
					sql += " and allergy like '%"+allergies[i]+"%'";
				}
			}
		}
		if(!sorting.equals("전체")) {	//영양성분, 정렬순서 둘다 선택했을때
			if(w_check==0) {	//where 절이 안들어갔을 떄
				if(sorting.equals("높은순")) {
					sql += " where set_check=0 order by to_number("+nutrient+") desc";
				}else {	//낮은순
					sql += " where set_check=0 order by to_number("+nutrient+")";
				}
				w_check=1;
			}else {		//where절이 이미 있을 때
				if(sorting.equals("높은순")) {
					sql += " and set_check=0 order by to_number("+nutrient+") desc";
				}else {	//낮은순
					sql += " and set_check=0 order by to_number("+nutrient+")";
				}
			}
		}else if(sorting.equals("전체") && !nutrient.equals("전체")){	//영양성분만 선택했을때(기본정렬: 오름차순)
			if(w_check==0) {
				sql += " where set_check=0 order by to_number("+nutrient+")";
				w_check=1;
			}else {
				sql += " and set_check=0 order by to_number("+nutrient+")";
			}
		}
		try {
			getStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	//select --> 영양성분 조회 - 검색결과 출력
	public ArrayList<MenuVO> getNutrientSearchResult(String category, String pname, String nutrient, String sorting, String[] allergies){
		ArrayList<MenuVO> list = new ArrayList<MenuVO>();
		String sql = "select pname, one_amount, kcal, natrium, sugar, fat, protein, caffeine, allergy, set_check " + 
				" from br31_menu ";
		int w_check = 0;	//where절 체크 변수
		if(!category.equals("all")) {
			sql += " where category = '" + category.toUpperCase() +"'";
			w_check = 1;
		}
		if(!pname.equals("")) {
			if(w_check==0) {
				sql += " where pname like '%" +pname +"%'";
				w_check = 1;
			}else {
				sql += " and pname like '%" +pname +"%'";
			}
 		}
		if(allergies!=null) {
			//String allergy = getString(allergies);
			if(w_check==0) {	//where절이 안들어갔을 때
				for(int i=0;i<allergies.length;i++) {
					if(i==0) {
						sql += " where allergy like '%"+allergies[i]+"%'";
					}else {
						sql += " and allergy like '%"+allergies[i]+"%'";
					}
				}
				w_check=1;
			}else {	//where절이 이미 있을 때
				for(int i=0;i<allergies.length;i++) {
						sql += " and allergy like '%"+allergies[i]+"%'";
				}
			}
		}
		if(!sorting.equals("전체")) {	//영양성분, 정렬순서 둘다 선택했을때
			if(w_check==0) {	//where 절이 안들어갔을 떄
				if(sorting.equals("높은순")) {
					sql += " where set_check=0 order by to_number("+nutrient+") desc";
				}else {	//낮은순
					sql += " where set_check=0 order by to_number("+nutrient+")";
				}
				w_check=1;
			}else {		//where절이 이미 있을 때
				if(sorting.equals("높은순")) {
					sql += " and set_check=0 order by to_number("+nutrient+") desc";
				}else {	//낮은순
					sql += " and set_check=0 order by to_number("+nutrient+")";
				}
			}
		}else if(sorting.equals("전체") && !nutrient.equals("전체")){	//영양성분만 선택했을때(기본정렬: 오름차순)
			if(w_check==0) {
				sql += " where set_check=0 order by to_number("+nutrient+")";
				w_check=1;
			}else {
				sql += " and set_check=0 order by to_number("+nutrient+")";
			}
		}
		try {
			getStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				MenuVO vo = new MenuVO();
				vo.setPname(rs.getString(1));
				
				if(rs.getString(2)!=null) {
					vo.setOne_amount(rs.getString(2));
				}
				
				if(rs.getString(3)!=null) {
					vo.setKcal(rs.getString(3));
				}

				vo.setNatrium(rs.getInt(4));
				vo.setSugar(rs.getInt(5));
				vo.setFat(rs.getInt(6));
				vo.setProtein(rs.getInt(7));
				vo.setCaffeine(rs.getInt(8));
				
				if(rs.getString(9)!=null) {
					String[] alist = getStringList(rs.getString(9));
					vo.setAllergy(alist);
				}
				
				vo.setSet_check(rs.getInt(10));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//select ---> 메뉴 조회 부분의 검색 결과 출력
	public ArrayList<MenuVO> getSearchResult(String category, String pname, String hashtag, String[] allergies){
		ArrayList<MenuVO> list = new ArrayList<MenuVO>();
		String sql = " select pname, hashtag, psfile, set_check from br31_menu where category = '" + category.toUpperCase() + "'";
		
		if(!pname.equals("")) {
			sql += " and pname like '%" +pname +"%'";
		}
		if(!hashtag.equals("")) {
			if(hashtag.contains("#")) {
				sql += " and hashtag like '%" + hashtag + "%'";
			}else {
				sql += " and hashtag like '%#" + hashtag + "%'";
			}
		}
		if(allergies!=null) {
			for(int i=0;i<allergies.length;i++) {
				sql += " and allergy like '%"+allergies[i]+"%'";
			}
		}
		
		
		try {
			getStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				MenuVO vo = new MenuVO();
				vo.setPname(rs.getString(1));
				vo.setHashtag(getStringList(rs.getString(2)));
				vo.setPsfile(rs.getString(3));
				vo.setSet_check(rs.getInt(4));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		close();
		return list;
	}
}	//class