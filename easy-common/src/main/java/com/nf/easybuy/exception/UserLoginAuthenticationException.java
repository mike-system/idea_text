package com.nf.easybuy.exception;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-11
 * Time: 23:45
 */
public class UserLoginAuthenticationException extends RuntimeException {
    public UserLoginAuthenticationException() {
        super();
    }

    public UserLoginAuthenticationException(String message) {
        super(message);
    }
}
