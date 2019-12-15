package com.nf.easybuy.exception;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-15
 * Time: 0:57
 */
public class PageRuntimeException extends RuntimeException {
    public PageRuntimeException() {
        super();
    }

    public PageRuntimeException(String message) {
        super(message);
    }
}
