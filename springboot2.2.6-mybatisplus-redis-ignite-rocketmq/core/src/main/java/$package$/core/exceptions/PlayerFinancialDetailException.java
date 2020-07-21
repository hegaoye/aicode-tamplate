/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerFinancialDetailException extends BaseException implements Serializable {
    public PlayerFinancialDetailException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerFinancialDetailException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerFinancialDetailException(String message) {
        super(message);
    }

    public PlayerFinancialDetailException(String message, Throwable cause) {
        super(message, cause);
    }
}
