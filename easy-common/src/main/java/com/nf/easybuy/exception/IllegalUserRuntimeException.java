package com.nf.easybuy.exception;

/**
 * Created with IntelliJ IDEA.
 * Description: 非法用户异常，强制关闭当前线程
 * User: nongfu 农夫
 * Date: 2019-11-12
 * Time: 13:42
 */
public class IllegalUserRuntimeException extends RuntimeException {

    public IllegalUserRuntimeException() {
        super();
    }

    public IllegalUserRuntimeException(String message) {
        super(message);
    }
}
