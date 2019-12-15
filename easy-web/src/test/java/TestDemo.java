import com.nf.easybuy.domain.Product;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.data.solr.core.SolrTemplate;
import org.springframework.data.solr.core.query.Query;
import org.springframework.data.solr.core.query.SimpleQuery;
import org.springframework.data.solr.core.query.result.ScoredPage;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-15
 * Time: 16:08
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:springmvc.xml"})
public class TestDemo {
    @Resource
    private SolrTemplate solrTemplate;
    @Test
    public void shouldAnswerWithTrue()
    {
        Query query = new SimpleQuery("*:*");
        query.setOffset(20);
        query.setRows(20);
        ScoredPage<Product> pages = solrTemplate.queryForPage( query, Product.class);
    }
}
