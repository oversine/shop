package vo;

public class OrderComment {
	private int orderNo;
	private int ebookNo;
	private String orderComment;
	private int orderScore;
	private String updateDate;
	
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getEbookNo() {
		return ebookNo;
	}
	public void setEbookNo(int ebookNo) {
		this.ebookNo = ebookNo;
	}
	public String getOrderComment() {
		return orderComment;
	}
	public void setOrderComment(String orderComment) {
		this.orderComment = orderComment;
	}
	public int getOrderScore() {
		return orderScore;
	}
	public void setOrderScore(int orderScore) {
		this.orderScore = orderScore;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	@Override
	public String toString() {
		return "OrderComment [orderNo=" + orderNo + ", ebookNo=" + ebookNo + ", orderComment=" + orderComment
				+ ", orderScore=" + orderScore + ", updateDate=" + updateDate + "]";
	}
}
