package com.nf.easybuy.solr.dao.impl;


import com.nf.easybuy.domain.Product;
import com.nf.easybuy.solr.dao.ProductDao;
import org.apache.solr.client.solrj.response.UpdateResponse;
import org.springframework.data.solr.core.SolrTemplate;
import org.springframework.data.solr.core.query.Criteria;
import org.springframework.data.solr.core.query.Query;
import org.springframework.data.solr.core.query.SimpleQuery;
import org.springframework.data.solr.core.query.result.ScoredPage;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-13
 * Time: 23:47
 */
public class ProductDaoImpl implements ProductDao {

    private SolrTemplate solrTemplate;

    public void setSolrTemplate(SolrTemplate solrTemplate) {
        this.solrTemplate = solrTemplate;
    }

    @Override
    public int insertProduct(Product product) {
        try {
            UpdateResponse response = solrTemplate.saveBean(product);

            solrTemplate.commit();
            return 1;
        } catch (Exception e) {
            solrTemplate.rollback();
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public ScoredPage<Product> selectProductInfo(){
        Query query = new SimpleQuery("*:*");
        ScoredPage<Product> pages = solrTemplate.queryForPage(query, Product.class);
        return pages;
    }


    @Override
    public ScoredPage<Product> selectProductByQuery(String queryString, long start, int rows) {

        Query query = new SimpleQuery("*:*");

        Criteria criteria = new Criteria("product_keywords").is(queryString);
//        criteria = criteria.and("item_brand").is("");
        query.addCriteria(criteria);
        //开始页
        query.setOffset((int) start);
        //每一页的条数
        query.setRows(rows);

        ScoredPage<Product> pages = solrTemplate.queryForPage(query, Product.class);
        return pages;
    }

    @Override
    public int deleteProductById(Integer id) {
        return 0;
    }

    @Override
    public int updateProductById(Integer id) {
        return 0;
    }
}
