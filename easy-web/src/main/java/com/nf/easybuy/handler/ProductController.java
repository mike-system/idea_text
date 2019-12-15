package com.nf.easybuy.handler;


import com.nf.easybuy.domain.Product;
import com.nf.easybuy.service.ProductService;
import com.nf.easybuy.solr.service.ProductSolrService;
import com.nf.easybuy.utils.PagingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("Product")
public class ProductController extends HttpServlet {

	public ProductController() {
		super();
	}

	@Autowired
	private ProductService producService;
	@Autowired
	private ProductSolrService productSolrService;


	// 跳转至展示商品
	@RequestMapping("showProduct.do")
	private void showProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 获取到商品的id
		String id = request.getParameter("id");
		if (id == null || "".equals(id)) {
			return;
		}
		Product product = producService.getProductById(0,Integer.parseInt(id));
		request.setAttribute("product", product);
		request.getRequestDispatcher("/WEB-INF/jsp/memberProduct.jsp").forward(request, response);
		return;
	}

	// 列出商品
	@RequestMapping("showListProductByCategoryLevel3Id.do")
	private void showListProductByCategoryLevel3Id(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String categoryLevel3Id = request.getParameter("id");
		//在数据库中查找，带着分页信息过去
		//获取当前页面的页码
		String currentPage = request.getParameter("currentPage");
		if (categoryLevel3Id == null || "".equals(categoryLevel3Id)) {
			return;
		}
		if(currentPage == null || "".equals(currentPage)) {
			currentPage = "1";
		}
		//总条数
		int count = producService.getProductsByCategoryLevel3IdCount(0,Integer.parseInt(categoryLevel3Id));
		PagingUtil<Product> pagingInfo = new PagingUtil<>(currentPage);
		pagingInfo.setTotal(count); // 将总体数据量放入到工具中
		pagingInfo.setRows(3); //设置页面展示的商品的数量
		
		pagingInfo.setData(producService.getProductsByCategoryLevel3Id(0,Integer.parseInt(categoryLevel3Id),pagingInfo));
		//将页面保存在request域中
		request.setAttribute("pagingInfo", pagingInfo);
		
		String url = request.getRequestURI();
		request.setAttribute("url", url);
		
		request.getRequestDispatcher("/WEB-INF/jsp/categoryList.jsp").forward(request, response);
		
		/*
		 * // 通过id,在数据库查找数据 List<Product> products =
		 * producService.getProductsByCategoryLevel3Id(Integer.parseInt(categoryLevel3Id
		 * )); request.setAttribute("products", products);
		 * request.getRequestDispatcher("/WEB-INF/jsp/categoryList.jsp").forward(
		 * request, response);
		 */
		
		return;
	}
	
	// 列出商品
	@RequestMapping("showListProductByCategoryLevel1Id.do")
	private void showListProductByCategoryLevel1Id(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//分页
		String categoryLevel1Id = request.getParameter("id");
		//在数据库中查找，带着分页信息过去
		//获取当前页面的页码
		String currentPage = request.getParameter("currentPage");
		
		if(currentPage == null || "".equals(currentPage)) {
			currentPage = "1";
		}
		
		//获取当前数据的总条数
		if(categoryLevel1Id == null || "".equals(categoryLevel1Id)) {
			System.out.println("返回值为空");
			return;
		}
		
		String url = request.getRequestURI();
		request.setAttribute("url", url);
		
		//总条数
		int count = producService.getProductsByCategoryLevel1IdCount(0,Integer.parseInt(categoryLevel1Id));
		PagingUtil<Product> pagingInfo = new PagingUtil<>(currentPage);
		pagingInfo.setTotal(count);
		pagingInfo.setRows(3);
		pagingInfo.setData(producService.getProductsByCategoryLevel1Id(0,Integer.parseInt(categoryLevel1Id),pagingInfo));
		//将页面保存在request域中
		request.setAttribute("pagingInfo", pagingInfo);
		request.getRequestDispatcher("/WEB-INF/jsp/categoryList.jsp").forward(request, response);
	}
	
	
	// 搜索商品
//	@RequestMapping("seekProductList.do")
	private ModelAndView seekProductList(@RequestParam("ipt") String val, HttpServletRequest request) {

		String currentPageStr = request.getParameter("currentPage");

		ModelAndView mv = new ModelAndView("categoryList");

		if(currentPageStr == null || "".equals(currentPageStr.trim())) {
			currentPageStr = "1";
		}
		
		//获取该条搜索的总数量
		int count = producService.getProductListBySeekCount(val);
		//分页
		PagingUtil<Product> productListBySeek  = new PagingUtil<>(currentPageStr);
		productListBySeek.setRows(5);
		productListBySeek.setTotal(count);
		productListBySeek.setData(producService.getProductListBySeek(val,productListBySeek));
		//将页面保存在request域中
		mv.addObject("pagingInfo", productListBySeek);
		String url = request.getRequestURI();
		mv.addObject("url", url);

		return mv;
	}

	/**
	 * 查询商品
	 * @param val
	 * @return
	 */
	@RequestMapping("seekProductList.do")
	private ModelAndView searchProduct(@RequestParam("ipt") String val, HttpServletRequest request, Model model){

		String url = request.getRequestURI();

		String currentPageStr = request.getParameter("currentPage");

		ModelAndView mv = new ModelAndView("categoryList");

		if(currentPageStr == null || "".equals(currentPageStr.trim())) {
			currentPageStr = "1";
		}



		PagingUtil<Product> searchProductByQuery = productSolrService.getSearchProductByQuery(val, Integer.parseInt(currentPageStr), 5);

		mv.addObject("pagingInfo",searchProductByQuery);
		mv.addObject("queryString",val);
		mv.addObject("url", url);
		return mv;
	}


}
