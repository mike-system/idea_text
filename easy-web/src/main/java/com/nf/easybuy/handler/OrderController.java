package com.nf.easybuy.handler;


import com.alibaba.fastjson.JSON;
import com.nf.easybuy.domain.*;
import com.nf.easybuy.exception.CarIsNullRuntimeException;
import com.nf.easybuy.exception.DatabaseDataRuntimeException;
import com.nf.easybuy.exception.IllegalUserRuntimeException;
import com.nf.easybuy.exception.NotFindOrderRuntimeException;
import com.nf.easybuy.service.AddressService;
import com.nf.easybuy.service.OrderDetailService;
import com.nf.easybuy.service.OrderService;
import com.nf.easybuy.service.ProductService;
import com.nf.easybuy.service.impl.OrderServiceImpl;
import com.nf.easybuy.utils.OrderStatus;
import com.nf.easybuy.utils.PagingUtil;
import com.nf.easybuy.utils.UUIDForId;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.DatabaseMetaData;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("Order")
public class OrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Autowired
	private AddressService addressService;
	//找到订单service
	@Autowired
	private OrderService orderService;
	@Autowired
	private ProductService productService;
	@Autowired
	private OrderDetailService orderDetailService;
	Logger logger = Logger.getLogger(OrderController.class);
  
	 //处理我的订单
	@RequestMapping("memberOrder.do")  //请求跳转至memberOrder页面
	private void memberOrder(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		//从session域中获取到当前用户的id
		User user = (User) request.getSession().getAttribute("user");
		
		//获取到当前页面
		String currentPageStr = request.getParameter("currentPage");
		
		if(currentPageStr == null || "".equals(currentPageStr)) {
			currentPageStr = "1";
		}
		
		//获取到当前页面返回来的订单类型  0 ， 2， 4  ， 8  8代表全部
		String orderStatus = request.getParameter("orderStatus");
		if(orderStatus == null || "".equals(orderStatus)) {
			orderStatus = "8";
		}
		
		//通过当前用户的id,获取订单表中的所有的订单
		Integer userId = user.getId();
		if(userId == null) {
			//跳转到登录页面
			response.getWriter().write("您似乎未登录！3秒内跳转登录页面");
			response.setHeader("refresh", "3;url=" + request.getContextPath() + "/userAccount/loginUI.do");
			return;
		}
		
//		List<Order> orderListAll = orderService.getAllOrderByUserId (userId);
		
		Integer count = orderService.getAllOrderByUserIdAndOrderStatusCount (userId,orderStatus);
		List<Order> orderListByStatus = orderService.getAllOrderByUserIdAndStatus (userId, OrderStatus.ACCOUNTED.getValue());
		PagingUtil<Order> pagingInfo = new PagingUtil<Order>(currentPageStr);
		pagingInfo.setRows(5);
		pagingInfo.setTotal(count);
		pagingInfo.setData(orderService.getAllOrderByUserIdAndStatus(userId,orderStatus,pagingInfo));
		
		//判断当前请求是否是Ajax请求 ，如果是，就传入
		if("XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"))) {
			response.getWriter().print(JSON.toJSON(pagingInfo));
			return;
		}else {
			request.setAttribute("pagingInfoOrderList", pagingInfo);
			request.setAttribute("orderListByStatus", orderListByStatus);
			request.getRequestDispatcher("/WEB-INF/jsp/memberOrder.jsp").forward(request, response);
		}
	}
	
	//删除订单
	@RequestMapping("delOrder.do")  //请求跳转至memberOrder页面
	private void delOrder(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		//获取用户传入过来的订单id,
		String orderId = request.getParameter("orderId");
		if(orderId == null || "".equals(orderId.trim())) {
			//用户传入过来的数据有误。取消失败
			response.getWriter().print(false);
			return;
		}
		
		//从session域中获取到当前用户的id
		User user = (User) request.getSession().getAttribute("user");
		//通过当前用户的id,获取订单表中的所有的订单
		Integer userId = user.getId();
		if(userId == null) {
			//跳转到登录页面
			response.getWriter().write("您似乎未登录！3秒内跳转登录页面");
			response.setHeader("refresh", "3;url=" + request.getContextPath() + "/userAccount/loginUI.do");
			return;
		}
		
		//获取当前用户是否是管理员用户
		int type = user.getType();
		
		
		//找到订单service
		boolean result = orderService.delOrderByIdAndUserId(Integer.parseInt(orderId),type,userId);
		response.getWriter().print(result);
		return;
		
	}

	// 结算购物车 步骤2  处理订单 注意：本次修改需要修改订单状态表，。。。。。
	@RequestMapping("settleAccountsTwo.do")
	private String settleAccountsTwo(HttpSession session, Model model)
			throws ServletException, IOException {
		
		List<Car> cars = (List<Car>) session.getAttribute("cars");
		
		//判断集合是否为空，如果为空，如果没有登录，就跳转至首页
		if(cars == null) {
			/**
			 * 抛出异常，购物车为空
			 */
			logger.error("购物车为空");
			throw new CarIsNullRuntimeException("购物车为空");


			/*response.getWriter().write("未获取到购物车订单，3秒内跳转至首页");
			response.setHeader("refresh", "3;url=" + request.getContextPath() + "/index.do");
			return;*/
		}
		
		float money = 0;
		
		for (Car car : cars) {
			
			Integer id = car.getId();
			//通过id获取商品
			Product product = null;
			if(id != null) {
				product = productService.getProductById(0,id);
			} 
			
			if(product == null) {
				//非法用户操作   账户不安全  强制用户退出登录 退回首页
				session.invalidate();
				throw new IllegalUserRuntimeException("非法用户异常");

			}
			
			car.setPrice(product.getPrice());
			money += (product.getPrice() * car.getQuantity());
			//为了提高安全性
			//获取商品id; 从数据库中获取商品的价格 /并做数据验证
		}
		
		//获取当前用户的id
		User user = (User) session.getAttribute("user");
		List<Address> addrs = addressService.getAddressByUserId(user.getId());
		
		//保存订单
		Order order = new Order();
		order.setUserid(user.getId());
		order.setLoginname(user.getLoginName());
		order.setCreateTime(new Date());
		order.setCost(money);
		order.setSerialNumber(UUIDForId.getUUID());
		order.setStatus(OrderStatus.SUBMITTED.getValue());  //已提交
		
		orderService.saveOrder(order);
		int currentOrderId = order.getId();
		List<OrderDetail> orderDetailList = new ArrayList<OrderDetail>();

		for (Car car : cars) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrderid(currentOrderId);
			orderDetail.setProductid(car.getId());
			orderDetail.setQuantity(car.getQuantity());
			orderDetail.setCost(car.getSubtotal());
			orderDetailList.add(orderDetail);
			//保存数据
		}
		
		orderDetailService.saveOrderDetail(orderDetailList);
		model.addAttribute("money", money);  //总价格
		model.addAttribute("cars", cars);	// 购物车
		model.addAttribute("addrs", addrs);
		model.addAttribute("user", user);

		logger.info("currentOrderId :" + currentOrderId);

		session.setAttribute("orderID", currentOrderId);
		return "BuyCarTwo";
	}


	/**
	 * 结算购物车 步骤3  处理订单 注意：本次修改需要修改订单状态表，。。。。。
	 *
	 * @param remark
	 * @param addr
	 * @param flag
	 * @param session
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping("settleAccountsThree.do")
	private ModelAndView settleAccountsThree(String remark, String addr, boolean flag, HttpSession session)
			throws ServletException, IOException {
		ModelAndView mv = new ModelAndView();
//		boolean flag = true;
		User user = (User) session.getAttribute("user");
		if(remark == null || "".equals(remark.trim()) || addr == null || "".equals(addr.trim())) {
//			response.getWriter().print(false);
			logger.error("获取到的数据为空");
		}
		if(flag) {  //true  需要创建新的地址
			Address addrObj = new Address();
			addrObj.setAddress(addr);
			addrObj.setCreateTime(new Date());
			addrObj.setRemark(remark);
			addrObj.setUserid(user.getId());
			addressService.add(addrObj, user.getId());
		}

		Object orderIdstr = session.getAttribute("orderID");
		logger.info("订单id : " + orderIdstr);
		session.removeAttribute("orderID");
		if(orderIdstr == null) {
//			response.getWriter().print(false);
			logger.info("orderldstr == null");
		}
		int orderId = (int) orderIdstr;	
		
		boolean isSuccess = orderService.updateById(orderId,addr,OrderStatus.ACCOUNTED.getValue());  // 2 订状态 已付款
		
		//根据订单id，查询到订单信息
		Order order = orderService.getOrderById(orderId);
		mv.addObject("order", order);
		if(isSuccess){
			logger.info("BuyCaThree，成功");
			mv.setViewName("BuyCaThree");
		} else{
			logger.error("BuyCaThree，失败");
			throw new RuntimeException("BuyCaThree，失败");
		}

		return mv;
	}
	
	//合并订单
	@RequestMapping("mergeOrder.do")
	@ResponseBody
	private String mergeOrder(String val1,String val2,HttpSession session)
			throws ServletException, IOException {
		//合并订单
		
		//获取到订单号，然后判断该订单号是否存在//并且判断该订单号是否属于该用户  并且判断订单状态是否为 2 ACCOUNTED(2),
 		User user = (User) session.getAttribute("user");
		
		//获取该用户的id
		Integer userId = user.getId();
		
		//1 是主 2 是次 
		OrderService orderService  = new OrderServiceImpl();
		Order order1 = orderService.getOrderByUserIdAndOderNumAndOrderStatu(userId,val1,OrderStatus.ACCOUNTED.getValue());
		Order order2 = orderService.getOrderByUserIdAndOderNumAndOrderStatu(userId,val2,OrderStatus.ACCOUNTED.getValue());
		
		if(order1 == null || order2 == null ) {
			//抛出异常  //停止当前操作
			throw new NotFindOrderRuntimeException("当前订单不在数据库中");
		}
		
		if(val1.equals(val2)) {
			//所选中的两个订单相同，
			logger.info("所选中的两个订单相同");

			return "所选中的两个订单不能相同";
		}
		//获取到订单id
		Integer id1 = order1.getId();
		Integer id2 = order2.getId();
		
		//获取到订单2和订单1中的全部信息  easybuy_order_detail
		
		List<OrderDetail> orderDetailList1 = orderDetailService.getOrderDetailByOrderId(id1);
		List<OrderDetail> orderDetailList2 = orderDetailService.getOrderDetailByOrderId(id2);
		
		
		//如果两个数据都是0 ，数据库数据错误
		if(orderDetailList1.size() == 0 || orderDetailList2.size() == 0) {
			//停止当前操作
			logger.error("数据库数据出错");
			throw new DatabaseDataRuntimeException("数据库数据错误");
		}
		
		boolean flag = false;  //标记该商品在主订单中是否存在
		//合并
		for (Iterator<OrderDetail> iterator = orderDetailList2.iterator(); iterator.hasNext();) {
			OrderDetail orderDetail2 = iterator.next();
			
			//判断有没有相同的商品id，如果有，级合并，没有就添加
			int productId2 = orderDetail2.getProductid();
			for (Iterator<OrderDetail> iterator1 = orderDetailList1.iterator(); iterator1.hasNext();) {
				OrderDetail orderDetail1 = iterator1.next();
				int productId1 = orderDetail1.getProductid();
				if(productId1 == productId2) {
					orderDetail1.setQuantity(orderDetail1.getQuantity() + orderDetail2.getQuantity());
					orderDetail1.setCost(orderDetail1.getCost() + orderDetail2.getCost());
					flag = true;
				}
			}
			if(!flag) {
				orderDetailList1.add(orderDetail2);
			}
		}
		
		//保存合并后的订单，以下应为同一个事务
		orderDetailService.saveMergePostOrder(id2,id1,orderDetailList1,user.getType(), userId);

/*		orderDetailService.delOrderDetailByOrderId(id2);
		orderDetailService.delOrderDetailByOrderId(id1);
		orderDetailService.saveOrderDetail(orderDetailList1);*/
		//合并订单 //删除订单2 ，修改订单1
//		orderService.delOrderByIdAndUserId(id2,user.getType(), userId); //删除订单2
		return "操作成功";
	}
	
	// 展示订单的象姓信息
	@RequestMapping("orderShow.do")
	private void orderShow(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取到订单的id
		String idsStr = request.getParameter("orderId");
		
		//判断id是否正确
		if(idsStr == null || "".equals(idsStr)) {
			System.out.println("传入的id为空");
			return;
		}
		
		int orderId = Integer.parseInt(idsStr);
		
		List<OrderDetaiShow> listOrderDetailShow = orderDetailService.getAllOrderDetailShowByOrderId(orderId);
		request.setAttribute("listOrderDetailShow", listOrderDetailShow);
		request.getRequestDispatcher("/WEB-INF/jsp/adminPage/orderDetailList.jsp").forward(request, response);
	}
	
}
