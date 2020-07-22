/*
 * $copyright$
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayMethodCategoryException extends BaseException implements Serializable {
    public PlayMethodCategoryException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayMethodCategoryException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayMethodCategoryException(String message) {
        super(message);
    }

    public PlayMethodCategoryException(String message, Throwable cause) {
        super(message, cause);
    }
}
