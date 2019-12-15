package com.nf.easybuy.handler;

import com.alibaba.fastjson.JSON;
import com.nf.easybuy.domain.Order;
import com.nf.easybuy.domain.Product;
import com.nf.easybuy.domain.ProductCategory;
import com.nf.easybuy.domain.User;
import com.nf.easybuy.exception.NullFileRuntimeException;
import com.nf.easybuy.service.OrderService;
import com.nf.easybuy.service.ProductCategoryService;
import com.nf.easybuy.service.ProductService;
import com.nf.easybuy.service.UserService;
import com.nf.easybuy.utils.PagingUtil;
import com.nf.easybuy.utils.WebUtilsl;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;

@Controller
@RequestMapping("Admin")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Autowired
	private OrderService orderService;
	@Autowired
	private ProductCategoryService proService;
	@Autowired
	private ProductService productService;
	@Autowired
	private UserService userService;


	//处理用户订单
	@RequestMapping("orderhandleAdmin.do")
	private void orderhandleAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String currentPageStr = request.getParameter("currentPage");
		
		if(currentPageStr == null || "".equals(currentPageStr)) {
			currentPageStr = "1";
		}
		
		int count = orderService.getAllOrderCount();
		
		//获取到用户的所有的订单
		
		//分页
//		orderService.getallorder();
		PagingUtil<Order> pageOrders = new PagingUtil<Order>(currentPageStr);
		pageOrders.setTotal(count);	
		pageOrders.setRows(5);
		pageOrders.setData(orderService.getOrderList(pageOrders));
		request.setAttribute("pageOrders", pageOrders);
		request.getRequestDispatcher("/WEB-INF/jsp/adminPage/memberOrder.jsp").forward(request, response);
		
		
	}
	
	//给用户发货
	@RequestMapping("sendOrder.do")
	private void sendOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//获取到用户的订单的的订单号
		String orderId = request.getParameter("orderId");
		if(orderId == null || "".equals(orderId)) {
			System.out.println("传入过来的参数为空");
			response.getWriter().print(1);
			return;
		}
		//获取当前用户的登录信息 查看是否是管理员账户
		User user = (User) request.getSession(false).getAttribute("user");
		
		if(user == null) {
			System.out.println("当前用户未登录，跳转到登录页面");
			//当前用户未登录
			response.getWriter().print(2);
			return;
		}
		if(user.getType() != 1) {
			//权限不足，非管理员账户
			response.getWriter().print(3);
			return;
		}
		boolean isSuccess = orderService.sendOrderById(4,orderId);
		if(isSuccess) {
			//发货成功
			response.getWriter().print(0);
			
		}else {
			response.getWriter().print(4);
		}
		
		
	}
	//商品分类管理
	@RequestMapping("productCategoryHandlerAdmin.do")
	private void productCategoryHandlerAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//从当前页面获取到当前页码
		String currentpage = request.getParameter("currentPage");
		if(currentpage == null || "".equals(currentpage)) {
			currentpage = "1";
		}
		
		//获取到数据库中的总数量
		int count = proService.getProductCategoryCcount();
		
		// 侧边栏商品展示集合
		List<ProductCategory> proList = proService.getProductCategory();
		request.setAttribute("proList", proList); 
		
		PagingUtil<ProductCategory> paging = new PagingUtil<ProductCategory>(currentpage);
		paging.setTotal(count);
		paging.setRows(10);
		paging.setData(proService.getProductCategoryLimit(paging));
		
		request.setAttribute("pagingList", paging); 
		request.getRequestDispatcher("/WEB-INF/jsp/adminPage/productCategoryList.jsp").forward(request, response);
	}
	
	//商品管理
	@RequestMapping("productHandlerAdmin.do")
	private void productHandlerAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//从页面中获取当前的页码
		String currentPage = request.getParameter("currentPage");
		if(currentPage == null || "".equals(currentPage.trim())) {
			currentPage = "1";
		}
		//遍历商品
		PagingUtil<Product> pageProduct = new PagingUtil<Product>(currentPage);
		pageProduct.setRows(5);
		pageProduct.setTotal(productService.getProductCountCount(0));
		pageProduct.setData(productService.getProductLimit(0,pageProduct));
		request.setAttribute("pageProduct", pageProduct);
		request.getRequestDispatcher("/WEB-INF/jsp/adminPage/productList.jsp").forward(request, response);
	}
	
	
	//修改分类返回三级联动数据
	@RequestMapping("productCategoryModify.do")
	private void productCategoryModify(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String parentId = request.getParameter("parentId");
		String type = request.getParameter("type");
		if(parentId == null || "".equals(parentId)) {
			System.out.println("传入过来的数据为空");
			return;
		}
		if(type == null || "".equals(type)) {
			System.out.println("传入过来的数据为空");
			return;
		}
		
		List<ProductCategory> productCategorysList = proService.getProductCategoryByTypeAndParentid(Integer.parseInt(type) + 1, Integer.parseInt(parentId));
		response.getWriter().print(JSON.toJSONString(productCategorysList));
	}
	
	//需改分类中的数据
	@RequestMapping("productCategoryModifyInfo.do")
	private void productCategoryModifyInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String typestr = request.getParameter("type");
		String idstr = request.getParameter("id");
		String inputVal = request.getParameter("inputVal");
		if(typestr == null || "".equals(typestr)) {
			System.out.println("收到的type为空");
			response.getWriter().print("获取到数据为空");
			return;
		}
		if(inputVal == null || "".equals(inputVal)) {
			System.out.println("收到的inputVal为空");
			response.getWriter().print("收到的父级分类为空");
			return;
		}
		
		int id = Integer.parseInt(idstr);
		ProductCategory pc = proService.getProductCategoryById(id);
		pc.setName(inputVal);
		boolean isSuccess = false;
		int type = Integer.parseInt(typestr);
		switch (type) {
		case 1:
			isSuccess = proService.updateProductCategoryById(pc);
			break;
		case 2:
		case 3:
			String parentId = request.getParameter("parentId");
			
			if(parentId == null || "".equals(parentId)) {
				System.out.println("收到的parentId为空");
				response.getWriter().print("收到的父级分类为空");
				return;
			}
			
			if("0".equals(parentId.trim())) {
				System.out.println("请选择父级分类");
				response.getWriter().print("请选择父级分类");
				return;
			}
			
			//对此数据验证 略
			pc.setParentId(Integer.parseInt(parentId));
			isSuccess = proService.updateProductCategoryById(pc);
			break;
		default:
			System.out.println("数据错误");
			response.getWriter().print("获取数据错误");
			break;
		}
		if(isSuccess) {
			response.getWriter().print("更新成功");
		}else {
			response.getWriter().print("更新失败");
		}
		
	}
	//添加分类
	@RequestMapping("productCategoryAddInfo.do")
	private void productCategoryAddInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String typestr = request.getParameter("type");
		String inputVal = request.getParameter("inputVal");
		
		if(typestr == null || "".equals(typestr)) {
			System.out.println("收到的type为空");
			response.getWriter().print("获取到数据为空");
			return;
		}
		if(inputVal == null || "".equals(inputVal.trim())) {
			System.out.println("收到的inputVal为空");
			response.getWriter().print("分类名为空");
			return;
		}
		
		ProductCategory pc = new ProductCategory();
		pc.setName(inputVal);
		boolean isSuccess = false;
		int type = Integer.parseInt(typestr);
		pc.setType(type);
		
		
		switch (type) {
		case 1:
			pc.setParentId(0);
			break;
		case 2:
		case 3:
			String parentId = request.getParameter("addParentId");
			
			if(parentId == null || "".equals(parentId)) {
				System.out.println("收到的parentId为空");
				response.getWriter().print("收到的父级分类为空");
				return;
			}
			
			if("0".equals(parentId.trim())) {
				System.out.println("请选择父级分类");
				response.getWriter().print("请选择父级分类");
				return;
			}
			
			//对此数据验证 略
			pc.setParentId(Integer.parseInt(parentId));
			break;
		default:
			System.out.println("数据错误");
			response.getWriter().print("获取数据错误");
			break;
		}
		isSuccess = proService.saveProductCategory(pc);
		if(isSuccess) {
			response.getWriter().print("添加成功");
		}else {
			response.getWriter().print("添加失败");
		}
		
		
	}
	//删除分类
	@RequestMapping("productCategoryDel.do")
	private void productCategoryDel(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String typestr = request.getParameter("type");
		String idstr = request.getParameter("id");
		
		if(typestr == null || "".equals(typestr)) {
			System.out.println("收到的type为空");
			response.getWriter().print("获取到数据为空");
			return;
		}
		if(idstr == null || "".equals(idstr.trim())) {
			System.out.println("收到的type为空");
			response.getWriter().print("获取到数据为空");
			return;
		}
		
		int count;
		int type = Integer.parseInt(typestr);
		int id  = Integer.parseInt(idstr);
		
		if(type == 3) {
			//查看商品的信息，
			count = productService.getProductCountByProductCategory(id,0);
		}else {
			count =  proService.getProductCategoryCcountByParentId(id);
		}
		
		if(count > 0) {
			response.getWriter().print("该分类中有子集分类h或商品，请先删除或移除后再试");
			return;
		}else {
			if(proService.delProductCatById(id)) {
				response.getWriter().print("删除成功");
				return;
			}
			response.getWriter().print("删除失败");
		}
		
		
	}
	//更新或者添加商品
	@RequestMapping("updateOrAddProduct.do")
	private void updateOrAddProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Product product = null;
		String id = request.getParameter("id");
		//获取id,如果id存在，就是修改，如果id不存在，就是添加
		if(id != null) {
			//添加商品
			product = productService.getProductById(0,Integer.parseInt(id));
		}
		request.setAttribute("product", product);
		request.getRequestDispatcher("/WEB-INF/jsp/adminPage/toAddProduct.jsp").forward(request, response);
		
	}
	
	//更新或者添加商品 处理类
	@RequestMapping("productUpdataOrAddHandler.do")
	private void productUpdataOrAddHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String id = null;
		String name = null;
		String productCategoryLevel1 = null;
		String productCategoryLevel2 = null;
		String productCategoryLevel3 = null;
		String price = null;
		String stock = null;
		String description = null;
		String picpath = null;
		String fileName = null;
		
		//判断当前请求是否是multipart请求
		if(!ServletFileUpload.isMultipartContent(request)) {
			throw new RuntimeException("当前请求不是multipart请求方法");
		}
		try {
			//创建文件上传工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setFileSizeMax(1024*1024*10);
			
			@SuppressWarnings("unchecked")
			List<FileItem> items = upload.parseRequest(request);
			for (FileItem item : items) {
				// 获取字段名
				String fieldName = item.getFieldName();
				
				if (item.isFormField()) {
					try {
						// 普通字段
						if ("id".equals(fieldName))
							id = item.getString("utf-8");
						
						if ("name".equals(fieldName))
							name = item.getString("utf-8");
						
						if ("categoryLevel1Id".equals(fieldName))
							productCategoryLevel1 = item.getString("utf-8");
						
						if ("categoryLevel2Id".equals(fieldName))
							productCategoryLevel2 = item.getString("utf-8");
						
						if ("categoryLevel3Id".equals(fieldName))
							productCategoryLevel3 = item.getString("utf-8");
						
						if ("price".equals(fieldName))
							price = item.getString("utf-8");
						
						if ("stock".equals(fieldName))
							stock = item.getString("utf-8");
						
						if ("description".equals(fieldName))
							description = item.getString("utf-8");
						
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}

				} else {
					// 获取文件名
					fileName = item.getName();
					// 获取文件输入流
					InputStream is = null;
					try {
						is = item.getInputStream();
					} catch (IOException e1) {
						e1.printStackTrace();
					}

					// 获取用户图片的所在的路径
					String path = this.getServletContext().getRealPath("/images");

					// 将图片文件名分割。获取后缀名
					String suffixName = null;
					try {
						suffixName = fileName.substring(fileName.lastIndexOf("."));
						
						
						if(!".jpg".equals(suffixName) && !".png".equals(suffixName) && !".gif".equals(suffixName)) {
							response.getWriter().write("修改失败，请上传图片格式文件,3秒后返回");
							response.setHeader("refresh", "3;url=" + request.getContextPath() + "/Admin/productHandlerAdmin.do");
							return;
						}
						
					} catch (StringIndexOutOfBoundsException e) {
						// 跳过，默认不上传文件
						continue;
					}
					fileName = System.currentTimeMillis() + suffixName;
					// 设置文件名
					File file = null;
					if ("photo".equals(fieldName)) {
						file = new File(path, fileName);
					} else {
						// 如果文件名没有赋值成功，就让这个线程停止
						throw new NullFileRuntimeException("文件名为空");
					}
					picpath = file.getPath();

					// 创建文件输出流对象
					OutputStream os = null;
					os = new FileOutputStream(file);

					int len = -1;
					byte[] buff = new byte[1024];

					while ((len = is.read(buff)) != -1) {
						os.write(buff, 0, len);
					}
					os.close();
					is.close();
				}
			}
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		
		Product product = new Product();
		product.setName(name);
		product.setCategoryLevel1Id(Integer.parseInt(productCategoryLevel1));
		product.setCategoryLevel2Id(Integer.parseInt(productCategoryLevel2));
		product.setCategoryLevel3Id(Integer.parseInt(productCategoryLevel3));
		product.setPrice(Float.parseFloat(price));
		product.setStock(Integer.parseInt(stock));
		product.setDescription(description);
		product.setFileName(fileName);
		
		
		//判断是添加还是修改
		if(id != null && !"".equals(id)) {
			
			product.setId(Integer.parseInt(id));
			//将该更新到数据库
			if(productService.updateProductById(product)) {
				response.getWriter().write("修改成功，页面3秒跳转至商品管理页面");
			}else {
				response.getWriter().write("修改失败，页面3秒跳转至商品管理页面");
			}
			response.setHeader("refresh", "3;url=" + request.getContextPath() + "/Admin/productHandlerAdmin.do");
			return;
		}
		
		//添加
		if(productService.addProduct(product)) {
			response.getWriter().write("添加成功，页面3秒跳转至商品管理页面");
		}else {
			response.getWriter().write("添加失败，页面3秒跳转至商品管理页面");
		}
		response.setHeader("refresh", "3;url=" + request.getContextPath() + "/Admin/productHandlerAdmin.do");
		return;
	}
	
	//删除商品
	@RequestMapping("productDel.do")
	private void productDel(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		
		if(id == null || "".equals(id.trim())) {
			response.getWriter().print("获取到的数据失败，删除失败");
			return;
		}
		
		if(productService.update2delProductById(Integer.parseInt(id),1)) {
			response.getWriter().print("删除成功");
			return;
		}
		response.getWriter().print("删除失败");
	}

	//显示用户，用户管理
	@RequestMapping("userList.do")
