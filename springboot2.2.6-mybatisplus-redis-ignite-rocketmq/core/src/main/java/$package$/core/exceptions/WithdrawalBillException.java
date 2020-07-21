/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class WithdrawalBillException extends BaseException implements Serializable {
    public WithdrawalBillException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public WithdrawalBillException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public WithdrawalBillException(String message) {
        super(message);
    }

    public WithdrawalBillException(String message, Throwable cause) {
        super(message, cause);
    }
}
