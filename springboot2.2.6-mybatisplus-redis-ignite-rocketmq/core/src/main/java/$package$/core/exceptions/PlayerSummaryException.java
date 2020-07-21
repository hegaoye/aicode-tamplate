/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerSummaryException extends BaseException implements Serializable {
    public PlayerSummaryException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerSummaryException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerSummaryException(String message) {
        super(message);
    }

    public PlayerSummaryException(String message, Throwable cause) {
        super(message, cause);
    }
}
