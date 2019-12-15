package com.nf.easybuy.mapper;


import com.nf.easybuy.domain.Order;
import com.nf.easybuy.domain.OrderDetaiShow;
import com.nf.easybuy.domain.OrderDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderDetailMapper {

	void add(Order order);

	List<OrderDetail> getOrderDetailByOrderId(Integer orderId);

	int delOrderDetailByOrderId(Integer orderId);

	int saveOrderDetail(@Param("orderDetails") List<OrderDetail> orderDetails);

	List<OrderDetaiShow> getAllOrderDetailShowByOrderId(int orderId);

}