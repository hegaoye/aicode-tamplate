/*
 * $copyright$
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class BetOptionAutoReduceOddsException extends BaseException implements Serializable {
    public BetOptionAutoReduceOddsException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public BetOptionAutoReduceOddsException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public BetOptionAutoReduceOddsException(String message) {
        super(message);
    }

    public BetOptionAutoReduceOddsException(String message, Throwable cause) {
        super(message, cause);
    }
}
