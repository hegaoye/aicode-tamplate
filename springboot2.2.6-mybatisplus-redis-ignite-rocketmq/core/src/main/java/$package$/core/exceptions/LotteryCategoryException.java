/*
 * $copyright$
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class LotteryCategoryException extends BaseException implements Serializable {
    public LotteryCategoryException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public LotteryCategoryException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public LotteryCategoryException(String message) {
        super(message);
    }

    public LotteryCategoryException(String message, Throwable cause) {
        super(message, cause);
    }
}
