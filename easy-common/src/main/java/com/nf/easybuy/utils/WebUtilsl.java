package com.nf.easybuy.utils;

import sun.misc.BASE64Encoder;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class WebUtilsl {
	
	//md5加密
	public static String str2me5(String target) {
		
		try {
			MessageDigest md = MessageDigest.getInstance("md5");
			byte md5[] = md.digest(target.getBytes());
			
			BASE64Encoder encoder = new BASE64Encoder();
			return encoder.encode(md5);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
        return null;
    }
	
}
