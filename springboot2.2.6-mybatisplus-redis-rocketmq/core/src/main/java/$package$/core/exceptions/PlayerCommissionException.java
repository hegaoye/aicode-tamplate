/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerCommissionException extends BaseException implements Serializable {
    public PlayerCommissionException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerCommissionException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerCommissionException(String message) {
        super(message);
    }

    public PlayerCommissionException(String message, Throwable cause) {
        super(message, cause);
    }
}
