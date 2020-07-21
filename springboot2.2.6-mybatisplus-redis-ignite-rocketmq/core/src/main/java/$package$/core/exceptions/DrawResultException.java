/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class DrawResultException extends BaseException implements Serializable {
    public DrawResultException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public DrawResultException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public DrawResultException(String message) {
        super(message);
    }

    public DrawResultException(String message, Throwable cause) {
        super(message, cause);
    }
}
