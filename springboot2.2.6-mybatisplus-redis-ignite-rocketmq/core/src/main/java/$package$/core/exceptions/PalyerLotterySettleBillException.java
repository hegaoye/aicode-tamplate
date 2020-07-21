/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PalyerLotterySettleBillException extends BaseException implements Serializable {
    public PalyerLotterySettleBillException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PalyerLotterySettleBillException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PalyerLotterySettleBillException(String message) {
        super(message);
    }

    public PalyerLotterySettleBillException(String message, Throwable cause) {
        super(message, cause);
    }
}
