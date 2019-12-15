package com.nf.easybuy.handler;


import com.nf.easybuy.domain.User;
import com.nf.easybuy.exception.CustomException;
import com.nf.easybuy.exception.NullPasswordRuntimeException;
import com.nf.easybuy.service.UserService;
import com.nf.easybuy.utils.WebUtilsl;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.annotation.RequiresGuest;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("userAccount")
public class UserController {

    //	ApplicationContext ac = ContextLoader.getCurrentWebApplicationContext();
    @Autowired
    private UserService userService;

    // 跳转登录
    @RequestMapping("loginUI.do")
    public String loginUI() {
        // 登录请求处理
        // 转发至登录页面
        return "login";
    }

    // 跳转至注册页面
    @RequestMapping("registUI.do")
    public String registUI() {
        // 登出请求处理
        return "regist";
    }

    // 登录处理
   /* @RequestMapping("login.do")
    public String login(@RequestParam("username") String loginname, String password, HttpSession session, Model model) throws ServletException, IOException {

        // 如果存在用户名或者密码为null,抛出异常，结束本线程
        if (loginname == null || password == null) {
            throw new AccountRuntimeException("运行时,获取用户名或者密码出现故障，或存在非法用户，导致用户名无法正常获取");
        }

        if ("".equals(loginname.trim()) || "".equals(password.trim())) {
            model.addAttribute("errorMessage", "用户名或者密码不能为空");
            return "login";
        }
        // 调用service层//验证用户是否存在
        User user = service.login(loginname, WebUtilsl.str2me5(password));

        if (user == null) {
            // 跳转至登录界面，用户名或者密码错误
            model.addAttribute("errorMessage", "用户名或者密码错误");
            return "login";
        }

        session.setAttribute("user", user);
        // 跳转首页
        return "index";
    }*/


    @RequestMapping("login.do")
    @RequiresGuest
    public String login(HttpServletRequest request) throws Exception {
        //如果登录失败，就在request中获取认证异常信息,shiroLoginFailure就是shiro异常类的全限定名
        String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");

        System.out.println("exceptionClassName = " + exceptionClassName);

        if(exceptionClassName != null){
            if(UnknownAccountException.class.equals(exceptionClassName)){
                throw new CustomException("账号不存在");
            }else if(IncorrectCredentialsException.class.getName().equals(exceptionClassName)){
                throw new CustomException("用户名或密码错误");
            }else if (AuthenticationException.class.getName().equals(exceptionClassName)){
                throw new AuthenticationException("认证错误:" + exceptionClassName);
            }else {
                throw new Exception("未知错误");
            }
        }

        //此方法不处理登录成功页面，如过登录成功，就返回到上一个请求路径
        // 跳转首页
        return "redirect:loginUI.do";
    }


   /* // 登出处理
    @RequestMapping("logout.do")
    public String logout(HttpSession session) {
        // 将用户的session中的用户删除
        session.invalidate();
        return "redirect:/main/index.do";
    }*/

    // 用户名是否存在处理
    @RequestMapping("checkUsername.do")
    @ResponseBody
    public String checkUsername(String loginname, @RequestParam("userId") String userIdStr) {
        if (loginname == null || "".equals(loginname.trim())) {
            // 登录名不能为空；
            return "用户名不能为空";
        }

        boolean result;
        if (userIdStr == null || "".equals(userIdStr.trim())) {
            result = userService.checkloginranme(loginname, null);
        } else {
            Integer userId = Integer.parseInt(userIdStr);
            result = userService.checkloginranme(loginname, userId);
        }

        if (!result)
            return "true";

        // 调用service层，调用出
        return "false";
    }

