/*
 * ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerLotteryCombinationOptionException extends BaseException implements Serializable {
    public PlayerLotteryCombinationOptionException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerLotteryCombinationOptionException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerLotteryCombinationOptionException(String message) {
        super(message);
    }

    public PlayerLotteryCombinationOptionException(String message, Throwable cause) {
        super(message, cause);
    }
}
