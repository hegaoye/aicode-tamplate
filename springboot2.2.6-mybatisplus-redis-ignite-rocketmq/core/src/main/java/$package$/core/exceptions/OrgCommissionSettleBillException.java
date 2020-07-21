/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrgCommissionSettleBillException extends BaseException implements Serializable {
    public OrgCommissionSettleBillException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrgCommissionSettleBillException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrgCommissionSettleBillException(String message) {
        super(message);
    }

    public OrgCommissionSettleBillException(String message, Throwable cause) {
        super(message, cause);
    }
}
