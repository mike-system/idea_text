package com.nf.easybuy.utils;
 
import java.util.List;

public class PagingUtil<T> {
	private Integer currentPage = 1; //当前页码
	private Integer totalPage; 		// 总页码
	private Integer rows = 5; 		//每页行数
	private Integer total; 			//总条数
	private List<T> data; 			//列表
	
	
	public PagingUtil(String currentPageStr) {
		if(currentPageStr != null && Integer.parseInt(currentPageStr) > 1){
			currentPage = Integer.parseInt(currentPageStr);
		}
	}
 
	public int getStart(){
		return (currentPage-1) * rows;
	}
	
	public Integer getCurrentPage() {
		return currentPage;
	}
	
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Integer getTotalPage() {
		if(total % rows == 0){
			totalPage = total/rows;
		}else{
			totalPage = total/rows + 1;
		}
		return totalPage;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
		getTotalPage(); //计算页码,并给当前成员总页码属性赋值
	}
	public List<T> getData() {
		return data;
	}
	public void setData(List<T> data) {
		this.data = data;
	}
}