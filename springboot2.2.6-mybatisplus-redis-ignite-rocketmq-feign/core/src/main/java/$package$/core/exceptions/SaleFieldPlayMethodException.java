/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class SaleFieldPlayMethodException extends BaseException implements Serializable {
    public SaleFieldPlayMethodException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public SaleFieldPlayMethodException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public SaleFieldPlayMethodException(String message) {
        super(message);
    }

    public SaleFieldPlayMethodException(String message, Throwable cause) {
        super(message, cause);
    }
}
