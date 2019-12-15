package com.nf.easybuy.exception;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-12
 * Time: 14:53
 */
public class DatabaseDataRuntimeException extends RuntimeException {
    public DatabaseDataRuntimeException() {
        super();
    }

    public DatabaseDataRuntimeException(String message) {
        super(message);
    }
}
