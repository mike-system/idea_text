<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <div id="fade" class="black_overlay"></div>
    <div id="MyDiv" class="white_content">             
        <div class="white_d">
            <div class="notice_t">
                <span class="fr" style="margin-top:10px; cursor:pointer;" onclick="CloseDiv('MyDiv','fade')"><img src=".././images/close.gif" /></span>
            </div>
            <div class="notice_c">
           		
                <table border="0" align="center" style="margin-top:0;" cellspacing="0" cellpadding="0">
                  <tr valign="top">
                    <td width="40"><img src=".././images/suc.png" /></td>
                    <td>
                    	<span style="color:#3e3e3e; font-size:18px; font-weight:bold;">您已成功收藏该商品</span><br />
                    	<a href="#">查看我的关注 >></a>
                    </td>
                  </tr>
                  <tr height="50" valign="bottom">
                  	<td>&nbsp;</td>
                    <td><a href="#" class="b_sure">确定</a></td>
                  </tr>
                </table>
                    
            </div>
        </div>
    </div>    
    
    <div id="fade1" class="black_overlay"></div>
    <div id="MyDiv1" class="white_content">             
        <div class="white_d">
            <div class="notice_t">
                <span class="fr" style="margin-top:10px; cursor:pointer;" onclick="CloseDiv_1('MyDiv1','fade1')"><img src=".././images/close.gif" /></span>
            </div>
            <div class="notice_c">
                <table border="0" align="center" style="margin-top:;" cellspacing="0" cellpadding="0">
                  <tr valign="top">
                    <td width="40"><img src=".././images/suc.png" /></td>
                    <td>
                    	<span style="color:#3e3e3e; font-size:18px; font-weight:bold;">宝贝已成功添加到购物车</span><br />
                    	购物车共有<span></span>种宝贝（<span></span>件） &nbsp; &nbsp; 合计：<span></span>元
                    </td>
                  </tr>
                  <tr height="50" valign="bottom">
                  	<td>&nbsp;</td>
                    <td><a href="${pageContext.request.contextPath }/Car/settleAccountsOne.do" class="b_sure">去购物车结算</a><a href="javascript:CloseDiv_1('MyDiv1','fade1')" class="b_buy">继续购物</a></td>
                  </tr>
                </table>
                    
            </div>
        </div>
    </div> 