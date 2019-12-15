package com.nf.easybuy.exceptionHandler;

import com.nf.easybuy.editor.DateEditor;
import com.nf.easybuy.exception.AreaRuntimeException;
import com.nf.easybuy.exception.CarIsNullRuntimeException;
import com.nf.easybuy.exception.UserLoginAuthenticationException;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-11
 * Time: 21:26
 */
//@ControllerAdvice
@ControllerAdvice("com.nf.easybuy.handler")
public class SpringControllerAdvice {

    /**
     * 自定义的处理异常解析器，对整个引用程序中的异常进行处理
     * @param ex
     * @return
     */
    @ExceptionHandler(RuntimeException.class)
    public ModelAndView resolveException(Exception ex) {

        ModelAndView mv = new ModelAndView();
        mv.setViewName("/errors/error.jsp");

        //如果是地址错误，就跳转至地址错误页面
        if(ex instanceof AreaRuntimeException){
            mv.setViewName("/errors/areaError.jsp");
        }

        //用户登录认证异常
        if(ex instanceof UserLoginAuthenticationException){
            /*
             * 待解决
             * 用户未登录，清楚用户的登录认证，让用户重新登录
             */
            mv.setViewName("redirect:/userAccount/loginUI.do");
        }

        //购物车为空的异常处理
        if(ex instanceof CarIsNullRuntimeException){
            /**
             *
             */
            mv.addObject("message","购物车为空，请先添加商品在来购物车吧");
            mv.setViewName("forward:/errors/error.jsp");
        }

        return mv;
    }

    /**
     * 匹配时间类型
     * @param binder 初始化绑定参数
     */
    @InitBinder
    public void globalInitBinder(WebDataBinder binder) {
//        binder.addCustomFormatter(new DateFormatter("yyyy-MM-dd"));
        //DateEditor 自定义的日期类型转换器
        binder.registerCustomEditor(Date.class,new DateEditor());
    }

}
