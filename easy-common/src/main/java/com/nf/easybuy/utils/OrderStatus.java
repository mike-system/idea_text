package com.nf.easybuy.utils;

public enum OrderStatus {
	
	SUBMITTED(0), // 已提交
	ACCOUNTED(2), // 已付款
	SHIPPED(4),  	// 已发货
	COMPLETED(8); 	//已完成
	private int value;
	private OrderStatus(int value) {
		this.value = value;
	}
	
	public int getValue() {
		return value;
	}
}

