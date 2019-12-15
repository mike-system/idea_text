package com.nf.easybuy.handler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;
@Controller
public class PictureCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private int width = 120;
	private int height = 30;

	public PictureCodeServlet() {
		super();
	}
	@RequestMapping("PictureCodeServlet.do")
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 设置图片的宽高
		BufferedImage bi = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics graphics = bi.getGraphics();

		// 设置背景色
		setBackGround(graphics);

		// 设置边框
		setBorder(graphics);

		// 设置字体
		String code = setMyFont(graphics);
		
		//将图片代码存入session中
		request.getSession().setAttribute("picCode", code);
		

		// 设置随机线
		setRandomLine(graphics);

		// 将图片传递给浏览器
		response.setHeader("Content-type", "image/jpeg");
		ImageIO.write(bi, "png", response.getOutputStream());
		

	}
	//设置干扰线
	private void setRandomLine(Graphics graphics) {
		for(int i = 0 ;i < 10; i++) {
			
			Random r1 = new Random();
			int x1 = r1.nextInt(width);
			int y1 = r1.nextInt(height);
			int x2 = r1.nextInt(width);
			int y2 = r1.nextInt(height);
			
			graphics.setColor(Color.black);
			graphics.drawLine(x1,y1 , x2, y2);
		}
	}

	// 设置字体
	@SuppressWarnings("unused")
	private String setMyFont(Graphics graphics) {
		Graphics2D graphics2 = (Graphics2D) graphics;
		Font f = new Font("宋体", Font.PLAIN, 24);
		graphics2.setColor(Color.BLUE);
		graphics2.setFont(f);
		StringBuffer str = new StringBuffer();
		// 产生随机验证码
		for (int i = 0; i < 4; i++) {
			String char1 = (char) ('A' + (int) (Math.random() * 26)) + "";
			
			String char2 = (int) (Math.random() * 10) + "";
			double d = Math.random()*30*Math.PI/180;
			graphics2.rotate(d,26*i +20,12);
			if(i%2==0) {
				graphics2.drawString(char1, 26*i +12, 25);
				str.append(char1);
			}else {
				graphics2.drawString(char2, 26*i +12, 25);
				str.append(char2);
			}
			
			//设置图片的旋转
			graphics2.rotate(-d,26*i +20,12);
		}
		
		
		if(str != null)
			return str.toString();
		return null;
	}
	//设置边框
	private void setBorder(Graphics graphics) {
		graphics.setColor(Color.black);
		graphics.drawRect(1, 1, width-3, height-3);
	}
	//设置背景色
	private void setBackGround(Graphics graphics) {
		graphics.setColor(Color.white);
		graphics.fillRect(0, 0, 120, 30);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);

	}

}
