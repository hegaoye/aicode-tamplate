/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrgFinancialDetailException extends BaseException implements Serializable {
    public OrgFinancialDetailException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrgFinancialDetailException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrgFinancialDetailException(String message) {
        super(message);
    }

    public OrgFinancialDetailException(String message, Throwable cause) {
        super(message, cause);
    }
}
