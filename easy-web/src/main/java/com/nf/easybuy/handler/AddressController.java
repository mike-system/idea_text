package com.nf.easybuy.handler;


import com.alibaba.fastjson.JSON;
import com.nf.easybuy.domain.Address;
import com.nf.easybuy.domain.Area;
import com.nf.easybuy.domain.User;
import com.nf.easybuy.exception.AreaRuntimeException;
import com.nf.easybuy.exception.TypeMatchingException;
import com.nf.easybuy.exception.UserLoginAuthenticationException;
import com.nf.easybuy.service.AddressService;
import com.nf.easybuy.service.UserService;
import org.apache.log4j.Logger;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.web.session.HttpServletSession;
import org.springframework.beans.TypeMismatchException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.List;

@Controller
@RequestMapping("Address")
public class AddressController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * 定义类型转换异常处理器  AddressController类生效
     *
     * @param request
     * @param ex      异常
     * @return
     */
    @ExceptionHandler(TypeMismatchException.class)
    public ModelAndView exceptionHandler(HttpServletRequest request, Exception ex) {
        ModelAndView mv = new ModelAndView();
        //打印异常
        ex.printStackTrace();
//        抛出异常
        throw new TypeMatchingException("传入过来的参数和匹配相对应的类型失败");
    }

    @Autowired
    private AddressService addrService;

    @Autowired
    private UserService userService;
    //日志
    private Logger logger = Logger.getLogger(this.getClass());

    //地址页面
    @RequestMapping("memberAddress.do")
    private String memberAddress(HttpSession session, Model model) {

        /**
         * 在数据库中查找到用户的住址数据
         */

        if (session == null) {
            logger.error("session为空");
            throw new UserLoginAuthenticationException("用户认证失败");
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {  //用户未登录
            //跳转到登录页面
            logger.error("用户未登录");
            throw new UserLoginAuthenticationException("用户认证失败");
        }

        List<Address> addrList = addrService.getAddressByUserId(user.getId());
        model.addAttribute("addrList", addrList);
        return "memberAddress";
    }

    /**
     * 通过id获取地址
     *
     * @param session
     * @param id
     * @return
     * @throws ServletException
     * @throws IOException
     */
    @RequestMapping("getAddressById.do")
    @ResponseBody
    private String getAddressById(HttpSession session, Integer id) throws ServletException, IOException {

        if (session == null) {
            logger.error("用户未登录");
            throw new UserLoginAuthenticationException("用户认证失败");
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {  //用户未登录
            //跳转到登录页面
            logger.error("用户未登录");
            return "redirect:/userAccount/loginUI.do";
        }

        if (id == null) {
            logger.error("id为空，失败，重试");
            return "forward:/User/memberAddress.do";
        }

        Address address = addrService.getAddressById(id);

        return JSON.toJSONString(address);
    }

    //省市联动效果
    @RequestMapping("getAreaByParentId.do")
    @ResponseBody
    private String getAreaByParentId(Integer parentId) throws ServletException, IOException {

        if (parentId == null) {
            //让程序在该出抛出异常
            throw new AreaRuntimeException("获取到的父级省为空");

          /*  out.write("失败，重试");
            return "redirect:/User/memberAddress.do";*/
        }
        List<Area> areaList = addrService.getAreaByParentId(parentId);
        return JSON.toJSONString(areaList);
    }

    //省市联动效果
    @RequestMapping("checkAddr.do")
    @ResponseBody
    private String checkAddr(String addrc) throws ServletException, IOException {

        if (addrc == null || "".equals(addrc.trim())) {
            return "false";
        }
        if (addrc.contains("-")) {
            return "false";
        }
        return "true";
    }

    //添加地址
    @RequestMapping(value = "addAddress.do", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    private String addAddress(String province, String city, String area, String address, String remark, String username, String email, String mobile, HttpServletSession session) {

        if (province != null || city != null || area != null) {
            province = addrService.getAreaNameById(province);
            city = addrService.getAreaNameById(city);
            area = addrService.getAreaNameById(area);
        }

        /**
         * 获取的session为空
         */
        if (session == null) {
            //抛出系统异常 用户为登录，跳转至首页 调用shiro的用户认证失败异常
            throw new UserLoginAuthenticationException("用户认证失败");
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {  //用户未登录
            //抛出系统异常 用户为登录，跳转至首页 调用shiro的用户认证失败异常
            throw new UserLoginAuthenticationException("用户认证失败");
        }

        user.setUserName(username);
        user.setEmail(email);
        user.setMobile(mobile);

        //创建一个地址对象
        Address addr = new Address();
        //检测address是否含有- 如果有，则视为含有非法字符，跳转出
        if (address.contains("-")) {
            return "用户地址中存在非法字符-,请重新填写正确的地址";
//            response.setHeader("refresh", "3;url=" + request.getContextPath() + "/Address/memberAddress.do");
        }
        String addressEnd = province + "-" + city + "-" + area + "-" + address;
        addr.setAddress(addressEnd);
        if (remark != null || "".equals(remark))
            addr.setRemark(remark);
        boolean successUser = userService.update(user);
        boolean successAddr = addrService.add(addr, user.getId());

        if (successUser && successAddr) {
            return "添加成功";
//            response.setHeader("refresh", "1;url=" + request.getContextPath() + "/Address/memberAddress.do");
        }
        return "添加失败";
//        response.setHeader("refresh", "3;url=" + request.getContextPath() + "/Address/memberAddress.do");
    }

    //修改地址
    @RequestMapping("updateAddress.do")
    private String updateAddress(@RequestParam("addrId") int addressId, String province, String city, String area,
                                 String address, String remark, String username, String email, String mobile, HttpSession session

    ) {


        if (province != null || city != null || area != null) {
            province = addrService.getAreaNameById(province);
            city = addrService.getAreaNameById(city);
            area = addrService.getAreaNameById(area);
        }


        if (session == null) {
            //用户未登录，跳转至登录页面
            throw new UserLoginAuthenticationException("当前的session为空，用户未登录");
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {  //用户未登录
            //用户未登录，跳转至登录页面
            throw new UserLoginAuthenticationException("用户未登录");
        }

        user.setUserName(username);
        user.setEmail(email);
        user.setMobile(mobile);

        //创建一个地址对象
        Address addr = new Address();

        //检测address是否含有- 如果有，则视为含有非法字符，跳转出
        if (address.contains("-")) {  //用户未登录
            //跳转到登录页面
            return "用户地址中存在非法字符-,请重新填写正确的地址";
//            response.setHeader("refresh", "3;url=" + request.getContextPath() + "/Address/memberAddress.do");
        }
        String addressEnd = province + "-" + city + "-" + area + "-" + address;
        addr.setAddress(addressEnd);
        if (remark != null || "".equals(remark))
            addr.setRemark(remark);
        boolean successUser = userService.update(user);
        boolean successAddr = addrService.update(addr, addressId);

        if (successUser && successAddr) {
            return "修改成功";
//            response.setHeader("refresh", "1;url=" + request.getContextPath() + "/Address/memberAddress.do");
        }
        return "修改失败";
//        response.setHeader("refresh", "3;url=" + request.getContextPath() + "/Address/memberAddress.do");
    }

    //删除地址
    @RequestMapping("delAddress.do")
    private void delAddress(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String addrId = request.getParameter("addrId");
        if (addrId == null || "".equals(addrId)) {
            response.getWriter().print(false);
            return;
        }

        boolean result = addrService.delAddr(addrId);
        if (!result) {
            response.getWriter().print(false);
            return;
        }
        response.getWriter().print(true);
        return;
    }


    //设置默认值
    @RequestMapping("setDefaultAddr.do")
    private String setDefaultAddr(Integer addrId) throws ServletException, IOException {

        boolean result = addrService.setDefaultAddr(addrId);

        if (!result) {
            return "false";
        }
        return "true";
    }

}
