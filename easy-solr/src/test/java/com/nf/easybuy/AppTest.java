package com.nf.easybuy;

import com.nf.easybuy.domain.Product;
import com.nf.easybuy.solr.dao.impl.ProductDaoImpl;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.solr.core.SolrTemplate;
import org.springframework.data.solr.core.query.Query;
import org.springframework.data.solr.core.query.SimpleQuery;
import org.springframework.data.solr.core.query.result.ScoredPage;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


/**
 * Unit test for simple App.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/applicationContext-solr.xml"})
public class AppTest {
    @Autowired
    private SolrTemplate solrTemplate;

    @Test
    public void shouldAnswerWithTrue() {
        Query query = new SimpleQuery("*:*");
        query.setOffset(10);
        query.setRows(20);
        ScoredPage<Product> pages = solrTemplate.queryForPage(query, Product.class);
        for (Product product : pages.getContent()) {
            System.out.println(product.getName() + "...." + product.getId() + "..." + product.getCategoryLevel3Id());
        }
        System.out.println(".........................." + pages.getTotalElements());
    }

    public void searchTest(){
        Query query = new SimpleQuery("*:*");
        query.setOffset(10);
        query.setRows(20);
       /* query.
        ScoredPage<Product> pages = solrTemplate.queryForPage(query, Product.class);
        for (Product product : pages.getContent()) {
            System.out.println(product.getName() + "...." + product.getId() + "..." + product.getCategoryLevel3Id());
        }
        System.out.println(".........................." + pages.getTotalElements());*/
    }


    @Test
    public void test02(){
        ProductDaoImpl productDao = new ProductDaoImpl();
        productDao.setSolrTemplate(solrTemplate);
        ScoredPage<Product> products = productDao.selectProductByQuery("手机香水", 0, 5);

        System.out.println(products.getTotalElements());
        System.out.println(products.getTotalPages());
        for (Product product : products) {

            System.out.println(product.getName());

        }
    }

}
