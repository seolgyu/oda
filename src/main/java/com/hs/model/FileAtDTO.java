package com.hs.model;

public class FileAtDTO {
	private Long fileAtId;
    private String fileName;   
    private String filePath;    
    private Long fileSize;
    private String fileType;
    private Integer fileOrder;
    private String uploadedDate;
    private Long postId;
    
	public Long getFileAtId() {
		return fileAtId;
	}
	public void setFileAtId(Long fileAtId) {
		this.fileAtId = fileAtId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public Integer getFileOrder() {
		return fileOrder;
	}
	public void setFileOrder(Integer fileOrder) {
		this.fileOrder = fileOrder;
	}
	public String getUploadedDate() {
		return uploadedDate;
	}
	public void setUploadedDate(String uploadedDate) {
		this.uploadedDate = uploadedDate;
	}
	public Long getPostId() {
		return postId;
	}
	public void setPostId(Long postId) {
		this.postId = postId;
	}
}
