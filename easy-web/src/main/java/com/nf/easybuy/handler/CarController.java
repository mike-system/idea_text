package com.nf.easybuy.handler;

import com.alibaba.fastjson.JSON;
import com.nf.easybuy.domain.Car;
import com.nf.easybuy.domain.Product;
import com.nf.easybuy.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("Car")
public class CarController {
    private static final long serialVersionUID = 1L;

    @Autowired
    private ProductService productService;

    //获取json转换成的List集合
  /*  @RequestMapping(value = "getCars.do")*/
    private List<Car> getCars(HttpServletRequest request) throws IOException {
        Cookie[] cookies = request.getCookies();
        // 获取客户端传入过来的cookie
        for (Cookie cookie : cookies) {
            if ("car".equals(cookie.getName())) {
                //商品id:名称-路径-价格-数量  转成json格式的数据
                // 在cookie中查看该信息是否含有该商品
                String jsonVal = cookie.getValue();
                List<Car> cars = JSON.parseArray(URLDecoder.decode(jsonVal, "utf-8"), Car.class);
                return cars;
            }
        }
        return null;
    }


    //更新
    private void update(HttpServletRequest request, HttpServletResponse response,String addQuantity,String productId ,String updateQuantity) throws ServletException, IOException {

        //获取当前的cookie对象
        List<Car> cars = getCars(request);

        Cookie cookie = new Cookie("car", "");
        cookie.setMaxAge(60*60);
        boolean flag = false;
        if (cars != null) {
            // 遍历集合
            for (Iterator<Car> iterator = cars.iterator(); iterator.hasNext();) {




                Car singerCar = iterator.next();
                if (Integer.parseInt(productId) == singerCar.getId()) {
                    int quan = 0;

                    if(addQuantity != null) {
                        quan = singerCar.getQuantity() + Integer.parseInt(addQuantity);
                    }
                    if(updateQuantity != null) {
                        quan = Integer.parseInt(updateQuantity);
                    }


                    //如果计算数量小于0 ， 移除该商品
                    if(quan <= 0) {
                        cars.remove(singerCar);
                        // 将list集合封装成json格式的字符串
                        String jsonArr = JSON.toJSONString(cars);
                        jsonArr = URLEncoder.encode(jsonArr, "utf-8");
                        cookie.setValue(jsonArr);
                        response.addCookie(cookie);
                        response.getWriter().print(URLDecoder.decode(jsonArr, "utf-8"));
                        return;
                    }

                    singerCar.setQuantity(quan);
//					singerCar.setSubtotal(singerCar.getSubtotal() + (singerCar.getPrice() * singerCar.getQuantity()));
                    singerCar.setSubtotal(singerCar.getPrice() * singerCar.getQuantity());
                    flag = true;
                }
            }


        } else {
            cars = new ArrayList<>();
        }

        if (!flag) {  //cookie中不存在该商品
            // 通过id获取到该商品的所有的信息
            Product product = productService.getProductById(0,Integer.parseInt(productId));
            // 将该对象封装到Car中
            Car car = new Car();
            car.setId(Integer.parseInt(productId));
            car.setName(product.getName());
            car.setQuantity(Integer.parseInt(addQuantity));
            car.setImgPath(product.getFileName());
            car.setPrice(product.getPrice());
            car.setSubtotal(Integer.parseInt(addQuantity) * product.getPrice());
            cars.add(car);
        }

        // 将list集合封装成json格式的字符串
        String jsonArr = JSON.toJSONString(cars);
        jsonArr = URLEncoder.encode(jsonArr, "utf-8");
        cookie.setValue(jsonArr);
        response.addCookie(cookie);
        System.out.println(URLDecoder.decode(jsonArr, "utf-8"));
        response.getWriter().print(URLDecoder.decode(jsonArr, "utf-8"));

    }

    // 在购物车中添加商品
    // 添加
    @RequestMapping("carAdd.do")
    private void carAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String quantity = request.getParameter("quantity"); // 需要添加的商品数量
        String productId = request.getParameter("productId"); // 商品id

        // 判断该数据是否合法
        if (quantity == null || "".equals(quantity)) {
            System.out.println("数据不能为空");
            return;
        }
        if (productId == null || "".equals(quantity)) {
            System.out.println("数据不能为空");
            return;
        }

        update(request, response, quantity, productId, null);
        return;
    }


