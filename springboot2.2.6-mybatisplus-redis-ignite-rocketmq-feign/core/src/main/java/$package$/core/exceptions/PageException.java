/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PageException extends BaseException implements Serializable {
    public PageException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PageException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PageException(String message) {
        super(message);
    }

    public PageException(String message, Throwable cause) {
        super(message, cause);
    }
}
