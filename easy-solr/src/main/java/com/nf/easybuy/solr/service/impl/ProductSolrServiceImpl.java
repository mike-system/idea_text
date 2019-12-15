package com.nf.easybuy.solr.service.impl;

import com.nf.easybuy.domain.Product;
import com.nf.easybuy.exception.PageRuntimeException;
import com.nf.easybuy.solr.dao.ProductDao;
import com.nf.easybuy.solr.service.ProductSolrService;
import com.nf.easybuy.utils.PagingUtil;
import org.springframework.data.solr.core.query.result.ScoredPage;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-14
 * Time: 18:49
 */
public class ProductSolrServiceImpl implements ProductSolrService {
    private ProductDao productDao;

    public void setProductDao(ProductDao productDao) {
        this.productDao = productDao;
    }

    /**
     * 通过查询词汇搜索
     * @param queryString
     * @return
     */
    @Override
    public PagingUtil<Product> getSearchProductByQuery(String queryString, int currentPage, int rows)  {

        ScoredPage<Product> infoPage = productDao.selectProductByQuery(queryString, 0, rows);

        //获取到当前的总页数，和总条数
        //获取到总页数
        int totalPages = infoPage.getTotalPages();
        //总记录数
        long totalElements = infoPage.getTotalElements();

        if(totalPages < 0){
            //抛出异常
            throw new PageRuntimeException("系统页码异常");
        }

        if(currentPage < 0 || currentPage > totalElements / totalPages){
            throw new PageRuntimeException("传入页码异常");
        }


        PagingUtil<Product> productListBySeek  = new PagingUtil<>(currentPage+"");
        productListBySeek.setTotal((int)totalElements);
        productListBySeek.setRows(5);

        ScoredPage<Product> scoredPage = productDao.selectProductByQuery(queryString, productListBySeek.getStart(), rows);
        productListBySeek.setData(scoredPage.getContent());


        return productListBySeek;
    }
}
