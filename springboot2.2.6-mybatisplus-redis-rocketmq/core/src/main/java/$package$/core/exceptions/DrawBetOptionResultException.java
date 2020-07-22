/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class DrawBetOptionResultException extends BaseException implements Serializable {
    public DrawBetOptionResultException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public DrawBetOptionResultException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public DrawBetOptionResultException(String message) {
        super(message);
    }

    public DrawBetOptionResultException(String message, Throwable cause) {
        super(message, cause);
    }
}
