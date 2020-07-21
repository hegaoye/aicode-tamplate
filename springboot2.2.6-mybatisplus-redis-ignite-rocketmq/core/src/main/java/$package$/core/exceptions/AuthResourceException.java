/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class AuthResourceException extends BaseException implements Serializable {
    public AuthResourceException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public AuthResourceException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public AuthResourceException(String message) {
        super(message);
    }

    public AuthResourceException(String message, Throwable cause) {
        super(message, cause);
    }
}
