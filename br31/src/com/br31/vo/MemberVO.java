package com.br31.vo;

public class MemberVO {
	String id, pass, name, gender, birth, hp, hp1, hp2, hp3, addr, addr1, addr2, email, email1, email2, card, m_favor, mdate, admin; 
	int point, choice, rno;
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getAddr() {
		String str = "";
		if(addr1 != null) {
			str = "(" + addr1 + ")" + addr2;
			
		}else {
			str = addr;
			
		}
		return str;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getEmail() {
		if(email1 != null) {
			email = "";
			email = email1 + "@" + email2;
		}
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCard() {
		return card;
	}
	public void setCard(String card) {
		this.card = card;
	}
	public String getM_favor() {
		return m_favor;
	}
	public void setM_favor(String m_favor) {
		this.m_favor = m_favor;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getChoice() {
		return choice;
	}
	public void setChoice(int choice) {
		this.choice = choice;
	}
	public String getHp() {
		String str = "";
		if(hp1 != null) {
			str = hp1 + "-" + hp2 + "-" + hp3;
		}else {
			str = hp;
		}
		return str;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getHp1() {
		return hp1;
	}
	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}
	public String getHp2() {
		return hp2;
	}
	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}
	public String getHp3() {
		return hp3;
	}
	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	
	
}