    // 邮箱判断是否存在处理
    @RequestMapping("checkEmail.do")
    @ResponseBody
    public String checkEmail(String email, @RequestParam("userId") String userIdStr) {

        if (email == null || "".equals(email.trim()))
            return "用户邮箱不能为空";

        boolean result;
        if (userIdStr == null || "".equals(userIdStr.trim())) {
            result = userService.checkemail(email, null);
        } else {
            Integer userId = Integer.parseInt(userIdStr);
            result = userService.checkemail(email, userId);
        }


        if (!result)
            return "true";

        // 调用service层，调用出
        return "false";
    }

    // 手机号码判断是否存在处理
    @RequestMapping("checkMobile.do")
    @ResponseBody
    public String checkMobile(String mobile, @RequestParam("userId") String userIdStr) {
        if (mobile == null || "".equals(mobile.trim()))
            return "用户手机号不能为空";

        boolean result;
        if (userIdStr == null || "".equals(userIdStr.trim())) {
            result = userService.checkmobile(mobile, null);
        } else {
            Integer userId = Integer.parseInt(userIdStr);
            result = userService.checkmobile(mobile, userId);
        }

        if (!result)
            return "true";

        return "false";

    }

    // 身份证判断是否存在处理
    @RequestMapping("checkIdentityCode.do")
    @ResponseBody
    public String checkIdentityCode(String identityCode, @RequestParam("userId") String userIdStr) {
        if (identityCode == null || "".equals(identityCode.trim()))
            return "身份证号码不能为空";

        boolean result;
        if (userIdStr == null || "".equals(userIdStr.trim())) {
            result = userService.checkIdentityCode(identityCode, null);
        } else {
            Integer userId = Integer.parseInt(userIdStr);
            result = userService.checkIdentityCode(identityCode, userId);
        }

        if (!result)
            return "true";

        return "false";

    }

    // 图片验证码
    @RequestMapping("checkImgCode.do")
    @ResponseBody
    public String checkImgCode(HttpSession session, String codeVal) {
        // 从session域中获取到该图片验证码
        String imgCode = (String) session.getAttribute("picCode");

        if (imgCode == null || "".equals(imgCode.trim()))
            // 像浏览器提示，服务器暂时无法提供服务
            return "false";

        if (codeVal == null || "".equals(codeVal.trim()))
            // 向浏览器提示，不能输入的内容为空
            return "true";

        // 不区分大小写
        if (imgCode.equalsIgnoreCase(codeVal))
            return "true";

        return "false";
    }

    // 用户注册
    @RequestMapping("register.do")
    @ResponseBody
    public String register(String loginname, String password, String email, String mobile, HttpServletResponse response, HttpServletRequest request) {

        if (loginname == null && password == null && email == null && mobile == null) {
            response.setHeader("refresh", "3;url=" + request.getContextPath() + "/userAccount/registUI.do");
            return "数据验证失败，请重新注册！3秒钟跳到注册页面";
        }

//		密码加密
        password = WebUtilsl.str2me5(password);

        // 封装成对象
        // 创建一个User对象
        User user = new User();
        user.setLoginName(loginname);
        user.setPassword(password);
        user.setEmail(email);
        user.setMobile(mobile);
        boolean isSuccess = userService.save(user);
        if (!isSuccess) {
            // 注册失败，重新注册
            response.setHeader("refresh", "3;url=" + request.getContextPath() + "/userAccount/registUI.do");
            return "注册失败，请重新注册！3秒钟跳到注册页面";
        }
        // 设置3秒钟跳转
        response.setHeader("refresh", "3;url=" + request.getContextPath() + "/userAccount/loginUI.do");
        return "注册成功！3秒钟跳到登录页面";
    }

