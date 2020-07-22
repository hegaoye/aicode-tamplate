/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerException extends BaseException implements Serializable {
    public PlayerException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerException(String message) {
        super(message);
    }

    public PlayerException(String message, Throwable cause) {
        super(message, cause);
    }
}
