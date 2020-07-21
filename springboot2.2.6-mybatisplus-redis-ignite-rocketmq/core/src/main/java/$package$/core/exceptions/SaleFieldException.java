/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class SaleFieldException extends BaseException implements Serializable {
    public SaleFieldException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public SaleFieldException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public SaleFieldException(String message) {
        super(message);
    }

    public SaleFieldException(String message, Throwable cause) {
        super(message, cause);
    }
}
