package com.nf.easybuy.exception;

/**
 * Created with IntelliJ IDEA.
 * Description: 购物车为空异常，抛出异常，让程序进行抓获，并处理该异常
 * User: nongfu 农夫
 * Date: 2019-11-12
 * Time: 13:33
 */
public class CarIsNullRuntimeException extends RuntimeException {
    public CarIsNullRuntimeException() {
        super();
    }

    public CarIsNullRuntimeException(String message) {
        super(message);
    }
}
