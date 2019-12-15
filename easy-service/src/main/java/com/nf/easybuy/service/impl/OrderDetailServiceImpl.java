package com.nf.easybuy.service.impl;


import com.nf.easybuy.domain.OrderDetaiShow;
import com.nf.easybuy.domain.OrderDetail;
import com.nf.easybuy.mapper.OrderDetailMapper;
import com.nf.easybuy.mapper.OrderMapper;
import com.nf.easybuy.service.OrderDetailService;

import java.util.List;

public class OrderDetailServiceImpl implements OrderDetailService {

	private OrderDetailMapper orderDetailMapper;
	private OrderMapper orderMapper;

	public void setOrderDetailMapper(OrderDetailMapper orderDetailMapper) {
		this.orderDetailMapper = orderDetailMapper;
	}

	public void setOrderMapper(OrderMapper orderMapper) {
		this.orderMapper = orderMapper;
	}

	public List<OrderDetail> getOrderDetailByOrderId(Integer orderId) {
		return orderDetailMapper.getOrderDetailByOrderId(orderId);
	}
	public int delOrderDetailByOrderId(Integer orderId) {
		return orderDetailMapper.delOrderDetailByOrderId(orderId);
	}
	
	public int saveOrderDetail(List<OrderDetail> orderDetails) {

		for (OrderDetail orderDetail : orderDetails) {
			System.out.println(orderDetail.getId());
		}

		return orderDetailMapper.saveOrderDetail(orderDetails);
	}
	public List<OrderDetaiShow> getAllOrderDetailShowByOrderId(int orderId) {
		return orderDetailMapper.getAllOrderDetailShowByOrderId(orderId);
	}

	@Override
	public void saveMergePostOrder(Integer orderId, Integer id1, List<OrderDetail> orderDetailList1, int type, Integer userId) {
		orderDetailMapper.delOrderDetailByOrderId(orderId);
		orderDetailMapper.delOrderDetailByOrderId(id1);
		orderDetailMapper.saveOrderDetail(orderDetailList1);

		//判断当前是否是管理员
		if(type == 1) {
			orderMapper.delOrderByIdAndAdmin(orderId);
			orderDetailMapper.delOrderDetailByOrderId(orderId);
		}

		orderMapper.delOrderByIdAndUserId(orderId,userId);
		orderDetailMapper.delOrderDetailByOrderId(orderId);

	}

}
