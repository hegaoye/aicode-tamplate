/*
 * $copyright$
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayMethodAlgorithmException extends BaseException implements Serializable {
    public PlayMethodAlgorithmException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayMethodAlgorithmException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayMethodAlgorithmException(String message) {
        super(message);
    }

    public PlayMethodAlgorithmException(String message, Throwable cause) {
        super(message, cause);
    }
}
