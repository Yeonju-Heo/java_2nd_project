package com.br31.comms;

import java.util.HashMap;

import com.br31.dao.DBConn;

public class Commons {

	// ?˜?´ì§? ì²˜ë¦¬ ë©”ì†Œ?“œ - startCount, endCount: HashMap map = commons.getPage(rpage, dao);
	public HashMap<String, Integer> getPage(String rpage, DBConn dao) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		// ?˜?´ì§? ì²˜ë¦¬ - startCount, endCount êµ¬í•˜ê¸?
		int startCount = 0;
		int endCount = 0;
		int pageSize = 10; // ?•œ?˜?´ì§??‹¹ ê²Œì‹œë¬? ?ˆ˜
		int reqPage = 1; // ?š”ì²??˜?´ì§?
		int pageCount = 1; // ? „ì²? ?˜?´ì§? ?ˆ˜
		int dbCount = dao.execTotalCount(); // DB?—?„œ ê°?? ¸?˜¨ ? „ì²? ?–‰?ˆ˜

		// ì´? ?˜?´ì§? ?ˆ˜ ê³„ì‚°
		if (dbCount % pageSize == 0) {
			pageCount = dbCount / pageSize;
		} else {
			pageCount = dbCount / pageSize + 1;
		}

		// ?š”ì²? ?˜?´ì§? ê³„ì‚°
		if (rpage != null) {
			reqPage = Integer.parseInt(rpage);
			startCount = (reqPage - 1) * pageSize + 1;
			endCount = reqPage * pageSize;
		} else {
			startCount = 1;
			endCount = 5;
		}

		map.put("start", startCount);
		map.put("end", endCount);
		map.put("dbCount", dbCount);
		map.put("pageSize", pageSize);
		map.put("reqPage", reqPage);
		
		return map;
	}
}
