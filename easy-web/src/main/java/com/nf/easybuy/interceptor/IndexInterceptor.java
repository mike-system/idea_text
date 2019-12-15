package com.nf.easybuy.interceptor;

import com.nf.easybuy.domain.News;
import com.nf.easybuy.domain.Product;
import com.nf.easybuy.service.impl.NewsServiceImpl;
import com.nf.easybuy.service.impl.ProductServiceImpl;
import com.nf.easybuy.utils.PagingUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-07
 * Time: 13:22
 */
public class IndexInterceptor implements HandlerInterceptor {
    private NewsServiceImpl newsService;
    private ProductServiceImpl productService;
    private PagingUtil<News> pageNews;

    public void setNewsService(NewsServiceImpl newsService) {
        this.newsService = newsService;
    }

    public void setProductService(ProductServiceImpl productService) {
        this.productService = productService;
    }

    public void setPageNews(PagingUtil<News> pageNews) {
        this.pageNews = pageNews;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //新闻集合
//        PagingUtil<News> pageNews = new PagingUtil<>("1");
        pageNews.setRows(5);
        pageNews.setData(newsService.getNewsByLimit(pageNews));
        request.setAttribute("pageNews", pageNews);

        //商品信息

        List<Product> products = productService.getProducts(0);
        //将所有的三级菜单遍历出来，传入到首页

        request.setAttribute("products", products);
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
