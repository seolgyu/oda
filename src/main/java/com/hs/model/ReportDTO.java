package com.hs.model;

public class ReportDTO {
    private long reportNum;
    private long reportUserNum;
    private String reportReason;
    private String reportType;    // "POST"
    private String reportContent; // postId 저장
    private String reportDate;

    public long getReportNum() { return reportNum; }
    public void setReportNum(long reportNum) { this.reportNum = reportNum; }
    public long getReportUserNum() { return reportUserNum; }
    public void setReportUserNum(long reportUserNum) { this.reportUserNum = reportUserNum; }
    public String getReportReason() { return reportReason; }
    public void setReportReason(String reportReason) { this.reportReason = reportReason; }
    public String getReportType() { return reportType; }
    public void setReportType(String reportType) { this.reportType = reportType; }
    public String getReportContent() { return reportContent; }
    public void setReportContent(String reportContent) { this.reportContent = reportContent; }
    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }
}