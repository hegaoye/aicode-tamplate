/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class MenuException extends BaseException implements Serializable {
    public MenuException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public MenuException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public MenuException(String message) {
        super(message);
    }

    public MenuException(String message, Throwable cause) {
        super(message, cause);
    }
}
