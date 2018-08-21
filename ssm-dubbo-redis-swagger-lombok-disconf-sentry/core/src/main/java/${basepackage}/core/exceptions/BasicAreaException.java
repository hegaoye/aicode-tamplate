package com.rzhkj.core.exceptions;

public class BasicAreaException extends BaseException {

    public BasicAreaException(ExceptionMessage exceptionMessage) {
        super(exceptionMessage);
    }

    public BasicAreaException(ExceptionMessage exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public BasicAreaException(String message) {
        super(message);
    }

    public BasicAreaException(String message, Throwable cause) {
        super(message, cause);
    }
}
