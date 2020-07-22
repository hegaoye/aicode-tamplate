/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrderException extends BaseException implements Serializable {
    public OrderException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrderException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrderException(String message) {
        super(message);
    }

    public OrderException(String message, Throwable cause) {
        super(message, cause);
    }
}
