package com.nf.easybuy.solr.service;

import com.nf.easybuy.domain.Product;
import com.nf.easybuy.utils.PagingUtil;
import org.springframework.data.solr.core.query.result.ScoredPage;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-14
 * Time: 18:47
 */
public interface ProductSolrService {
    /**
     * 通过id对商品的查询
     *
     * @param queryString
     * @return
     */
    PagingUtil<Product> getSearchProductByQuery(String queryString, int currentPage, int rows);
}
