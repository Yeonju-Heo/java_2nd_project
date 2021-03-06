package com.br31.comms;

import java.util.HashMap;

import com.br31.dao.DBConn;

public class Commons {

	// ??΄μ§? μ²λ¦¬ λ©μ? - startCount, endCount: HashMap map = commons.getPage(rpage, dao);
	public HashMap<String, Integer> getPage(String rpage, DBConn dao) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		// ??΄μ§? μ²λ¦¬ - startCount, endCount κ΅¬νκΈ?
		int startCount = 0;
		int endCount = 0;
		int pageSize = 10; // ???΄μ§??Ή κ²μλ¬? ?
		int reqPage = 1; // ?μ²???΄μ§?
		int pageCount = 1; // ? μ²? ??΄μ§? ?
		int dbCount = dao.execTotalCount(); // DB?? κ°?? Έ?¨ ? μ²? ??

		// μ΄? ??΄μ§? ? κ³μ°
		if (dbCount % pageSize == 0) {
			pageCount = dbCount / pageSize;
		} else {
			pageCount = dbCount / pageSize + 1;
		}

		// ?μ²? ??΄μ§? κ³μ°
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
