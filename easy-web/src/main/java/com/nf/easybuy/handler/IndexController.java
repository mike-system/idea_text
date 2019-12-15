package com.nf.easybuy.handler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-10-30
 * Time: 14:30
 */
@Controller
public class IndexController {

    /**
     * 进入首页
     * @return
     */
    @RequestMapping("index.do")
    public String index(){
        return "index";
    }
}
