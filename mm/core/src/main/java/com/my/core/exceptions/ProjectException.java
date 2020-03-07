/*
 * mm
 */
package com.my.core.exceptions;

import java.io.Serializable;

public class ProjectException extends BaseException implements Serializable {
    public ProjectException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public ProjectException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public ProjectException(String message) {
        super(message);
    }

    public ProjectException(String message, Throwable cause) {
        super(message, cause);
    }
}
