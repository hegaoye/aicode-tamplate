/*
 * $copyright$
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayMethodException extends BaseException implements Serializable {
    public PlayMethodException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayMethodException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayMethodException(String message) {
        super(message);
    }

    public PlayMethodException(String message, Throwable cause) {
        super(message, cause);
    }
}
