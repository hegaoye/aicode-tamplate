/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class CommissionSettleBillException extends BaseException implements Serializable {
    public CommissionSettleBillException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public CommissionSettleBillException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public CommissionSettleBillException(String message) {
        super(message);
    }

    public CommissionSettleBillException(String message, Throwable cause) {
        super(message, cause);
    }
}
