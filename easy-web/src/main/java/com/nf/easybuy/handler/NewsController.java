package com.nf.easybuy.handler;
import com.nf.easybuy.domain.News;
import com.nf.easybuy.service.NewsService;
import com.nf.easybuy.utils.PagingUtil;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

@Controller
@RequestMapping("News")
public class NewsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    ApplicationContext ac = ContextLoader.getCurrentWebApplicationContext();
    //	 = ac.getBean("newsService",NewsService.class)
//    @Autowired
    private NewsService newsService = ac.getBean("newsService",NewsService.class);

    //新闻管理
    @RequestMapping("newsList.do")
    private void newsList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String currentPageStr = request.getParameter("currentPage");
        if (currentPageStr == null || "".equals(currentPageStr.trim())) {
            currentPageStr = "1";
        }
        //获取新闻的总条数
        int count = newsService.getNewsCount();
        PagingUtil<News> pageNews = new PagingUtil<>(currentPageStr);
        pageNews.setRows(5);
        pageNews.setTotal(count);
        pageNews.setData(newsService.getNewsByLimit(pageNews));
        request.setAttribute("pageNews", pageNews);
        request.getRequestDispatcher("/WEB-INF/jsp/newsList.jsp").forward(request, response);
    }

    //新闻展示
    @RequestMapping("newsShow.do")
    private ModelAndView newsShow(Integer id) {

        ModelAndView mv = new ModelAndView();

        //获取传入过来的id
        News news = newsService.getNewsById(id);
        mv.addObject("news", news);
        return new ModelAndView("newsDetail");
    }
}