/*    // 获取Cookie中的数据。并转换成List集合
    @RequestMapping("getCar.do")
    private void getCar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie cookie = null;
        Cookie[] cookies = request.getCookies();
        for (Cookie c : cookies) {
            if ("car".equals(c.getName())) {
                cookie = c;
            }
        }
        if (cookie == null || "".equals(cookie.getValue().trim())) {
            response.getWriter().print(false);
            // 无数据
            return;
        }
        // 获取数据，并转换成json数据
        String jsonVal = cookie.getValue();
        response.getWriter().print(URLDecoder.decode(jsonVal, "utf-8"));
        return;
    }*/

    // 获取Cookie中的数据。并转换成List集合
    @RequestMapping(value = "getCar.do",produces = "application/json;charset=UTF-8")
    @ResponseBody
    private String getCar(@CookieValue("car") String carCookie) {
        return carCookie;
    }


    //清空购物车 ，方法
    @RequestMapping("clearCarMethod.do")
    private boolean clearCarMethod(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        for (Cookie c : cookies) {
            if ("car".equals(c.getName())) {
                c.setValue(null);
                response.addCookie(c);
                return true;
            }
        }
        return false;
    }


    //清空购物车
    @RequestMapping("clearCar.do")
    private void clearCar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print(clearCarMethod(request, response));
        return;
    }

    //输入更新
    @RequestMapping("inputUpdate.do")
    private void inputUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String quantity = request.getParameter("quantity"); // 需要添加的商品数量
        String productId = request.getParameter("productId"); // 商品id

        // 判断该数据是否合法
        if (quantity == null || "".equals(quantity)) {
            System.out.println("数据不能为空");
            return;
        }
        if (productId == null || "".equals(quantity)) {
            System.out.println("数据不能为空");
            return;
        }

        update(request, response, null, productId, quantity);

        return;
    }


    // 结算购物车 步骤1
    @RequestMapping("settleAccountsOne.do")
    private void settleAccountsOne(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Car> cars = getCars(request);
        if (cars == null) {
            //提示购物车为空，继续购物
            response.getWriter().write("购物车为空，3秒内跳转至首页继续购物");
            response.setHeader("refresh", "3;url=" + request.getContextPath() + "/index.jsp");
            return;
        }

        float money = 0;
        float subtotal = 0;
        for (Car car : cars) {
            float price = car.getPrice();
            int quantity = car.getQuantity();
            subtotal = price * quantity;
            car.setSubtotal(subtotal);
            money += subtotal;
        }

        request.setAttribute("money", money);
        request.setAttribute("cars", cars);
        String jsonArr = JSON.toJSONString(cars);
        jsonArr = URLEncoder.encode(jsonArr, "utf-8");
        Cookie cookie = new Cookie("car", "");
        cookie.setValue(jsonArr);
        response.addCookie(cookie);
        response.getWriter().print(URLDecoder.decode(jsonArr, "utf-8"));
        request.getRequestDispatcher("/WEB-INF/jsp/BuyCarOne.jsp").forward(request, response);
        return;
    }

    // 结算购物车 步骤2  处理订单 注意：本次修改需要修改订单状态表，。。。。。
    @RequestMapping("settleAccountsTwoHandler.do")
    private void settleAccountsTwoHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie cookie = null;
        Cookie[] cookies = request.getCookies();
        for (Cookie c : cookies) {
            if ("car".equals(c.getName())) {
                cookie = c;
            }
        }

        //System.out.println("cookie = "  + URLDecoder.decode(cookie.getValue(),"utf-8"));

        if (cookie == null || "[]".equals(URLDecoder.decode(cookie.getValue(), "utf-8").trim())) {
            response.getWriter().write("购物车为空，3秒内跳转至首页继续购物");
            response.setHeader("refresh", "3;url=" + request.getContextPath() + "/index.jsp");
            // 无数据
            return;
        }
        // 获取数据，并转换成json数据
        String jsonVal = cookie.getValue();
        List<Car> cars = JSON.parseArray(URLDecoder.decode(jsonVal, "utf-8"), Car.class);

        if (request.getSession(false).getAttribute("user") != null) {
            clearCarMethod(request, response);
        }
        request.getSession().setAttribute("cars", cars);
        response.sendRedirect(request.getContextPath() + "/Order/settleAccountsTwo.do");
        return;

    }
}
