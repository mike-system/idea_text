<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/menu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/select.js"></script>
    <title>用户中心</title>
</head>
<body>
<%@include file="common/header.jsp" %>
<%@include file="common/top.jsp" %>
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <jsp:include page="./common/sidebar.jsp"></jsp:include>
        <div class="m_right">
            <div class="m_des">
                <table border="0" style="width:870px; line-height:22px;" cellspacing="0" cellpadding="0">
                    <tr valign="top">
                        <td width="115"><img src="${pageContext.request.contextPath }/images/user.jpg" width="90"
                                             height="90"/></td>
                        <td>
                            <div class="m_user">${sessionScope.user.loginName }</div>
                            <p>
                                等级：注册用户 <br/>
                                <font color="#ff4e00">您还差 270 积分达到 分红100</font><br/>
                                上一次登录时间: 2015-09-28 18:19:47<br/>
                                您还没有通过邮件认证 <a href="#" style="color:#ff4e00;">点此发送认证邮件</a>
                            </p>
                            <div class="m_notice">
                                用户中心公告！
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="mem_t">账号信息</div>
            <table border="0" class="mon_tab" style="width:870px; margin-bottom:20px;" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="40%">用户ID：<span style="color:#555555;">${sessionScope.user.loginName }</span></td>
                    <td width="60%"><span style="color:#555555;"></span></td>
                </tr>
                <tr>
                    <td>电&nbsp; &nbsp; 话：<span style="color:#555555;">${sessionScope.user.mobile }</span></td>
                    <td>邮&nbsp; &nbsp; 箱：<span style="color:#555555;">${sessionScope.user.email }</span></td>
                </tr>
                <tr>
                    <td>身份证号：<span style="color:#555555;">${sessionScope.user.identityCode }</span></td>
                    <td>用户姓名：<span style="color:#555555;">${sessionScope.user.userName }</span></td>
                </tr>
            </table>
        </div>
    </div>
    <%@include file="./common/tail.jsp" %>
</div>

</body>

</html>
