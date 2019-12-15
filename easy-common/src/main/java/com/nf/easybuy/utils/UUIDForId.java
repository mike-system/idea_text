package com.nf.easybuy.utils;
import java.util.UUID;

public class UUIDForId {
	public static String getUUID() {
		String uuid = UUID.randomUUID().toString();
		return uuid.replaceAll("-", "");
	}
}