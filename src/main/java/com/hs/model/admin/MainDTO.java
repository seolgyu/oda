package com.hs.model.admin;

public class MainDTO {
	private int memberCountList; //총 가입자 수
	private int memberdaycount; //일일 가입자 수
	private int inmembercount; //이용중인 회원 수
	//이용중인 회원 중 1시간 내의 로그인 회원
	private int drewmembercount; //탈퇴 회원 수
	private int dormembercount; //휴면 계정 수
	private int dorexpmembercount; //휴면 예정 계정 수
	private int postcount; //게시글 수
	private int recentpostcount; //최근 게시글 수 
	private int comCount; //커뮤니티 개설 수
	private int comDayCount;//커뮤니티 일일 개설 수
	private int reportpostcount; //신고 처리된 게시물
	private int reportcount; //신고 처리 예정된 게시물
	private int comPriCount; //비공개 커뮤니티 수
	private int loginPercentage;//이용 중인 사용자 증가량

	private String dayName;
	private int noticeCount;
    private int loginCount;
    
    public int getLoginPercentage() {
		return loginPercentage;
	}

	public void setLoginPercentage(int loginPercentage) {
		this.loginPercentage = loginPercentage;
	}
    public int getComPriCount() {
		return comPriCount;
	}

	public void setComPriCount(int comPriCount) {
		this.comPriCount = comPriCount;
	}
    
    public int getReportpostcount() {
		return reportpostcount;
	}

	public void setReportpostcount(int reportpostcount) {
		this.reportpostcount = reportpostcount;
	}

	public int getReportcount() {
		return reportcount;
	}

	public void setReportcount(int reportcount) {
		this.reportcount = reportcount;
	}
    
    public String getDayName() {
		return dayName;
	}

	public void setDayName(String dayName) {
		this.dayName = dayName;
	}

	public int getNoticeCount() {
		return noticeCount;
	}

	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
	}

	public int getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}
	
	public int getComCount() {
		return comCount;
	}

	public void setComCount(int comCount) {
		this.comCount = comCount;
	}

	public int getComDayCount() {
		return comDayCount;
	}

	public void setComDayCount(int comDayCount) {
		this.comDayCount = comDayCount;
	}
	
	public int getRecentpostcount() {
		return recentpostcount;
	}

	public void setRecentpostcount(int recentpostcount) {
		this.recentpostcount = recentpostcount;
	}

	public int getPostcount() {
		return postcount;
	}

	public void setPostcount(int postcount) {
		this.postcount = postcount;
	}

	public int getDormembercount() {
		return dormembercount;
	}

	public void setDormembercount(int dormembercount) {
		this.dormembercount = dormembercount;
	}

	public int getDrewmembercount() {
		return drewmembercount;
	}

	public void setDrewmembercount(int drewmembercount) {
		this.drewmembercount = drewmembercount;
	}

	public int getInmembercount() {
		return inmembercount;
	}

	public void setInmembercount(int inmembercount) {
		this.inmembercount = inmembercount;
	}

	public int getMemberCountList() {
		return memberCountList;
	}

	public void setMemberCountList(int memberCountList) {
		this.memberCountList = memberCountList;
	}

	public int getMemberdaycount() {
		return memberdaycount;
	}

	public void setMemberdaycount(int memberdaycount) {
		this.memberdaycount = memberdaycount;
	}
	public int getDorexpmembercount() {
		return dorexpmembercount;
	}

	public void setDorexpmembercount(int dorexpmembercount) {
		this.dorexpmembercount = dorexpmembercount;
	}
	
}
