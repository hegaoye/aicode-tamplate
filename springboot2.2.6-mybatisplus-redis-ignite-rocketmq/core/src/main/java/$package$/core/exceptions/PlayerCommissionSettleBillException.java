/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerCommissionSettleBillException extends BaseException implements Serializable {
    public PlayerCommissionSettleBillException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerCommissionSettleBillException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerCommissionSettleBillException(String message) {
        super(message);
    }

    public PlayerCommissionSettleBillException(String message, Throwable cause) {
        super(message, cause);
    }
}
