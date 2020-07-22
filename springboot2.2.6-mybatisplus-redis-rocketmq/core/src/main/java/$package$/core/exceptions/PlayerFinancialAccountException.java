/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerFinancialAccountException extends BaseException implements Serializable {
    public PlayerFinancialAccountException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerFinancialAccountException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerFinancialAccountException(String message) {
        super(message);
    }

    public PlayerFinancialAccountException(String message, Throwable cause) {
        super(message, cause);
    }
}
