/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerAccountException extends BaseException implements Serializable {
    public PlayerAccountException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerAccountException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerAccountException(String message) {
        super(message);
    }

    public PlayerAccountException(String message, Throwable cause) {
        super(message, cause);
    }
}