    // 获取session中的用户的手机号码
    @RequestMapping("getMobileByUserId.do")
    @ResponseBody
    @RequiresUser
    public String getMobileByUserId(HttpSession session, @RequestParam("mobile") String newMobile) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // 当前用户未登录，跳转至登录页面
            return "redirect:loginUI.do";
        }
        String mobile = user.getMobile();
        if (newMobile == null || "".equals(newMobile.trim())) {
            return "false";
        }

        if (newMobile.equals(mobile)) {
            return "true";
        }
        return "false";
    }

    // 获取session中的用户的邮箱
    @RequestMapping("getEmailByUserId.do")
    @ResponseBody
    @RequiresUser
    public String getEmailByUserId(HttpSession session, @RequestParam("email") String newEmail) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // 当前用户未登录，跳转至登录页面
            return "redirect:loginUI.do";
        }
        String email = user.getEmail();

        if (newEmail == null || "".equals(newEmail.trim())) {
            return "false";
        }

        if (newEmail.equals(email)) {
            return "true";
        }
        return "false";
    }

    /**
     * / 获取session中的用户的手机号码
     * @param session
     * @param newMobile
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("updateMobile.do")
    @ResponseBody
    @RequiresUser
    public String updateMobile(HttpSession session, String newMobile, HttpServletRequest request, HttpServletResponse response) {

        // 获取用户传入过来的手机号码
        if (newMobile == null || "".equals(newMobile))
            return "用户传入过来的手机号为空";

        User user = (User) session.getAttribute("user");
        if (user == null)
            // 当前用户未登录，跳转至登录页面
            return "redirect:loginUI.do";


        user.setMobile(newMobile);
        // 更新数据库
        userService.update(user);

        // 设置3秒钟跳转
        response.setHeader("refresh", "3;url=" + request.getContextPath() + "/UserHomeServlet/userCenter.do");
        return "修改成功！3秒钟跳到个人中心";

    }

    /**
     * / 获取session中的用户的邮箱
     * @param request
     * @param response
     * @param newEmail
     * @return
     */
    @RequestMapping("updateEmail.do")
    @ResponseBody
    @RequiresUser
    public String updateEmail(HttpServletRequest request, HttpServletResponse response, String newEmail) {

        // 获取用户传入过来的邮箱

        if (newEmail == null || "".equals(newEmail)) {
//            System.out.println("用户传入过来的邮箱为空");
            return "用户传入过来的邮箱为空";
        }

        User user = (User) request.getSession(false).getAttribute("user");
        if (user == null)
            // 当前用户未登录，跳转至登录页面
            return "redirect:loginUI.do";
        user.setEmail(newEmail);
        // 更新数据库
        userService.update(user);

        // 设置3秒钟跳转
        response.setHeader("refresh", "3;url=" + request.getContextPath() + "/UserHomeServlet/userCenter.do");
        return "修改成功！3秒钟跳到个人中心";

    }

    /**
     *    / 获取session中的用户的密码
     */

    @RequestMapping("updatePassword.do")
    @ResponseBody
    @RequiresUser
    public String updatePassword(HttpSession session, HttpServletRequest request, HttpServletResponse response, String oldPassword, String newPassword, String checkPassword) {

        if (oldPassword == null || "".equals(oldPassword.trim())) {
            throw new NullPasswordRuntimeException("用户传入过来的旧密码oldPassword为空");
        }
        if (newPassword == null || "".equals(newPassword.trim())) {
            throw new NullPasswordRuntimeException("用户传入过来的新密码newPassword为空");
        }
        if (checkPassword == null || "".equals(checkPassword.trim())) {
            throw new NullPasswordRuntimeException("用户传入过来的检查checkPassword密码为空");
        }

        if (!newPassword.equals(checkPassword))
            return "两次输入的密码不一致";

        String oldPasswordMd5 = WebUtilsl.str2me5(oldPassword);

        User user = (User) request.getSession(false).getAttribute("user");
        if (user == null) {
            // 删除session，退出登录该用户
            session.invalidate();
            return "redirect:/main/loginUI.do";
        }

        String password = user.getPassword();
        if (!oldPasswordMd5.equals(password)) {
            return "输入的旧密码有误";
        }

        user.setPassword(WebUtilsl.str2me5(newPassword));
        // 更新数据库
        userService.update(user);
        session.invalidate();
        return "false";
    }

}
