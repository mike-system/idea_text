package com.nf.easybuy.handler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("UserHome")
public class UserHomeController{
	private static final long serialVersionUID = 1L;

	// 用户中心
	@RequestMapping("userCenter.do")
	private String userCenter()  {
		return "MemberUser";
	}
	// 安全中心
	@RequestMapping("userMemberSafe.do")
	private String userMemberSafe() {
		return "MemberSafe";
	}

}
