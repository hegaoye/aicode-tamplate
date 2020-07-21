/*
* 投注项统计
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class BetOptionOrgStatisticsException extends BaseException implements Serializable {
    public BetOptionOrgStatisticsException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public BetOptionOrgStatisticsException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public BetOptionOrgStatisticsException(String message) {
        super(message);
    }

    public BetOptionOrgStatisticsException(String message, Throwable cause) {
        super(message, cause);
    }
}
