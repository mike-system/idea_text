<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page isELIgnored="false" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/menu.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/select.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/lrscroll.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/iban.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/fban.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/f_ban.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/mban.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/bban.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/hban.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/tban.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/lrscroll_1.js"></script>
<title>首页</title>
</head>
<body>
	<!-- 状态栏 -->
	<%@include file="./common/header.jsp"%>
	<!-- 购物车，搜索栏 -->
	<%@include file="./common/top.jsp"%>
	<!--导航栏-->
<%--	<%@include file="./common/nav.jsp"%>--%>
	<jsp:include page="common/nav.jsp"></jsp:include>
	<!--End Menu End-->
	<div class="i_bg bg_color">
		<div class="i_ban_bg">
			<!--Begin Banner Begin-->
			<div class="banner">
				<div class="top_slide_wrap">
					<ul class="slide_box bxslider">
						<li><img src="${pageContext.request.contextPath}/images/ban1.jpg" width="740" height="401" /></li>
						<li><img src="${pageContext.request.contextPath}/images/ban1.jpg" width="740" height="401" /></li>
						<li><img src="${pageContext.request.contextPath}/images/ban1.jpg" width="740" height="401" /></li>
					</ul>
					<div class="op_btns clearfix">
						<a href="#" class="op_btn op_prev"><span></span></a> <a href="#"
							class="op_btn op_next"><span></span></a>
					</div>
				</div>
			</div>
			<script type="text/javascript">
				$(function() {
					console.log($(".floor_num").length);
					$(".floor_num").each(function (i,e) {
						$(e).children("span").first().html(i+1);
					})
					
				});
					
				/* (function() {
					$(".bxslider").bxSlider({
						auto : true,
						prevSelector : jq(".top_slide_wrap .op_prev")[0],
						nextSelector : jq(".top_slide_wrap .op_next")[0]
					});
					
				})(); */
			</script>
			<!--End Banner End-->
			<div class="inews">
				<div class="news_t">
					<span class="fr"><a href="${pageContext.request.contextPath }/News/newsList.do">更多 ></a></span>新闻资讯
				</div>
				<ul>
					<!-- 新闻 -->
					<c:forEach items="${requestScope.pageNews.data }" var="news">
						<li><span>[ 公告 ]</span><a href="${pageContext.request.contextPath }/News/newsShow.do?id=${news.id}">${news.title }</a></li>
					</c:forEach>
				</ul>
				<div class="charge_t">
					话费充值
					<div class="ch_t_icon"></div>
				</div>
				<form>
					<table border="0" style="width: 205px; margin-top: 10px;"
						cellspacing="0" cellpadding="0">
						<tr height="35">
							<td width="33">号码</td>
							<td><input type="text" value="" class="c_ipt" /></td>
						</tr>
						<tr height="35">
							<td>面值</td>
							<td><select class="jj" name="city">
									<option value="0" selected="selected">100元</option>
									<option value="1">50元</option>
									<option value="2">30元</option>
									<option value="3">20元</option>
									<option value="4">10元</option>
							</select> <span style="color: #ff4e00; font-size: 14px;">￥99.5</span></td>
						</tr>
						<tr height="35">
							<td colspan="2"><input type="submit" value="立即充值"
								class="c_btn" /></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!--Begin 热门商品 Begin-->
		<div class="content mar_10">
			<div class="h_l_img">
				<div class="img">
					<img src="${pageContext.request.contextPath}/images/l_img.jpg" width="188" height="188" />
				</div>
				<div class="pri_bg">
					<span class="price fl">￥53.00</span> <span class="fr">16R</span>
				</div>
			</div>
			<div class="hot_pro">
				<div id="featureContainer">
					<div id="feature">
						<div id="block">
							<div id="botton-scroll">
								<ul class="featureUL">
									<li class="featureBox">
										<div class="box">
											<div class="h_icon">
												<img src="${pageContext.request.contextPath}/images/hot.png" width="50" height="50" />
											</div>
											<div class="imgbg">
												<a href="#"><img src="${pageContext.request.contextPath}/images/hot1.jpg" width="160"
													height="136" /></a>
											</div>
											<div class="name">
												<a href="#">
													<h2>德国进口</h2> 德亚全脂纯牛奶200ml*48盒
												</a>
											</div>
											<div class="price">
												<font>￥<span>189</span></font> &nbsp; 26R
											</div>
										</div>
									</li>
									<li class="featureBox">
										<div class="box">
											<div class="h_icon">
												<img src="${pageContext.request.contextPath}/images/hot.png" width="50" height="50" />
											</div>
											<div class="imgbg">
												<a href="#"><img src="${pageContext.request.contextPath}/images/hot2.jpg" width="160"
													height="136" /></a>
											</div>
											<div class="name">
												<a href="#">
													<h2>iphone 6S</h2> Apple/苹果 iPhone 6s Plus公开版
												</a>
											</div>
											<div class="price">
												<font>￥<span>5288</span></font> &nbsp; 25R
											</div>
										</div>
									</li>
									<li class="featureBox">
										<div class="box">
											<div class="h_icon">
												<img src="${pageContext.request.contextPath}/images/hot.png" width="50" height="50" />
											</div>
											<div class="imgbg">
												<a href="#"><img src="${pageContext.request.contextPath}/images/hot3.jpg" width="160"
													height="136" /></a>
											</div>
											<div class="name">
												<a href="#">
													<h2>倩碧特惠组合套装</h2> 倩碧补水组合套装8折促销
												</a>
											</div>
											<div class="price">
												<font>￥<span>368</span></font> &nbsp; 18R
											</div>
										</div>
									</li>
									<li class="featureBox">
										<div class="box">
											<div class="h_icon">
												<img src="${pageContext.request.contextPath}/images/hot.png" width="50" height="50" />
											</div>
											<div class="imgbg">
												<a href="#"><img src="${pageContext.request.contextPath}/images/hot4.jpg" width="160"
													height="136" /></a>
											</div>
											<div class="name">
												<a href="#">
													<h2>品利特级橄榄油</h2> 750ml*4瓶装组合 西班牙原装进口
												</a>
											</div>
											<div class="price">
												<font>￥<span>280</span></font> &nbsp; 30R
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<a class="h_prev" href="javascript:void(0);">Previous</a> <a
							class="h_next" href="javascript:void(0);">Next</a>
					</div>
				</div>
			</div>
		</div>
		<!--Begin 限时特卖 Begin-->
		<!-- <div class="i_t mar_10">
			<span class="fl">限时特卖</span> <span class="i_mores fr"><a
				href="#">更多</a></span>
		</div>
		<div class="content">
			<div class="i_sell">
				<div id="imgPlay">
					<ul class="imgs" id="actor">
						<li><a href="#"><img src="${pageContext.request.contextPath}/images/tm_r.jpg" width="211"
								height="357" /></a></li>
						<li><a href="#"><img src="${pageContext.request.contextPath}/images/tm_r.jpg" width="211"
								height="357" /></a></li>
						<li><a href="#"><img src="${pageContext.request.contextPath}/images/tm_r.jpg" width="211"
								height="357" /></a></li>
					</ul>
					<div class="previ">上一张</div>
					<div class="nexti">下一张</div>
				</div>
			</div>
			<div class="sell_right">
				<div class="sell_1">
					<div class="s_img">
						<a href="#"><img src="${pageContext.request.contextPath}/images/tm_1.jpg" width="185"
							height="155" /></a>
					</div>
					<div class="s_price">
						￥<span>89</span>
					</div>
					<div class="s_name">
						<h2>
							<a href="#">沙宣洗发水</a>
						</h2>
						倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
					</div>
				</div>
				<div class="sell_2">
					<div class="s_img">
						<a href="#"><img src="${pageContext.request.contextPath}/images/tm_2.jpg" width="185"
							height="155" /></a>
					</div>
					<div class="s_price">
						￥<span>289</span>
					</div>
					<div class="s_name">
						<h2>
							<a href="#">德芙巧克力</a>
						</h2>
						倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
					</div>
				</div>
				<div class="sell_b1">
					<div class="sb_img">
						<a href="#"><img src="${pageContext.request.contextPath}/images/tm_b1.jpg" width="242"
							height="356" /></a>
					</div>
					<div class="s_price">
						￥<span>289</span>
					</div>
					<div class="s_name">
						<h2>
							<a href="#">东北大米</a>
						</h2>
						倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
					</div>
				</div>
				<div class="sell_3">
					<div class="s_img">
						<a href="#"><img src="${pageContext.request.contextPath}/images/tm_3.jpg" width="185"
							height="155" /></a>
					</div>
					<div class="s_price">
						￥<span>289</span>
					</div>
					<div class="s_name">
						<h2>
							<a href="#">迪奥香水</a>
						</h2>
						倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
					</div>
				</div>
				<div class="sell_4">
					<div class="s_img">
						<a href="#"><img src="${pageContext.request.contextPath}/images/tm_4.jpg" width="185"
							height="155" /></a>
					</div>
					<div class="s_price">
						￥<span>289</span>
					</div>
					<div class="s_name">
						<h2>
							<a href="#">美妆</a>
						</h2>
						倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
					</div>
				</div>
				<div class="sell_b2">
					<div class="sb_img">
						<a href="#"><img src="${pageContext.request.contextPath}/images/tm_b2.jpg" width="242"
							height="356" /></a>
					</div>
					<div class="s_price">
						￥<span>289</span>
					</div>
					<div class="s_name">
						<h2>
							<a href="#">美妆</a>
						</h2>
						倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
					</div>
				</div>
			</div>
		</div> -->
		<!--End 限时特卖 End-->
		<div class="content mar_20">
			<img src="${pageContext.request.contextPath}/images/mban_1.jpg" width="1200" height="110" />
		</div>
		<c:forEach items="${proList }" var="pro1">
			<c:if test="${pro1.type == 1 }">
				<!--Begin 进口 生鲜 Begin-->
				<div class="i_t mar_10">
					<span class="floor_num"><span></span>F</span> <span class="fl">${pro1.name }
					</span> <span class="i_mores fr">
						<c:forEach items="${proList }" var="pro2">
							<c:if test="${pro2.type == 2 and pro2.parentId == pro1.id }">
								<c:forEach items="${proList }" var="pro3">
									<c:if test="${pro3.type == 3 and pro3.parentId == pro2.id }">
											<a href="${pageContext.request.contextPath }/Product/showListProductByCategoryLevel3Id.do?id=${pro3.id }">${pro3.name }</a>&nbsp; &nbsp;&nbsp;
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
					</span>
				</div>
				<div class="content">
					<div class="fresh_left">
						<div class="fre_ban">
							<div id="imgPlay1">
								<ul class="imgs" id="actor1">
									<li><a href="#"><img src="${pageContext.request.contextPath}/images/fre_r.jpg"
											width="211" height="286" /></a></li>
									<li><a href="#"><img src="${pageContext.request.contextPath}/images/fre_r.jpg"
											width="211" height="286" /></a></li>
									<li><a href="#"><img src="${pageContext.request.contextPath}/images/fre_r.jpg"
											width="211" height="286" /></a></li>
								</ul>
								<div class="prevf">上一张</div>
								<div class="nextf">下一张</div>
							</div>
						</div>
						<div class="fresh_txt">
							<div class="fresh_txt_c">
								<c:forEach items="${proList }" var="pro2">
									<c:if test="${pro2.type == 2 and pro2.parentId == pro1.id }">
										<c:forEach items="${proList }" var="pro3">
											<c:if test="${pro3.type == 3 and pro3.parentId == pro2.id }">
												<a  href="${pageContext.request.contextPath }/Product/showListProductByCategoryLevel3Id.do?id=${pro3.id }">${pro3.name }</a>&nbsp; &nbsp;&nbsp;
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="fresh_mid">
						<ul>
							<c:forEach items="${products }" var="pro">
								<c:if test="${pro1.id == pro.categoryLevel1Id }">
									 <li>
					                	<div class="name"><a href="#">${pro.name }</a></div>
					                    <div class="price">
					                    	<font>￥<span><fmt:formatNumber pattern="0.00" type="text" minFractionDigits="2" value="${pro.price }"/>  </span></font> &nbsp; 26R
					                    </div>
					                    <div class="img"><a href="${pageContext.request.contextPath }/Product/showProduct.do?id=${pro.id}"><img src="${pageContext.request.contextPath}/images/${pro.fileName }" width="185" height="155" /></a></div>
					                </li>
									
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="fresh_right">
						<ul>
							<li><a href="#"><img src="${pageContext.request.contextPath}/images/fre_b1.jpg" width="260"
									height="220" /></a></li>
							<li><a href="#"><img src="${pageContext.request.contextPath}/images/fre_b2.jpg" width="260"
									height="220" /></a></li>
						</ul>
					</div>
				</div>
			</c:if>
		</c:forEach>
		<!--Begin 猜你喜欢 Begin-->
		<!-- <div class="i_t mar_10">
			<span class="fl">猜你喜欢</span>
		</div>
		<div class="like">
			<div id="featureContainer1">
				<div id="feature1">
					<div id="block1">
						<div id="botton-scroll1">
							<ul class="featureUL">
								<li class="featureBox">
									<div class="box">
										<div class="imgbg">
											<a href="#"><img src="${pageContext.request.contextPath}/images/hot1.jpg" width="160"
												height="136" /></a>
										</div>
										<div class="name">
											<a href="#">
												<h2>德国进口</h2> 德亚全脂纯牛奶200ml*48盒
											</a>
										</div>
										<div class="price">
											<font>￥<span>189</span></font> &nbsp; 26R
										</div>
									</div>
								</li>
								<li class="featureBox">
									<div class="box">
										<div class="imgbg">
											<a href="#"><img src="${pageContext.request.contextPath}/images/hot2.jpg" width="160"
												height="136" /></a>
										</div>
										<div class="name">
											<a href="#">
												<h2>iphone 6S</h2> Apple/苹果 iPhone 6s Plus公开版
											</a>
										</div>
										<div class="price">
											<font>￥<span>5288</span></font> &nbsp; 25R
										</div>
									</div>
								</li>
								<li class="featureBox">
									<div class="box">
										<div class="imgbg">
											<a href="#"><img src="${pageContext.request.contextPath}/images/hot3.jpg" width="160"
												height="136" /></a>
										</div>
										<div class="name">
											<a href="#">
												<h2>倩碧特惠组合套装</h2> 倩碧补水组合套装8折促销
											</a>
										</div>
										<div class="price">
											<font>￥<span>368</span></font> &nbsp; 18R
										</div>
									</div>
								</li>
								<li class="featureBox">
									<div class="box">
										<div class="imgbg">
											<a href="#"><img src="${pageContext.request.contextPath}/images/hot4.jpg" width="160"
												height="136" /></a>
										</div>
										<div class="name">
											<a href="#">
												<h2>品利特级橄榄油</h2> 750ml*4瓶装组合 西班牙原装进口
											</a>
										</div>
										<div class="price">
											<font>￥<span>280</span></font> &nbsp; 30R
										</div>
									</div>
								</li>
								<li class="featureBox">
									<div class="box">
										<div class="imgbg">
											<a href="#"><img src="${pageContext.request.contextPath}/images/hot4.jpg" width="160"
												height="136" /></a>
										</div>
										<div class="name">
											<a href="#">
												<h2>品利特级橄榄油</h2> 750ml*4瓶装组合 西班牙原装进口
											</a>
										</div>
										<div class="price">
											<font>￥<span>280</span></font> &nbsp; 30R
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<a class="l_prev" href="javascript:void();">Previous</a> <a
						class="l_next" href="javascript:void();">Next</a>
				</div>
			</div>
		</div> -->
		<%@include file="./common/tail.jsp"%>
	</div>
</body>
</html>
