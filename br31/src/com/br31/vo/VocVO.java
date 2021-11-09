package com.br31.vo;

public class VocVO {
	int rno;
	String vid, qtype, ctype, title, content, vfile, vsfile, name, hp, email, vdate, answer, status, id;
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getVid() {
		return vid;
	}
	public void setVid(String vid) {
		this.vid = vid;
	}
	public String getQtype() {
		return qtype;
	}
	public void setQtype(String qtype) {
		this.qtype = qtype;
	}
	public String getCtype() {
		return ctype;
	}
	public void setCtype(String ctype) {
		this.ctype = ctype;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getVfile() {
		return vfile;
	}
	public void setVfile(String vfile) {
		this.vfile = vfile;
	}
	public String getVsfile() {
		return vsfile;
	}
	public void setVsfile(String vsfile) {
		this.vsfile = vsfile;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getVdate() {
		return vdate;
	}
	public void setVdate(String vdate) {
		this.vdate = vdate;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		if(status.equals("NO")) {
			this.status = "답변대기";
		} else {
			this.status = "답변완료";
		}
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	
	
}
