<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style type="text/css">
        select {
            width: 150px;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <script>
        var path = "${pageContext.request.contextPath }";
        var thisId = "${sessionScope.user.id }"
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/myJs/memberAddress.js"></script>
    <title>收获地址</title>
</head>
<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath }"/>
<!--Begin Header Begin-->
<%@include file="common/header.jsp" %>
<%@include file="common/top.jsp" %>

<!--End Header End-->
<div class="i_bg bg_color">
    <div class="m_content">
        <jsp:include page="./common/sidebar.jsp"></jsp:include>
        <!--Begin 用户中心 Begin -->
        <div class="m_right">
            <p></p>
            <div class="mem_tit">收货地址</div>
            <c:forEach items="${addrList }" var="addr">
                <div class="address">
                    <div class="a_close"><a href="javascript:delAddr(${addr.id })"><img src=".././images/a_close.png"/></a>
                    </div>
                    <table border="0" class="add_t" align="center" style="width:98%; margin:10px auto;" cellspacing="0"
                           cellpadding="0">
                        <tr>
                            <td colspan="2" style="font-size:14px; color:#ff4e00;">${sessionScope.user.loginName }</td>
                        </tr>
                        <tr>
                            <td align="right" width="80">收货人姓名：</td>
                            <td>${sessionScope.user.userName }</td>
                        </tr>
                        <tr>
                            <td align="right">详细地址：</td>
                            <td>${addr.address }</td>
                        </tr>
                        <tr>
                            <td align="right">手机：</td>
                            <td>${sessionScope.user.mobile }</td>
                        </tr>
                        <tr>
                            <td align="right">电子邮箱：</td>
                            <td>${sessionScope.user.email }</td>
                        </tr>
                        <tr>
                            <td align="right">标志建筑：</td>
                            <td>${addr.remark }</td>
                        </tr>
                    </table>

                    <p align="right">
                        <!-- 点击编辑时，发送ajax请求 -->
                        <a href="javascript:setDefault(${addr.id })" style="color:#ff4e00;">设为默认</a>&nbsp; &nbsp; &nbsp;
                        &nbsp; <a href="javascript:modifyAddr(${addr.id })" style="color:#ff4e00;">编辑</a>&nbsp; &nbsp;
                        &nbsp; &nbsp;
                    </p>
                </div>
            </c:forEach>

            <div class="mem_tit">
                <a href="javascript:addAddr()"><img src=".././images/add_ad.gif"/></a>
            </div>
            <!--   //修改 -->
            <form action="${pageContext.request.contextPath }/Address/updateAddress.do" method="post" id="modifyType"
                  style="display:none;">

                <input type="hidden" id="addrId" name="addrId"/>
                <table border="0" class="add_tab" style="width:930px;" cellspacing="0" cellpadding="0">

                    <tr>
                        <td width="135" align="right">配送地区</td>
                        <td colspan="3" style="font-family:'宋体';" class="area">
                            <select class="jj" name="province">
                                <option value="0" selected="selected">请选择...</option>
                            </select>
                            <select class="jj" name="city">
                                <option value="0" selected="selected">请选择...</option>
                            </select>
                            <select class="jj" name="area">
                                <option value="0" selected="selected">请选择...</option>
                            </select>
                            <span>（必填）</span>
                        </td>
                    </tr>
                    <tr>
                        <input type="hidden" class="userId" value="${sessionScope.user.id }">
                        <td align="right">收货人姓名</td>
                        <td style="font-family:'宋体';"><input type="text" name="username"
                                                             value="${sessionScope.user.userName }"
                                                             class="add_ipt"/><span>（必填）</span></td>
                        <td align="right">电子邮箱</td>
                        <td style="font-family:'宋体';"><input type="text" name="email"
                                                             value="${sessionScope.user.email }" class="add_ipt"/><span>（必填）</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">详细地址</td>
                        <td style="font-family:'宋体';"><input type="text" name="address" value="" class="add_ipt"/><span>（必填）</span>
                        </td>
                        <td align="right">标志建筑</td>
                        <td style="font-family:'宋体';"><input type="text" name="remark" value="" class="add_ipt"/></td>
                    </tr>
                    <tr>
                        <td align="right">手机</td>
                        <td style="font-family:'宋体';"><input type="text" name="mobile"
                                                             value="${sessionScope.user.mobile }"
                                                             class="add_ipt"/><span>（必填）</span></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
                <p align="right">
                    <a href="javascript:hidModifyOrUpdate('modifyType')">取消</a>&nbsp; &nbsp;
                    <button class="add_b" type="submit">确认修改</button>
                </p>
            </form>

            <!-- 添加 -->
            <form action="${pageContext.request.contextPath }/Address/addAddress.do" method="post" id="addType"
                  style="display:none;">
                <table border="0" class="add_tab" style="width:930px;" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="135" align="right">配送地区</td>
                        <td colspan="3" class="area" style="font-family:'宋体';">
                            <select class="jj" name="province" id="provinceId">
                                <option value="0" selected="selected">请选择...</option>
                            </select>
                            <select class="jj" name="city">
                                <option value="0" selected="selected">请选择...</option>
                            </select>
                            <select class="jj" name="area">
                                <option value="0" selected="selected">请选择...</option>
                            </select>
                            <span>（必填）</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">收货人姓名</td>
                        <td style="font-family:'宋体';"><input type="text" value="" name="username"
                                                             class="add_ipt"/><span>（必填）</span></td>
                        <td align="right">电子邮箱</td>
                        <td style="font-family:'宋体';"><input type="text" value="" name="email" class="add_ipt"/><span>（必填）</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">详细地址</td>
                        <td style="font-family:'宋体';"><input type="text" value="" name="address" class="add_ipt"/><span>（必填）</span>
                        </td>
                        <td align="right">标志建筑</td>
                        <td style="font-family:'宋体';"><input type="text" value="" name="remark" class="add_ipt"/></td>
                    </tr>
                    <tr>
                        <td align="right">手机</td>
                        <td style="font-family:'宋体';"><input type="text" value="" name="mobile" class="add_ipt"/><span>（必填）</span>
                        </td>
                        <td align="right"></td>
                        <td style="font-family:'宋体';"></td>
                    </tr>
                </table>
                <p align="right">
                    <a href="javascript:hidModifyOrUpdate('addType')">取消</a>&nbsp; &nbsp;
                    <button class="add_b" type="submit" onclick="check()">确认添加</button>
                </p>
            </form>
        </div>
    </div>
    <%@include file="./common/tail.jsp" %>
</div>

</body>
</html>
