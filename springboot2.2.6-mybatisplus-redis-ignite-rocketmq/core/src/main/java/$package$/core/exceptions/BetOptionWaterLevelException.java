/*
 * $copyright$
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class BetOptionWaterLevelException extends BaseException implements Serializable {
    public BetOptionWaterLevelException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public BetOptionWaterLevelException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public BetOptionWaterLevelException(String message) {
        super(message);
    }

    public BetOptionWaterLevelException(String message, Throwable cause) {
        super(message, cause);
    }
}
