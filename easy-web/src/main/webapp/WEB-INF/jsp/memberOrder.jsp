<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page isELIgnored="false" %>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <title>订单信息</title>
    <style type="text/css">
        .btn_u {
            display: inline-block;
        }
    </style>

    <script>
        var path = "${pageContext.request.contextPath }";
        var totalPage = "${requestScope.pagingInfoOrderList.totalPage }";

        //补0操作
        function getzf(num) {
            if (parseInt(num) < 10) {
                num = '0' + num;
            }
            return num;
        }

        //获得年月日      得到日期oTime
        function getMyDate(str) {
            var oDate = new Date(str),
                oYear = oDate.getFullYear(),
                oMonth = oDate.getMonth() + 1,
                oDay = oDate.getDate(),
                oHour = oDate.getHours(),
                oMin = oDate.getMinutes(),
                oSen = oDate.getSeconds(),
                oTime = oYear + '-' + getzf(oMonth) + '-' + getzf(oDay) + ' ' + getzf(oHour) + ':' + getzf(oMin) + ':' + getzf(oSen);//最后拼接时间
            return oTime;
        };

        //订单状态
        function statusMethod(statu) {
            if (eval(statu) == "0") {
                return "已确定,未付款,未发货";
            }
            if (eval(statu) == "2") {
                return "已确定,已付款,未发货";
            }
            if (eval(statu) == "4") {
                return "已确定,已付款,已发货";
            }
        }

        //取消订单
        /* 
        
        	<c:if test="${order.status == 4}">
			                		<font color="#ff4e00">已确认</font>
			                	</c:if>
			                	<c:if test="${order.status != 4}">
			                		<a href="javascript:delOrder(${order.id })">取消订单</a>
			                	</c:if>
        
        */

        function closeOrderMethod(id, status) {
            if (status != 4) {
                return "<a href='javascript:delOrder(" + id + ")'>取消订单</a>";
            }
            if (status == 4) {
                return "<font color='#ff4e00'>已确认</font>";
            }

        }


        $(function () {
            //$("#stutasId")  绑定失去焦点事件
            $("#stutasId").bind("change", function () {
                var $val = $(this).val();
                $.ajax({
                    url: path + "/Order/memberOrder.do?orderStatus=" + $val,
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        $('#pageIndex').val(data.currentPage);
                        totalPage = data.totalPage;
                        var result = data['data'];
                        $("#tbodyID").html("");
                        $.each(result, function (i, e) {
                            /* console.log(e); */
                            //将遍历到的结果放入到页面
                            $("#tbodyID").append("<tr>" +
                                "<td><font color='#ff4e00'>" + e.serialNumber + "</font></td>" +
                                "<td>" + getMyDate(e.createTime) + "</td>" +
                                "<td>" + (e.cost).toFixed(2) + "</td>" +
                                "<td>" + statusMethod(e.status) + "</td>" +
                                "<td>" + closeOrderMethod(e.id, e.status) + "</td>" +
                                "</tr>");
                        })

                    }
                });
            });
        })

        // $('#pageIndex').val()
        function current2Next(currentPageIndex) {

            if (isNaN(Number(currentPageIndex))) {
                currentPageIndex = 1;
            }


            //获取标签中传入过来的订单状态
            var $status = $("#stutasId").val();
            //判断当前传入过来的数据是否符合要求
            if (currentPageIndex > totalPage) {
                alert("已经是最后一页啦");
                return;
            }
            if (currentPageIndex < 1) {
                alert("已经是第一页啦");
                return;
            }

            $.ajax({
                url: path + "/Order/memberOrder.do",
                type: "get",
                dataType: "json",
                data: {
                    "orderStatus": $status,
                    "currentPage": currentPageIndex
                },
                success: function (data) {
                    totalPage = data.totalPage;
                    $('#pageIndex').val(data.currentPage);
                    var result = data['data'];
                    $("#tbodyID").html("");
                    $.each(result, function (i, e) {
                        //将遍历到的结果放入到页面
                        $("#tbodyID").append("<tr>" +
                            "<td><font color='#ff4e00'>" + e.serialNumber + "</font></td>" +
                            "<td>" + getMyDate(e.createTime) + "</td>" +
                            "<td>" + (e.cost).toFixed(2) + "</td>" +
                            "<td>" + statusMethod(e.status) + "</td>" +
                            "<td>" + closeOrderMethod(e.id, e.status) + "</td>" +
                            "</tr>");
                    })
                }
            });

        }
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/myJs/memberOrder.js"></script>
</head>
<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath }"/>
<!--Begin Header Begin-->
<%@include file="common/header.jsp" %>
<%@include file="common/top.jsp" %>

