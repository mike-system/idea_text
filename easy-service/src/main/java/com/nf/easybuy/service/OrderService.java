package com.nf.easybuy.service;


import com.nf.easybuy.domain.Order;
import com.nf.easybuy.utils.PagingUtil;

import java.util.List;

public interface OrderService {

	int saveOrder(Order order);

	boolean updateById(int orderId, String addr, int status);

	Order getOrderById(int orderId);

	List<Order> getAllOrderByUserIdAndStatus(Integer userId, int status);

	Order getOrderByUserIdAndOderNumAndOrderStatu(Integer userId, String orderNum, int status);

	boolean delOrderByIdAndUserId(Integer orderId, Integer type, Integer userId);

	Integer getAllOrderByUserIdAndOrderStatusCount(Integer userId, String orderStatus);

	List<Order> getAllOrderByUserIdAndStatus(Integer userId, String orderStatus, PagingUtil<Order> pagingInfo);

	int getAllOrderCount();

	List<Order> getOrderList(PagingUtil<Order> pageOrders);

	boolean sendOrderById(Integer status, String orderId);

}