/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerLotteryException extends BaseException implements Serializable {
    public PlayerLotteryException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerLotteryException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerLotteryException(String message) {
        super(message);
    }

    public PlayerLotteryException(String message, Throwable cause) {
        super(message, cause);
    }
}
