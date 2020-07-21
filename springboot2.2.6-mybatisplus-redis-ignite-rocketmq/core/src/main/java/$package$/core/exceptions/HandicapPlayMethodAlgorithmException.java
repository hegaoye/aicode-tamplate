/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class HandicapPlayMethodAlgorithmException extends BaseException implements Serializable {
    public HandicapPlayMethodAlgorithmException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public HandicapPlayMethodAlgorithmException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public HandicapPlayMethodAlgorithmException(String message) {
        super(message);
    }

    public HandicapPlayMethodAlgorithmException(String message, Throwable cause) {
        super(message, cause);
    }
}
