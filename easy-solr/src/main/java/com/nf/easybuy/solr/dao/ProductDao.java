package com.nf.easybuy.solr.dao;

import com.nf.easybuy.domain.Product;
import org.springframework.data.solr.core.query.result.ScoredPage;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * Description: solr获取索引商品
 * User: nongfu 农夫
 * Date: 2019-11-13
 * Time: 22:16
 */
public interface ProductDao {

    /**
     * 添加商品
     * @param product
     * @return
     */
    int insertProduct(Product product);

    /**
     * 通过名称获取到商品
     * @param queryString 查询字符串
     * @return
     */
    public ScoredPage<Product> selectProductByQuery(String queryString, long start, int rows);

    /**
     * 通过id删除商品
     * @param id
     * @return
     */
    int deleteProductById(Integer id);

    /**
     * 获取总体信息
     * @return
     */
    ScoredPage<Product> selectProductInfo();

    /**
     * 通过id进行商品的修改
     * @param id
     * @return
     */
    int updateProductById(Integer id);


}