/*	@RequiresPermissions("user:create")*/
	private void userList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//从页面中获取当前的页码
		String currentPage = request.getParameter("currentPage");
		if(currentPage == null || "".equals(currentPage.trim())) {
			currentPage = "1";
		}
		//遍历用户
		PagingUtil<User> pageUser = new PagingUtil<User>(currentPage);
		pageUser.setRows(5);
		pageUser.setTotal(userService.getUserCount());
		pageUser.setData(userService.getUsertLimit(pageUser));
		request.setAttribute("pageUser", pageUser);
		request.getRequestDispatcher("/WEB-INF/jsp/adminPage/userList.jsp").forward(request, response);
	}
	//修改用户，更新或添加用户
	@RequestMapping("updateUserOrAdd.do")
	private void updateUserOrAdd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = null;
		String id = request.getParameter("id");
		//判断id是否为空，如果为空，就添加用户，如果非空，就修改用户
		if(id != null) {
			//通过id获取到用户的信息
			user = userService.getUserById(Integer.parseInt(id));
		}
		
		if(user == null) {
			user = new User();
		}
		
		request.setAttribute("user", user);
		request.getRequestDispatcher("/WEB-INF/jsp/adminPage/toUpdateUser.jsp").forward(request, response);
	}
	//修改用户，更新或添加用户 处理
	@RequestMapping("updateUserOrAddHandler.do")
	private void updateUserOrAddHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = new User();
		String id = request.getParameter("userId");
		String loginName = request.getParameter("loginname");
		String userName = request.getParameter("userName");
		
		String identityCode = request.getParameter("identityCode");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String type = request.getParameter("type");
		
		if(type==null) {
			response.getWriter().print("获取数据失败");
			//抛出错误
			return;
		}
		
		user.setLoginName(loginName);
		user.setUserName(userName);
		
		user.setIdentityCode(identityCode);
		user.setEmail(email);
		user.setMobile(mobile);
		user.setType(Integer.parseInt(type));
		
		
		boolean isSuccess;
		
		//判断该id是否为空，如果是空，就是添加方法
		if(id == null || "".equals(id.trim())) {
			String password = request.getParameter("password");
			user.setPassword(WebUtilsl.str2me5(password));
			//添加
			isSuccess = userService.saveByAdmin(user);
		} else {
			user.setId(Integer.parseInt(id));
			isSuccess = userService.updateByAdmin(user);
		}
		
		if(isSuccess) {
			response.getWriter().print("操作成功");
			return;
		}else {
			response.getWriter().print("操作失败");
			return;
		}
		
	}
	//删除用户
	@RequestMapping("delUser.do")
	private void delUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		//获取用户的id
		if(id == null || "".equals(id.trim())) {
			response.getWriter().print("更新失败，获取用户信息失败");
			return;
		}
		
		//从session中获取到用户
		//String[] valueNames = request.getSession(false).ge
		
		boolean isSuccess = userService.delUserByid(Integer.parseInt(id));
		if(isSuccess) {
			response.getWriter().print("删除成功");
			return;
		}else {
			response.getWriter().print("操作失败");
			return;
		}
	}
	
	//判断分类管理中的名是否存在
	@RequestMapping("checkeProductCategoryName.do")
	private void checkeProductCategoryName(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String val = request.getParameter("val");
		//通过该字段在数据库中查找，判断该分类是否已经存在，如果存在，不让其添加
		boolean result = proService.getProductCategoryByName(val);
		
		if(!result) {
			response.getWriter().print(true);
		}else {
			response.getWriter().print(false);
		}
		
	}
}
