package com.nf.easybuy.exception;

public class AccountRuntimeException extends RuntimeException{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public AccountRuntimeException() {
		super();
	}

	public AccountRuntimeException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public AccountRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

	public AccountRuntimeException(String message) {
		super(message);
	}

	public AccountRuntimeException(Throwable cause) {
		super(cause);
	}
	
	
}
