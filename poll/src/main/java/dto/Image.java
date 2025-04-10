package dto;

public class Image {
	private int num;
	private String memo;
	private String fileName;
	private String createDate;
	
	@Override
	public String toString() {
		return "ImageDao [num=" + num + ", memo=" + memo + ", fileName=" + fileName + ", createDate=" + createDate
				+ "]";
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
}
