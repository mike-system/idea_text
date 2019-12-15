package com.nf.easybuy.service.impl;


import com.nf.easybuy.domain.Order;
import com.nf.easybuy.mapper.OrderDetailMapper;
import com.nf.easybuy.mapper.OrderMapper;
import com.nf.easybuy.service.OrderService;
import com.nf.easybuy.utils.PagingUtil;

import java.util.List;

public class OrderServiceImpl implements OrderService {
	private OrderMapper orderMapper;
	private OrderDetailMapper orderDetailMapper;
//	public List<Order> getAllOrderByUserId(Integer userid) {
//		
//		return orderDao.getAllOrderByUserId(userid);
//		
//	}


	public void setOrderMapper(OrderMapper orderMapper) {
		this.orderMapper = orderMapper;
	}

	public void setOrderDetailMapper(OrderDetailMapper orderDetailMapper) {
		this.orderDetailMapper = orderDetailMapper;
	}

	public int saveOrder(Order order) {
		return orderMapper.saveOrder(order);
	}

	public boolean updateById(int orderId, String addr, int status) {
		int count = orderMapper.updateById(orderId,addr,status);
		if(count > 0)
			return true;
		return false;
	}

	public Order getOrderById(int orderId) {
		return orderMapper.getOrderById(orderId);
	}

	public List<Order> getAllOrderByUserIdAndStatus(Integer userId, int status) {
		return orderMapper.getAllOrderByUserIdAndStatus(userId,status);
	}

	public Order getOrderByUserIdAndOderNumAndOrderStatu(Integer userId, String orderNum, int status) {
		return orderMapper.getOrderByUserIdAndOderNumAndOrderStatu(userId,orderNum,status);
	}

	/**
	 * 删除订单 事务
	 * @param orderId
	 * @param type
	 * @param userId
	 * @return
	 */
	public boolean delOrderByIdAndUserId(Integer orderId, Integer type, Integer userId) {

		//判断当前是否是管理员
		if(type == 1) {
			int count1 = orderMapper.delOrderByIdAndAdmin(orderId);
			int count2 = orderDetailMapper.delOrderDetailByOrderId(orderId);

			if(count1 > 0 && count2 > 0)
				return true;
			return false;
		}


		int count1 = orderMapper.delOrderByIdAndUserId(orderId,userId);
		int count2 = orderDetailMapper.delOrderDetailByOrderId(orderId);
		if(count1 > 0 && count2 > 0)
			return true;
		return false;
	}


	public Integer getAllOrderByUserIdAndOrderStatusCount(Integer userId, String orderStatus) {
		int status = Integer.parseInt(orderStatus);
		return  orderMapper.getAllOrderByUserIdAndOrderStatusCount(userId,status);
	}

	public List<Order> getAllOrderByUserIdAndStatus(Integer userId, String orderStatus, PagingUtil<Order> pagingInfo) {
		int status = Integer.parseInt(orderStatus);
		return  orderMapper.getAllOrderByUserIdAndOrderStatus(userId,status,pagingInfo.getStart(),pagingInfo.getRows());
	}

	public int getAllOrderCount() {
		return  orderMapper.getAllOrderCount();
	}

	public List<Order> getOrderList(PagingUtil<Order> pageOrders) {
		//获取到分页的开始，获取到分页的大小
		
		int start = pageOrders.getStart();
		int rows = pageOrders.getRows();
		
		 return orderMapper.getOrderList(start,rows);
	}

	public boolean sendOrderById(Integer status ,String orderId) {
		
		if(orderId == null || "".equals(orderId)) {
			return false;
		}
		
		int count = 0;
		count = orderMapper.sendOrderById(status,Integer.parseInt(orderId));
		
		 if(count > 0) {
			 return true;
		 }
		 
		return false;
	}

	
}
