<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/myJs/login.js"></script>

    <script type="text/javascript">
        $(document).ready(function (e) {
            var counter = 0;
            if (window.history && window.history.pushState) {
                $(window).on('popstate', function () {
                    window.history.pushState('forward', null, '#');
                    window.history.forward(1);
                    //alert("不可回退");  //如果需在弹框就有它
                    self.location = "orderinfo.html"; //如查需要跳转页面就用它
                });
            }
            window.history.pushState('forward', null, '#'); //在IE中必须得有这两行
            window.history.forward(1);
        });
    </script>

    <title>登录</title>
</head>
<body>
<!--Begin Header Begin-->
<jsp:include page="./common/loginHeader.jsp"/>

<!--End Header End-->
<!--Begin Login Begin-->
<div class="log_bg">
    <div class="top">
        <div class="logo"><a href="javascript:window.location='${pageContext.request.contextPath}/index.do'"><img src="${pageContext.request.contextPath}/images/logo.png"/></a></div>
    </div>
    <div class="login">
        <div class="log_img"><img src="${pageContext.request.contextPath}/images/l_img.png" width="611" height="425"/></div>
        <div class="log_c">
            <form action="${pageContext.request.contextPath }/userAccount/login.do" method="POST"
                  onsubmit="return checkForm()" id="formId">
                <table border="0" style="width:370px; font-size:14px; margin-top:30px;" cellspacing="0" cellpadding="0">
                    <tr height="50" valign="top">
                        <td width="55">&nbsp;</td>
                        <td>
                            <span class="fl" style="font-size:24px;">登录</span>
                            <span class="fr">还没有商城账号，<a
                                    href="${pageContext.request.contextPath }/userAccount/registUI.do"
                                    style="color:#ff4e00;">立即注册</a></span>
                        </td>
                    </tr>
                    <tr height="70">
                        <td>用户名</td>
                        <td><input type="text" value="" name="username" class="l_user"/><span></span></td>
                    </tr>
                    <tr height="70">
                        <td>密&nbsp; &nbsp; 码</td>
                        <td><input type="password" value="" name="password" class="l_pwd"/><br><span></span></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td id="messageId"> ${requestScope.errorMessage }</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td style="font-size:12px; padding-top:20px;">
                	<span style="font-family:'宋体';" class="fl">
                    	<label class="r_rad"><input type="checkbox"/></label><label class="r_txt">请保存我这次的登录信息</label>
                    </span>
                            <span class="fr"><a href="#" style="color:#ff4e00;">忘记密码</a></span>
                        </td>
                    </tr>
                    <tr height="60">
                        <td>&nbsp;</td>
                        <td><input type="submit" value="登录" class="log_btn"/></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
<!--End Login End-->
<!--Begin Footer Begin-->
<%@include file="./common/loginTail.jsp" %>
<!--End Footer End -->

</body>

</html>