<!--End Header End-->
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <jsp:include page="./common/sidebar.jsp"></jsp:include>

        <div class="m_right">
            <p></p>
            <div class="mem_tit">我的订单</div>
            <table border="0" class="order_tab" style="width:930px;" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="135" align="right">选择类型</td>
                    <td width="220" align="center">
                        <select id="stutasId">
                            <option value="8">全部</option>
                            <option value="0">已提交</option>
                            <option value="2">已付款</option>
                            <option value="4">已发货</option>
                        </select>
                    </td>
                    <td>
                        <div align="center">
                            <input value="1" type="hidden" id="pageIndex"/>
                            <p class="btn_u"><a href="javascript:current2Next(eval($('#pageIndex').val()) -1)">上一页</a>
                            </p>
                            <p class="btn_u"><a href="javascript:current2Next(eval($('#pageIndex').val()) +1)">下一页</a>
                            </p>
                        </div>
                    </td>
                </tr>
            </table>
            <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;"
                   cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                    <th width="20%">订单号</th>
                    <th width="25%">下单时间</th>
                    <th width="15%">订单总金额</th>
                    <th width="25%">订单状态</th>
                    <th width="15%">操作</th>
                </tr>
                </thead>
                <tbody id="tbodyID">
                <c:forEach items="${requestScope.pagingInfoOrderList.data }" var="order">
                    <tr>
                        <td><font color="#ff4e00">${order.serialNumber }</font></td>
                        <td><fmt:formatDate value="${order.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>￥<fmt:formatNumber pattern="0.00" maxFractionDigits="2" value="${order.cost }"
                                               type="number"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${order.status == 0}">
                                    已确定,未付款,未发货
                                </c:when>
                                <c:when test="${order.status == 2}">
                                    已确定,已付款,未发货
                                </c:when>
                                <c:when test="${order.status == 4}">
                                    已确定,已付款,已发货
                                </c:when>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${order.status == 4}">
                                <font color="#ff4e00">已确认</font>
                            </c:if>
                            <c:if test="${order.status != 4}">
                                <a href="javascript:delOrder(${order.id })">取消订单</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>

            </table>

            <div class="mem_tit">合并订单</div>
            <table border="0" class="order_tab" style="width:930px;" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="135" align="right">主订单</td>
                    <td width="220">
                        <select class="jj" name="order1">
                            <option value="0" selected="selected">请选择...</option>
                            <c:forEach items="${requestScope.orderListByStatus }" var="order">
                                <option value="${order.serialNumber }">${order.serialNumber }</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td width="135" align="right">从订单</td>
                    <td width="220">
                        <select class="jj" name="order2">
                            <option value="0" selected="selected">请选择...</option>
                            <c:forEach items="${requestScope.orderListByStatus }" var="order">
                                <option value="${order.serialNumber }">${order.serialNumber }</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <div class="btn_u"><a href="javascript:merge();">合并订单</a></div>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td colspan="4" style="font-family:'宋体'; padding:20px 10px 50px 10px;">
                        订单合并是在发货前将相同状态的订单合并成一新的订单。 <br/>
                        收货地址，送货方式等以主定单为准。
                    </td>
                </tr>
            </table>
        </div>
        <%@include file="common/tail.jsp" %>
    </div>
</div>
</body>

</html>
