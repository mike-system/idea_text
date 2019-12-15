package com.nf.easybuy.mapper;


import com.nf.easybuy.domain.Order;
import com.nf.easybuy.domain.OrderDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderMapper {

	// 删除
	int delOrderByIdAndUserId(@Param("orderId") Integer orderId, @Param("userId") Integer userId);



	int updateById(@Param("orderId") int orderId, @Param("addr") String addr, @Param("status") int status);

	Order getOrderById(int orderId);

	List<Order> getAllOrderByUserIdAndStatus(@Param("userId") Integer userId, @Param("value") int value);

	Order getOrderByUserIdAndOderNumAndOrderStatu(@Param("userId") Integer userId, @Param("val1") String val1, @Param("status") int status);

	int getAllOrderByUserIdAndOrderStatusCount(@Param("userId") Integer userId, @Param("status") int status);

	List<Order> getAllOrderByUserIdAndOrderStatus(@Param("userId") Integer userId, @Param("status") int status, @Param("start") int start, @Param("rows") Integer rows);


	int getAllOrderCount();

	List<Order> getOrderList(@Param("start") int start, @Param("rows") int rows);

	int delOrderByIdAndAdmin(Integer orderId);

	int sendOrderById(@Param("status") Integer status, @Param("orderId") Integer orderId);

	int saveOrder(Order order);
}