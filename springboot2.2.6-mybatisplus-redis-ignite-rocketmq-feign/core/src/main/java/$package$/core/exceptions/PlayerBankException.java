/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerBankException extends BaseException implements Serializable {
    public PlayerBankException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerBankException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerBankException(String message) {
        super(message);
    }

    public PlayerBankException(String message, Throwable cause) {
        super(message, cause);
    }
}
