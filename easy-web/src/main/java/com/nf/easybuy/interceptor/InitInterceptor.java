package com.nf.easybuy.interceptor;


import com.nf.easybuy.domain.ProductCategory;
import com.nf.easybuy.service.ProductCategoryService;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-10-30
 * Time: 13:21
 */
public class InitInterceptor implements HandlerInterceptor {
    /**
     * 在访问首页的时候，就将页面中所需要的数据从数据库中加载过来
     */
    private ProductCategoryService productCategoryService;

    public void setProductCategoryService(ProductCategoryService productCategoryService) {
        this.productCategoryService = productCategoryService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 侧边栏商品展示集合 商品分裂展示集合
        //遍历商品
        List<ProductCategory> proList = productCategoryService.getProductCategory();
        request.setAttribute("proList", proList);
        return true;
    }


    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
