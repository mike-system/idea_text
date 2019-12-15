package com.nf.easybuy.exception;

/**
 * Created with IntelliJ IDEA.
 * Description: 类型不匹配异常
 * User: nongfu 农夫
 * Date: 2019-11-11
 * Time: 21:52
 */
public class TypeMatchingException extends RuntimeException {
    public TypeMatchingException() {
    }

    public TypeMatchingException(String message) {
        super(message);
    }
}
