package com.nf.easybuy.service;


import com.nf.easybuy.domain.OrderDetaiShow;
import com.nf.easybuy.domain.OrderDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderDetailService {

	List<OrderDetail> getOrderDetailByOrderId(Integer orderId);

	int delOrderDetailByOrderId(Integer orderId);

	int saveOrderDetail(List<OrderDetail> orderDetails);

	List<OrderDetaiShow> getAllOrderDetailShowByOrderId(int orderId);

	void saveMergePostOrder(Integer id2, Integer id1, List<OrderDetail> orderDetailList1, int type, Integer userId);
}