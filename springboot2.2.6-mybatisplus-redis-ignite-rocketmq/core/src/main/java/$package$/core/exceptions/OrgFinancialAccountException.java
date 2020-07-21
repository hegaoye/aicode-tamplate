/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrgFinancialAccountException extends BaseException implements Serializable {
    public OrgFinancialAccountException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrgFinancialAccountException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrgFinancialAccountException(String message) {
        super(message);
    }

    public OrgFinancialAccountException(String message, Throwable cause) {
        super(message, cause);
    }
}
