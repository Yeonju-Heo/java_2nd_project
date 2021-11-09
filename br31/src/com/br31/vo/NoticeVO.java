package com.br31.vo;

public class NoticeVO {
	private int rno, articleno;
	private String title, ncontent, nfile, nsfile, mdate ;

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public int getArticleno() {
		return articleno;
	}

	public void setArticleno(int articleno) {
		this.articleno = articleno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getNcontent() {
		return ncontent;
	}

	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}

	public String getNsfile() {
		return nsfile;
	}

	public void setNsfile(String nsfile) {
		this.nsfile = nsfile;
	}

	public String getNfile() {
		return nfile;
	}

	public void setNfile(String nfile) {
		this.nfile = nfile;
	}

	public String getMdate() {
		return mdate;
	}

	public void setMdate(String mdate) {
		this.mdate = mdate;
	}

	
}
