package com.nf.easybuy.exception;

public class NotFindOrderRuntimeException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public NotFindOrderRuntimeException() {
		super();
	}

	public NotFindOrderRuntimeException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public NotFindOrderRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

	public NotFindOrderRuntimeException(String message) {
		super(message);
	}

	public NotFindOrderRuntimeException(Throwable cause) {
		super(cause);
	}
	
}
