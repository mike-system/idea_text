<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css"/>
<head>
    <script>
        var path = "${pageContext.request.contextPath }";
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/menu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/select.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/lrscroll.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/iban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/fban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/f_ban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/mban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/bban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/hban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/tban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/lrscroll_1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/myJs/regist.js"></script>

    <title>用户注册</title>
</head>
<body>
<%@include file="./common/loginHeader.jsp" %>
<div class="log_bg">
    <div class="top">
        <div class="logo"><a href="Index.html"><img src="${pageContext.request.contextPath }/images/logo.png"/></a>
        </div>
    </div>
    <div class="regist">
        <div class="log_img"><img src="${pageContext.request.contextPath }/images/l_img.png" width="611" height="425"/>
        </div>
        <div class="reg_c">
            <form action="${pageContext.request.contextPath }/userAccount/register.do" method="post"
                  onsubmit="return checkForm()" id="formId">
                <table border="0" style="width:420px; font-size:14px; margin-top:20px;" cellspacing="0" cellpadding="0">
                    <tr height="50" valign="top">
                        <td width="95">&nbsp;</td>
                        <td>
                            <span class="fl" style="font-size:24px;">注册</span>
                            <span class="fr">已有商城账号，<a
                                    href="${pageContext.request.contextPath }/userAccount/loginUI.do"
                                    style="color:#ff4e00;">我要登录</a></span>
                        </td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;用户名 &nbsp;</td>
                        <td>
                            <input type="text" value="" class="l_user" name="loginname"/>
                            <input type="hidden" value="" name="userId"/>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td id="message1" class="checkMess"></td>
                    </tr>

                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;密码 &nbsp;</td>
                        <td><input type="password" value="" class="l_pwd" name="password"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td id="message2" class="checkMess"></td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;确认密码 &nbsp;</td>
                        <td><input type="password" value="" class="l_pwd" name="password"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td id="message3" class="checkMess"></td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;邮箱 &nbsp;</td>
                        <td><input type="text" value="" class="l_email" name="email"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td id="message4" class="checkMess"></td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;手机 &nbsp;</td>
                        <td><input type="text" value="" class="l_tel" name="mobile"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td id="message5" class="checkMess"></td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;验证码 &nbsp;</td>
                        <td style="display:table-cell; vertical-align:middle">
                            <input type="text" value="" class="l_ipt" name="codeVal" id="codeId"/>
                            <img alt="加载失败"  onclick="getNewPicCode()" id="codeImg" src="${pageContext.request.contextPath }/PictureCodeServlet.do"><span></span>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td id="message6" class="checkMess"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td style="font-size:12px; padding-top:20px;">
                	<span style="font-family:'宋体';" class="fl">
                    	<label class="r_rad"><input type="checkbox"/></label><label class="r_txt">我已阅读并接受《用户协议》</label>
                    </span>
                        </td>
                    </tr>
                    <tr height="60">
                        <td>&nbsp;</td>
                        <td><input type="submit" value="立即注册" class="log_btn"/></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
<%@include file="./common/loginTail.jsp" %>
</body>
</html>
